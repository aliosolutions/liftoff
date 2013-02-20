Artist = require('../models').Artist
secret = require('../secret.coffee')
authToken = secret.authToken
stripeKey = secret.stripe
_ = require 'underscore'
stripe = require('stripe') stripeKey
DAY = 86400000

artistCtrl = module.exports = 
	read: (req, res)=>
		id = req.param('id')
		console.log "Reading id: #{id}"
		Artist.findById id, (err, artist) =>
			if err? then res.send err
			else
				res.send artist

	create: (req, res)=>
		if req.body.authToken isnt authToken
			res.send "Unauthorized"
		else
			console.log "Authed, creating new artist"
			artist = new Artist
				name: req.body.name
				description: req.body.description
				image: req.body.image

			artist.save((err)=>
				if err? 
					console.log "Error: #{err}" 
					res.send "#{err}" 
				else 
					console.log "Successfully created artist"
					res.send artist
			)

	update: (req, res)=>
		# this function has two purposes: if an authToken is supplied, it is used to add shows.
		# if no auth token is supplied, it is used to place orders by customers.
		id = req.param('id')

		Artist.findById id, (err, artist) =>
			if err? or not artist? then res.send err
			else if artist?
				if not req.body.authToken?
					console.log "Customer is placing order"
				
					####
					guest = 
						name: req.body.name
						email: req.body.email
						serializedToken: JSON.stringify(req.body.token)
						numTickets: req.body.quantity
					show = _.find artist.shows, (s)=> if s.city is req.body.city then return true else return false
					if show?
						console.log show.guests
						show.ticketsSold += guest.numTickets
						show.guests.push guest

					####
				else if req.body.authToken is authToken
					show = 			
						price: req.body.price
						city: req.body.city
						ticketsGoal: req.body.ticketsGoal
						liftoffDate: Date.now() + req.body.duration * DAY
						ticketsSold: 0
					artist.shows.push show
				artist.save (err) =>
					if err? then res.send err else res.send artist

	billShow: (show) =>
		for guest in show.guests
			stripe.charges.create
				amount: guest.numTickets * show.price
				currency: 'usd'
				card: JSON.parse(guest.serializedToken).id
			, (err, customer)=>
				if not err? then console.log "Billed a customer!"

	billAllBillableShows: ()=>
		console.log "Attempting to bill shows.."
		Artist.find {}, null, null, (err, docs)=>
			for artist in docs
				for show in artist.shows
					if not show.billed
						if show.ticketsSold >= show.ticketsGoal
							console.log "Found a show that's sold enough tickets"
							if new Date(show.liftoffDate) < Date.now() and new Date(show.liftoffDate) + DAY > Date.now()
								## then bill show and set it to billed, then save artist
								artistCtrl.billShow show
								console.log "Billed a show!!"
								show.billed = true
								artist.save()

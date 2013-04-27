Artist = require('../models').Artist
mailer = require '../app/mail.coffee'
authToken = process.env.authToken
stripeKey = process.env.stripe
_ = require 'underscore'
stripe = require('stripe') stripeKey
DAY = 86400000

artistCtrl = module.exports = 
	readByName: (req, res)=>
		# expect artist name with underscores in place of spaces. Case-sensitive.
		name = req.param('name')
		name = name.replace(/_/g, ' ')
		console.log "Reading artist: #{name}"
		Artist.findOne {name: name}, '-guests', (err, doc) ->
			if err? then res.send err
			else
				res.send doc

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
		console.log req.param('artist')
		console.log "correct auth token: #{authToken}, given authToken: #{req.body.authToken}"
		cb = (err, artist) =>
			if err? 
				res.send err
				console.log "Error: #{err}"
			if not artist?
				console.log "artist not found"
				res.send 'not found'
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
						mailer.sendPurchaseNotification(guest, artist, show)

					####
				else if req.body.authToken is authToken
					console.log "authed, adding a show."
					show = 			
						price: req.body.price
						city: req.body.city
						ticketsGoal: req.body.ticketsGoal
						liftoffDate: Date.now() + req.body.duration * DAY
						ticketsSold: 0
					artist.shows.push show
				artist.save (err) =>
					if err? then res.send err else res.send artist
		console.log req.param('id')
		Artist.findOne({name: req.param('artist')}, cb) if  req.param('artist')?
		Artist.findById(req.param('id'), cb) if req.param('id')?

	billShow: (show) =>
		for guest in show.guests
			stripe.charges.create
				amount: guest.numTickets * show.price
				currency: 'usd'
				card: JSON.parse(guest.serializedToken).id
			, (err, customer)=>
				if not err? then console.log "Billed a customer!"

	billAllBillableShows: ()=>
		Artist.find {}, null, null, (err, docs)=>
			for artist in docs
				for show in artist.shows
					if not show.billed
						if show.ticketsSold >= show.ticketsGoal
							if new Date(show.liftoffDate) < Date.now() and new Date(show.liftoffDate) + DAY > Date.now()
								## then bill show and set it to billed, then save artist
								artistCtrl.billShow show
								console.log "Billed a show!!"
								show.billed = true
								artist.save()

	mostRecent: (req, res) =>
		Artist.find()
		.sort({$natural: -1})
		.limit(req.param('num'))
		.exec (err, doc)->
			res.send(doc or err)
		
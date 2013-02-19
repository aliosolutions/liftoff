Artist = require('../models').Artist
authToken = require('../secret.coffee').authToken
_ = require 'underscore'
DAY = 86400000
module.exports = 
	read: (req, res)=>
		id = req.param('id')
		console.log "Reading id: #{id}"
		Artist.findById id, (err, artist) =>
			if err? then res.send err
			else res.send artist

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
					res.send "Success"
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


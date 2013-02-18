Artist = require('../models').Artist
authToken = require('../secret.coffee').authToken
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
		if not req.body.authToken?
			console.log "Customer is placing order"

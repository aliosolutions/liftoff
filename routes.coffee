
controllers = require './controllers'
module.exports = (app) ->

	app.get '/artist/:id', controllers.artist.read
	app.post '/artist', controllers.artist.create
	app.put '/artist/:id', controllers.artist.update
	#other routes above here
	app.get '*', (req, res) ->
		res.redirect '/'
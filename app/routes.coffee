
controllers = require '../controllers'
module.exports = (app) ->

	app.get '/artist/:id', controllers.artist.read
	app.post '/artist', controllers.artist.create
	app.put '/artist/:id', controllers.artist.update

	app.get '/mostrecent/:num', controllers.artist.mostRecent
	app.get '/a/:name', controllers.artist.readByName

	app.post '/contact', controllers.mail.sendMail
	#other routes above here
	app.get '*', (req, res) ->
		res.redirect '/'
module.exports = (app) ->

	#other routes above here
	app.get '*', (req, res) ->
		res.redirect '/'
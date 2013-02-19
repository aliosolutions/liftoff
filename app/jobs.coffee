contollers = require '../controllers'
config = require '../config.coffee'

module.exports = (app)->
	setInterval(()=>
		controllers.artist.billAllBillableShows()
		, config.billInterval)
secret = require './secret'
module.exports =
	port: 3000
	mongoUri: "mongodb://#{secret.username}:#{secret.password}@linus.mongohq.com:10035/Liftoff"
	billInterval: 1000 * 60 * 60 # hour
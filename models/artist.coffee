mongoose = require 'mongoose'

Guest = mongoose.Schema
	name: String
	email: String
	numTickets: Number
	serializedToken: String

Show = mongoose.Schema
	city: String
	price: Number # in cents
	guests: [Guest]
	ticketsSold: Number
	ticketsGoal: Number
	liftoffDate: String
schema = mongoose.Schema
	name: 
		type: String
		index: 
			unique: true
	description: String
	image: String
	shows: [Show]
	
Artist = module.exports = mongoose.model('Artist', schema)	
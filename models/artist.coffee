mongoose = require 'mongoose'

Guest = 
	name: String
	email: String
	numTickets: Number

Show = 
	city: String
	price: Number # in cents
	guests: [Guest]
	ticketsSold: Number
	ticketsGoal: Number
	liftoffDate: Date
schema = mongoose.Schema
	name: String
	description: String
	image: String
	shows: [Show]
	
Artist = module.exports = mongoose.model('Artist', schema)	
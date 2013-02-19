mongoose = require 'mongoose'

Guest = mongoose.Schema
	name: String
	email: String
	numTickets: Number
	serializedToken: String

Show = mongoose.Schema
	city: String
	price: Number # in cents
	billed: 
		type: Boolean
		default: false
	guests: [Guest]
	ticketsSold: Number
	ticketsGoal: Number
	liftoffDate: Date
schema = mongoose.Schema
	name: 
		type: String
		index: 
			unique: true
	description: String
	image: String
	shows: [Show]
	
Artist = module.exports = mongoose.model('Artist', schema)	
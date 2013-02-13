mongoose = require 'mongoose'


schema = mongoose.Schema
	username: 
		type: String
		index: 
			unique: true
	email: String
	password: 
	
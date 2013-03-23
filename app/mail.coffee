
nodemailer = require 'nodemailer'

smtpTransport = nodemailer.createTransport "SMTP",
	service: "Gmail"
	auth: 
		user: process.env.emailAddress
		pass: process.env.emailPassword
mail = module.exports = 
	receivers: "justingough@aliosolutions.com, kepzorz@gmail.com"
	sendContactRequest: (args)->
		email = args.email
		name = args.name
		mailOpts = # test
			from: "Liftoff"
			to: mail.receivers
			subject: 'Liftoff contact request'
			text: "#{name} is interested in starting a Liftoff. Contact them at #{email}"

		smtpTransport.sendMail mailOpts, (error, response)-> console.log error, response

	sendPurchaseNotification: (guest, artist, show)->
		mailOpts = 
			from: 'Liftoff'
			to: mail.receivers
			subject: "A Liftoff event was backed!"
			text: "#{guest.name} has backed #{artist.name} in #{show.city}. #{guest.numTickets} ticket(s) at $#{show.price / 100} each"
		smtpTransport.sendMail mailOpts, (error, response)-> console.log error, response
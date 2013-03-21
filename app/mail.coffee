
nodemailer = require 'nodemailer'
secret = require '../secret.coffee'

smtpTransport = nodemailer.createTransport "SMTP",
	service: "Gmail"
	auth: 
		user: secret.email.address
		pass: secret.email.password
module.exports = 
	sendContactRequest: (args)->
		email = args.email
		name = args.name
		mailOpts = # test
			from: "Liftoff"
			to: "justingough@aliosolutions.com, kepzorz@gmail.com"
			subject: 'Liftoff contact request'
			text: "#{name} is interested in starting a Liftoff. Contact them at #{email}"

		smtpTransport.sendMail mailOpts, (error, response)-> console.log error, response

	sendPurchaseNotification: ()->
		
mailer = require '../app/mail.coffee'

mail = module.exports = 
	sendMail: (req, res)=>
		console.log "got sendmail post request"
		console.log req.body.name, req.body.email
		mailer.sendContactRequest
			name: req.body.name
			email: req.body.email
		res.send 'OK'
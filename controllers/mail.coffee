

mail = module.exports = 
	sendMail: (req, res)=>
		console.log "got sendmail post request"
		console.log req.body.name, req.body.email
		res.send 'OK'
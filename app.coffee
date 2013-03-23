express = require 'express'
config = require './config'
mongoose = require 'mongoose'

mongoose.connect process.env.mongoUri

app = express()
app.use express.bodyParser()
app.use express.static './static'

require('./app/routes.coffee') app
require('./app/jobs.coffee') app

port = process.env.PORT or config.port

app.listen port
console.log 'Server listening on port ' + port
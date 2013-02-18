express = require 'express'
config = require './config'
mongoose = require 'mongoose'

mongoose.connect config.mongoUri

app = express()
app.use express.bodyParser()
app.use express.static './static'

require('./routes.coffee') app

app.listen config.port
console.log 'Server listening on port ' + config.port
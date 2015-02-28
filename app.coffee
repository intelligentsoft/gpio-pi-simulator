require 'coffee-script/register'
express = require 'express'
config = require './server/config/config'
glob = require 'glob'
mongoose = require 'mongoose'

mongoose.connect config.db
db = mongoose.connection
db.on 'error', ->
  throw new Error 'unable to connect to database at ' + config.db

app = express()
require('./server/config/express')(app, config)
console.log 'create server on port', config.port
app.listen config.port

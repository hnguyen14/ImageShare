express = require 'express'
routes = require './routes'

app = module.exports = express.createServer()
io = require('socket.io').listen app

app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "coffee"
  app.register '.coffee', require('coffeekup').adapters.express
  app.use express.bodyParser
    uploadDir: '/Users/hnguyen/workspace/images'
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session
    secret: "your secret here"
  app.use app.router
  app.use express.static(__dirname + "/public")
  app.use require('connect-assets')()

app.configure "development", ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure "production", ->
  app.use express.errorHandler()

require('./routes/index')(app)
require('./socket/index')(io)

app.listen 3000

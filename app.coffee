express = require 'express'
routes = require './routes'

app = module.exports = express.createServer()
params = require 'express-params'
io = require('socket.io').listen app, {log: false}
passport = require './config/facebook-passport'
piler = require './config/piler'

params.extend app

app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "coffee"
  app.register '.coffee', require('coffeekup').adapters.express
  app.use express.bodyParser
    uploadDir: process.env.UPLOAD_DIR || '/tmp/images'
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session
    secret: "your secret here"
  app.use passport.initialize()
  app.use passport.session()
  app.use app.router
  app.use express.static(__dirname + "/public")
  piler.js.bind app
  piler.css.bind app

app.configure "development", ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure "production", ->
  app.use express.errorHandler()

require('./routes/index')(app)
require('./socket/index')(io)

app.dynamicHelpers
  passport: (req, res) ->
    data = {}
    data.user = req.user?.authHash
    return data
  js: -> piler.js
  css: -> piler.css

app.listen process.env.PORT || 3001

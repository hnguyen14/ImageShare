express = require 'express'
routes = require './routes'
app = module.exports = express.createServer()



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
  
app.configure "development", ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure "production", ->
  app.use express.errorHandler()

require('./routes/index')(app)

app.listen 3000

cradle = require 'cradle'

database = process.env.DATABASE
database += "_#{process.env.ENV}" unless process.env.ENV == 'production'

database = 'imageshare_development'

options =
  host: 'http://localhost'
  port: 5984
  cache: true

server = new (cradle.Connection)(options)

db = server.database database

module.exports = db
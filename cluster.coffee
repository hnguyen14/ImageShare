cluster = require 'cluster'
app = require './app'
db = require './config/cradle'
view = require './couchdb/view'

if cluster.isMaster
  view db
  for i in [0..3]
    cluster.fork()

  cluster.on 'death', (worker) ->
    console.log "worker #{worker.pid} died"
else
  app.listen 3000

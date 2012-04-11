cluster = require 'cluster'
app = require './app'

if cluster.isMaster
  for i in [0..3]
    cluster.fork()

  cluster.on 'death', (worker) ->
    console.log "worker #{worker.pid} died"
else
  app.listen 3000

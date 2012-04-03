db = require '../config/cradle'
Picture = require('../models/pictures')(db)

module.exports = (io) ->
  io.sockets.on 'connection', (socket) ->
    socket.on 'gallery:read', (data, callback) ->
      Picture.all callback


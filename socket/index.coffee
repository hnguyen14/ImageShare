db = require '../config/cradle'
Picture = require('../models/pictures')(db)

module.exports = (io) ->
  io.sockets.on 'connection', (socket) ->
    socket.on 'gallery:read', (data, callback) ->
      Picture.fetch data[0], callback

  Picture.on 'create', (picture) ->
    io.sockets.emit 'gallery:create', picture


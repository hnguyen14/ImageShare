db = require '../config/cradle'
Picture = require('../models/pictures')(db)

module.exports = (io) ->
  io.sockets.on 'connection', (socket) ->
    socket.on 'gallery:read', (data, callback) ->
      if data[0]?.tagId
        Picture.forTag data[0].tagId, callback
      else
        Picture.all callback

  Picture.on 'create', (picture) ->
    io.sockets.emit 'gallery:create', picture


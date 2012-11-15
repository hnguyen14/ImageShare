_ = require('underscore')._
db = require '../config/cradle'

Picture = require('../models/pictures')(db)
User = require('../models/users')(db)

module.exports = (io) ->
  io.sockets.on 'connection', (socket) ->

    socket.on 'user:read', (data, callback) ->
      User.findByFacebookId data.id, callback

    socket.on 'gallery:read', (data, callback) ->
      socket.leave room for room in io.sockets.manager.rooms
      if data[0]?.userId
        socket.join "user/#{data[0].userId}"
      else if data[0]?.tagId
        socket.join "tag/#{data[0].tagId}"
      else
        socket.join 'home'
      Picture.fetch data[0], callback

  Picture.on 'create', (picture) ->
    channels = ['home', "user/#{picture.user.id}"].concat ("tag/#{tag}" for tag in picture.tags)
    channels = _.uniq channels
    io.sockets.in(channel).emit('gallery:create', picture) for channel in channels


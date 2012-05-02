_ = require('underscore')._
twitter = require 'twitter-text'

EventEmitter = require('events').EventEmitter
emitter = new EventEmitter()

module.exports = (db) ->
  Picture =
    on: (event, listener) ->
      emitter.on event, listener

    fetch: (param, cb) ->
      view = 'Picture/all'
      if param?.tagId
        view = 'Picture/tag'
        defaultId = decodeURI(param.tagId)
      else if param?.userId
        view = 'Picture/user'
        defaultId = param.userId
      options =
        include_docs: true
        descending: true
        limit: 30
      if param?.startkey
        options.startkey = param.startkey
      else if defaultId
        options.startkey = [defaultId,{}]

      if options.startkey
        options.endkey = [defaultId] if defaultId

      db.view view, options, (err, res) ->
        return cb err if err
        pictures = []
        for result in res
          result.doc.key = result.key
          pictures.push result.doc
        cb null, pictures

    create: (user, fullsize, resized, thumbnail, caption, cb) ->
      doc =
        type: 'Picture'
        fullsizePath: "/images#{fullsize.substring(fullsize.lastIndexOf('/'), fullsize.length)}"
        resizedPath: "/images#{resized.substring(resized.lastIndexOf('/'), resized.length)}"
        thumbnailPath: "/images#{thumbnail.substring(thumbnail.lastIndexOf('/'), thumbnail.length)}"
        caption: caption
        tags: twitter.extractHashtags caption
        createdAt: new Date()
        updatedAt: new Date()

      if user
        doc.user =
          id: user.authHash.id
          displayName: user.authHash.displayName

      db.save doc, (err, res) ->
        return cb err if err
        doc._id = res.id
        doc._rev = res.rev
        emitter.emit 'create', doc
        cb null, doc if cb

  Picture

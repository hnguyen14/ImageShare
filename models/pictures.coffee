_ = require('underscore')._
twitter = require 'twitter-text'

EventEmitter = require('events').EventEmitter
emitter = new EventEmitter()

module.exports = (db) ->
  Picture =
    on: (event, listener) ->
      emitter.on event, listener

    all: (cb)->
      db.view 'Picture/all', {include_docs: true}, (err, pictures) ->
        return cb err if err
        cb null, (picture.doc for picture in pictures)

    forTag: (tagId, cb)->
      db.view 'Picture/tag', {key: tagId, include_docs: true}, (err, pictures) ->
        return cb err if err
        cb null, (picture.doc for picture in pictures)

    create: (path, caption, cb) ->
      doc =
        type: 'Picture'
        path: "/images/#{path.split('/')[5]}"
        caption: caption
        tags: twitter.extractHashtags caption
        createdAt: new Date()
        updatedAt: new Date()

      db.save doc, (err, res) ->
        return cb err if err
        doc._id = res.id
        doc._rev = res.rev
        emitter.emit 'create', doc
        cb null, doc if cb

  Picture

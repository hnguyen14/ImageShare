_ = require('underscore')._

module.exports = (db) ->
  Picture =
    all: (cb)->
      db.view 'Picture/all', {include_docs: true}, (err, pictures) ->
        return cb err if err
        cb null, (picture.doc for picture in pictures)

    create: (path, cb) ->
      doc =
        type: 'Picture'
        path: path
        createdAt: new Date()
        updatedAt: new Date()

      db.save doc, (err, res) ->
        return cb err if err
        doc._id = res.id
        doc._rev = res.rev
        cb null, doc if cb

  Picture

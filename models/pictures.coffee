_ = require('underscore')._

module.exports = (db) ->
  Picture =
    create: (path, cb) ->
      doc =
        path: path
        createdAt: new Date()
        updatedAt: new Date()

      db.save doc, (err, res) ->
        return cb err if err
        doc._id = res.id
        doc._rev = res.rev
        cb null, doc

  Picture

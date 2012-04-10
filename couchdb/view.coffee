async = require 'async'

module.exports = (db, done) ->
  async.parallel [
    (done) ->
      db.save '_design/Picture'
        all:
          map: (doc) ->
            if doc.type == 'Picture'
              emit doc._id, 1

        tag:
          map: (doc) ->
            if doc.type == 'Picture'
              for tag in doc.tags
                emit tag, _id: doc._id
      , done
    (done) ->
      db.save '_design/User'
        by_facebook_id:
          map: (doc) ->
            if doc.type == 'User'
              emit doc.authHash.id, _id: doc._id
      , done
  ], (err, res) ->
    if err
      console.log err
      throw err


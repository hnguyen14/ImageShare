async = require 'async'

module.exports = (db, done) ->
  async.parallel [
    (done) ->
      db.save '_design/Picture'
        all:
          map: (doc) ->
            if doc.type == 'Picture'
              emit doc._id, 1
      , done
  ], (err, res) ->
    if err
      console.log err
      throw err


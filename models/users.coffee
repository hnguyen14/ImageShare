module.exports = (db) ->
  User =
    findById: (id, cb) ->
      db.get id, (err, user) ->
        return err if err
        cb null, user

    findOrCreate: (profile, cb) ->
      User.findByFacebookId profile.id, profile, (err, user) ->
        return cb err if err
        cb null, user

    findByFacebookId: (facebookId, profile, cb) ->
      db.view 'User/by_facebook_id', include_docs: true, (err, res) ->
        return cb err if err
        if res[0]
          doc = res[0].doc
          doc.authHash = profile
          doc.updatedAt = new Date()
          db.save doc, (err, res) ->
            return cb err if err
            doc._rev = res.rev
            cb null, doc
        else
          doc =
            type: 'User'
            authHash: profile
            createdAt: new Date()
            updatedAt: new Date()
          db.save doc, (err, doc) ->
            return cb err if err
            doc._id = doc.id
            doc._rev = doc.rev
            cb null, doc
  User

db = require '../config/cradle'
Picture = require('../models/pictures')(db)

module.exports = (app) ->
  app.post '/pictures', (req, res, next) ->
    Picture.create req.files.upload.path, req.body.caption, (err, picture) ->
      res.redirect '/'

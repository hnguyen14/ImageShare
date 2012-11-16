db = require '../config/cradle'
fs = require 'fs'
im = require 'imagemagick'
async = require 'async'
cloudinary = require 'cloudinary'

Picture = require('../models/pictures')(db)

module.exports = (app) ->
  app.post '/pictures', (req, res, next) ->
    cloudinary.uploader.upload req.files.upload.path, (result) ->
      if result.public_id
        thumbnail = cloudinary.url("#{result.public_id}.#{result.format}", width: 270)
        resized = cloudinary.url("#{result.public_id}.#{result.format}", width: 750)
        Picture.create req.user, result.url, resized, thumbnail, req.body.caption, (err, picture) ->
          res.redirect '/'
      else
        console.log 'ERROR', res
        res.redirect '/'

db = require '../config/cradle'
fs = require 'fs'
im = require 'imagemagick'
async = require 'async'

Picture = require('../models/pictures')(db)

module.exports = (app) ->
  app.post '/pictures', (req, res, next) ->
    async.parallel
      thumbnail: (done) ->
        im.resize
          srcPath: req.files.upload.path
          dstPath: "#{req.files.upload.path}_thumbnail"
          width: 270
        , (err, stdout, stderr) ->
          return done err if err
          done null, "#{req.files.upload.path}_thumbnail"
      resized: (done) ->
        im.resize
          srcPath: req.files.upload.path
          dstPath: "#{req.files.upload.path}_resized"
          width: 750
        , (err, stdout, stderr) ->
          return done err if err
          done null, "#{req.files.upload.path}_resized"
    , (err, result) ->
      if err
        console.log 'ERR', err
        res.redirect '/'
      Picture.create req.user, req.files.upload.path, result.resized, result.thumbnail, req.body.caption, (err, picture) ->
        res.redirect '/'

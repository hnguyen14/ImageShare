fs = require 'fs'

module.exports = (app) ->
  app.get '/images/:id', (req, res) ->
    fs.readFile "#{process.env.UPLOAD_DIR}/#{req.params.id}", (err, data) ->
      if err
        res.send 'Not found', 404
        return
      else 
        res.writeHead 200, 'Content-Type': 'image/png'
        res.write data, 'binary'
        res.end()


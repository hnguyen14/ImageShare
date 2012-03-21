module.exports = (app) ->
  app.post '/pictures', (req, res) ->
    console.log 'REQ', req.param('path')
    res.redirect '/'

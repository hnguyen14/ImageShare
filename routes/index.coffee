module.exports = (app) ->
  require('./pictures')(app)
  require('./image')(app)
  require('./authenticate')(app)

  app.get '/', (req, res) ->
    res.render 'index'

  app.get '/tag/*', (req, res) ->
    res.render 'index'

  app.get '/user/*', (req, res) ->
    res.render 'index'

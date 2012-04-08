module.exports = (app) ->
  require('./pictures')(app)
  require('./image')(app)

  app.get '/', (req, res) ->
    res.render 'index'

  app.get '/tag/*', (req, res) ->
    res.render 'index'

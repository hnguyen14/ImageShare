module.exports = (app) ->
  require('./pictures')(app)

  app.get '/', (req, res) ->
    res.render 'index'

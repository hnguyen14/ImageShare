passport = require '../config/facebook-passport'
db = require '../config/cradle'
User = require('../models/users')(db)

module.exports = (app) ->
  app.get '/login', (req, res) ->
    req.session.redirectTo = '/'
    req.session.save()
    res.writeHead 303
      Location: '/auth/facebook'
    res.end()

  app.get '/logout', (req, res) ->
    req.logout()
    delete req.session.user
    res.writeHead 303,
      Location: '/'
    res.end()

  app.get '/auth/facebook', passport.authenticate('facebook', {scope: ['user_status', 'user_photos']})

  app.get '/auth/facebook/callback', passport.authenticate('facebook', failureRedirect: '/'), (req, res) ->
    res.redirect '/'

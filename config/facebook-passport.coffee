passport = require 'passport'
db = require './cradle'
FacebookStrategy = require('passport-facebook').Strategy
User = require('../models/users')(db)

FACEBOOK_APP_ID = '211550688954395'
FACEBOOK_APP_SECRET = '96d9c72cbd0edf57440d44cd2956bdc9'

passport.use new FacebookStrategy(
  clientID: FACEBOOK_APP_ID
  clientSecret: FACEBOOK_APP_SECRET
  callbackURL : '/auth/facebook/callback'
, (accessToken, refreshToken, profile, done) ->
    User.findOrCreate profile, (err, user) ->
      return done err if err
      done null, user
)

passport.serializeUser (user, done) ->
  done null, user._id

passport.deserializeUser (id, done) ->
  User.findById id, (err, user) ->
    return done err if err
    done null, user

module.exports = passport

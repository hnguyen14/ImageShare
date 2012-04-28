passport = require 'passport'
db = require './cradle'
FacebookStrategy = require('passport-facebook').Strategy
User = require('../models/users')(db)

FACEBOOK_APP_ID = process.env.FACEBOOK_APP_ID
FACEBOOK_APP_SECRET = process.env.FACEBOOK_APP_SECRET

callbackUrl = (if process.env.DOMAIN then process.env.DOMAIN else '') + '/auth/facebook/callback'

passport.use new FacebookStrategy(
  clientID: FACEBOOK_APP_ID
  clientSecret: FACEBOOK_APP_SECRET
  callbackURL : callbackUrl
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

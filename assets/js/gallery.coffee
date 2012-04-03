#= require underscore
#= require socket.io
#= require backbone
#= require backbone.iosync
#= require backbone.iobind

$ ->
  window.socket = Backbone.socket = socket = io.connect()

  $('a.image-upload').first().click ->
    $('#imageUpload').modal 'show'

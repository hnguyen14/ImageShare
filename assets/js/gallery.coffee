#= require underscore
#= require socket.io
#= require backbone
#= require backbone.iosync
#= require backbone.iobind

$ ->
  window.socket = Backbone.socket = socket = io.connect()

  class App extends Backbone.Router
    initialize: =>

    routes:
      '': 'index'
      '/': 'index'
      '/test': 'index'

    index: ->
      @gallery = new Gallery()
      @galleryView = new GalleryView(collection: @gallery)
      $('#main').append @galleryView.el
      @gallery.fetch()

  class Picture extends Backbone.Model
    idAttribute: '_id'
    urlRoot: 'picture'
    noIoBind: true

  class Gallery extends Backbone.Collection
    model: Picture
    url: 'gallery'

    initialize: (options) ->
      @ioBind 'create', @serverChange, @

    serverChange: (data) =>
      exist = @get data.id
      if exist
        exist.set data
      else
        @add data

  class PictureView extends Backbone.View
    tagName: 'div'
    className: 'thumbnail span3'

    initialize: (options) =>
       @model.bind 'change', @change
       @render()

    render: =>
      @$el.html $('#picture-template').html()
      @$('.image-link').attr('href',@model.get('path'))
      @$('.image').attr('src', @model.get('path'))
      @

  class GalleryView extends Backbone.View
    id: 'gallery'
    tagName: 'div'
    className: 'gallery'

    initialize: (options) ->
       @collection.bind 'reset', @render

    render: =>
      @collection.each (picture) =>
        @$el.prepend new PictureView(model: picture).el
      @

  window.app = new App
  Backbone.history.start()

  $('a.image-upload').first().click ->
    $('#imageUpload').modal 'show'


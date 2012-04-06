#= require underscore
#= require socket.io
#= require backbone
#= require backbone.iosync
#= require backbone.iobind
#= require twitter-text

$ ->
  window.socket = Backbone.socket = socket = io.connect()

  class App extends Backbone.Router
    initialize: =>
      @galleryView?.remove()

    routes:
      '': 'index'
      '/': 'index'
      'tag/:tagId': 'tag'

    tag: (tagId)->
      @galleryView?.remove()
      @gallery = new Gallery(tagId: tagId)
      @galleryView = new GalleryView(collection: @gallery)
      $('#main').append @galleryView.el
      @gallery.fetch()

    index: ->
      @galleryView?.remove()
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
      exist = @get data._id
      if exist
        exist.set data
      else
        @add data

  class PictureView extends Backbone.View
    tagName: 'div'
    className: 'span3 picture'

    initialize: =>
       @model.bind 'change', @change
       @render()

    render: =>
      @$el.html $('#picture-template').html()
      @$('.image-link').attr('href',@model.get('path'))
      @$('.image').attr('src', @model.get('path'))
      @$('.image-caption').html twttr.txt.autoLinkHashtags(@model.get('caption'), hashtagUrlBase: '/tag/')
      @

  class GalleryView extends Backbone.View
    id: 'gallery'
    tagName: 'div'
    className: 'gallery'

    initialize: (options) ->
       @collection.bind 'reset', @render
       @collection.bind 'add', @addPicture

    addPicture: (picture) =>
      @$el.prepend new PictureView(model: picture).el

    render: =>
      @collection.each (picture) =>
        @addPicture picture
      @

  window.app = new App
  Backbone.history.start pushState: true

  $('a.image-upload').first().click ->
    $('#imageUpload').modal 'show'

  $('a').live 'click', (e) ->
    if e.currentTarget.host == window.location.host
      e.preventDefault()
      app.navigate e.currentTarget.pathname, trigger: true

  $('#input01').change (e) ->
    input = $('#input01').get()
    if @.files && @.files[0]
      console.log @.files[0]
      reader = new FileReader()
      reader.onload = (ev) ->
        $('#uploadPreview').attr('src', ev.target.result)
        if $('.upload-image-preview:visible').length == 0
          $('.upload-image-preview').show 500, ->
      reader.readAsDataURL @.files[0]


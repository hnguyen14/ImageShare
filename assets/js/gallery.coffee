#= require underscore
#= require backbone
#= require backbone.iosync
#= require backbone.iobind
#= require imagesLoaded
#= require jquery.masonry.min
#= require jquery.viewport.mini
#= require moment.min
#= require socket.io
#= require twitter-text

$ ->
  window.socket = Backbone.socket = socket = io.connect()

  dataFetchOptions = {}

  class App extends Backbone.Router
    initialize: =>
      @galleryView?.remove()

    routes:
      '': 'index'
      '/': 'index'
      '_=_': 'index'
      'tag/:tagId': 'tag'
      'user/:userId': 'user'

    user: (userId)->
      $('.ribbon-wrapper').hide()
      socket.emit 'user:read', {id: userId}, (err, res) ->
        unless err
          $('.ribbon-data-container').html "<img class='.ribbon-user-img' src='https://graph.facebook.com/#{userId}/picture'/><span>#{res.authHash.displayName}</span>"
          $('.ribbon-wrapper').show()
      dataFetchOptions = userId: userId
      @main()


    tag: (tagId)->
      $('.ribbon-data-container').html "<span class='.ribbon-tag-id'>##{decodeURI(tagId)}</span>"
      $('.ribbon-wrapper').show()
      dataFetchOptions = tagId: tagId
      @main()

    index: ->
      $('.ribbon-wrapper').hide()
      dataFetchOptions = {}
      @main()

    main: ->
      @galleryView?.remove()
      @gallery = new Gallery(dataFetchOptions)
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
    className: 'span3 picture thumbnail'

    initialize: =>
       @model.bind 'change', @change
       @render()

    render: =>
      @$el.html $('#picture-template').html()
      @$('.image-link').attr('href',@model.get('resizedPath'))
      @$('.image-link').attr('title', @model.get('caption'))
      @$('.image-link').lightBox()
      @$('.image').attr('src', @model.get('thumbnailPath'))
      @$('.poster-image').attr 'src', "https://graph.facebook.com/#{@model.get('user').id}/picture"
      @$('.poster-name').text @model.get('user').displayName
      @$('.poster-name').attr 'href', "/user/#{@model.get('user').id}"
      @$('.image-caption').html twttr.txt.autoLinkHashtags(@model.get('caption'), hashtagUrlBase: '/tag/')
      @$('.timestamp').attr('datetime', @model.get('updatedAt'))
      @$('.timestamp').text new moment(@model.get('updatedAt')).fromNow()
      @

  class GalleryView extends Backbone.View
    id: 'gallery'
    tagName: 'div'
    className: 'gallery'

    initialize: (options) ->
       @collection.bind 'reset', @render
       @collection.bind 'add', @addPicture

    addPicture: (picture) =>
      if picture.get('updatedAt') > $('#gallery .picture time').first().attr('datetime')
        @$el.prepend new PictureView(model: picture).el
      else
        @$el.append new PictureView(model: picture).el
      @$el.imagesLoaded ->
        if $('#gallery').data('masonry')
          $('#gallery').masonry 'reload',
            isAnimated: true

    render: =>
      @collection.each (picture) =>
        @addPicture picture
      @$el.imagesLoaded ->
        $('#gallery').masonry
          isAnimated: true
      @

  window.app = new App
  Backbone.history.start pushState: true


  $('a.image-upload').first().click ->
    $('#imageUpload').modal 'show'

  $('a.hashtag, a.poster-name, a.image-link').live 'click', (e) ->
    e.preventDefault()
    app.navigate e.currentTarget.pathname, trigger: true

  $('#input01').change (e) ->
    input = $('#input01').get()
    if @.files && @.files[0]
      reader = new FileReader()
      reader.onload = (ev) ->
        $('#uploadPreview').attr('src', ev.target.result)
        if $('.upload-image-preview:visible').length == 0
          $('.upload-image-preview').show 500, ->
      reader.readAsDataURL @.files[0]

  $(window).scroll _.throttle ->
    if $('.picture:below-the-fold').length > 0 && $('.picture:below-the-fold').length < 8
      startkey = app.gallery.models[app.gallery.models.length - 1].get('key')
      _.extend dataFetchOptions,
        startkey: startkey

      app.gallery.fetch
        data: [dataFetchOptions]
        add: true
        success: (collections, response) ->
  , 500

div '.container', ->
  div '#main', ->
    div '.ribbon-wrapper', ->
      div '.ribbon-front', ->
        div '.ribbon-data-container', ->
      div '.ribbon-edge-topleft', ->
      div '.ribbon-edge-topright', ->
      div '.ribbon-edge-bottomleft', ->
      div '.ribbon-edge-bottomright', ->
      div '.ribbon-back-left', ->
      div '.ribbon-back-right', ->
  div '.hero-unit.footer', ->
    p ->
      img '.email', src: '/email-icon.png', ->
      '@ admin@iShareMyPic.com'
    p ->
      img '.twitter', src: '/twitter-icon.png', ->
      '@ iShareMyPic'

div '.modal', id: 'imageUpload', ->
  form 'form-horizontal', id: 'pictureSubmit', enctype: 'multipart/form-data', action: '/pictures', method: 'post', ->
    div '.modal-header', ->
      a '.close', 'data-dismiss': 'modal', -> 'x'
      h3 -> 'Upload An Image'
    div '.modal-body', ->
      fieldset ->
        div '.control-group', ->
          div '.upload-image-preview', ->
            img id: 'uploadPreview', ->
          label '.control-label', for: 'input01', ->
            'Choose a file'
          div '.controls', ->
            input '.input-large', id: 'input01', type: 'file', name: 'upload', ->
        div '.control-group', ->
          label '.control-label', for: 'input02', ->
            'Caption'
          div '.controls', ->
            textarea '.input-large', id: 'input02', name: 'caption', placeholder: 'Caption', ->
    div '.modal-footer', ->
      a '.btn', 'data-dismiss': 'modal', -> 'Close'
      input '.btn-primary', type: 'submit', value: 'Upload', ->

text js 'gallery'

script '#picture-template', type: 'text/template', ->
  div '.image-link-container', ->
    a '.image-link', title: '', ->
      img '.image', ->
  img '.poster-image', src: '', ->
  div '.poster-comment', ->
    a '.poster-name', ->
    div '.image-caption', ->
  time '.timestamp', ->


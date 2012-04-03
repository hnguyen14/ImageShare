div '.navbar .navbar-fixed-top', ->
  div '.navbar-inner', ->
    div '.container', ->
      a '.brand', href: '#', ->
        'ImageShare'
      ul '.nav', ->
        li ->
          a '.image-upload', href:'#', -> 'Upload An Image'

div '.modal', id: 'imageUpload', ->
  form 'form-horizontal', id: 'pictureSubmit', enctype: 'multipart/form-data', action: '/pictures', method: 'post', ->
    div '.modal-header', ->
      a '.close', 'data-dismiss': 'modal', -> 'x'
      h3 -> 'Upload An Image'
    div '.modal-body', ->
      fieldset ->
        div 'control-group', ->
          label 'control-label', for: 'input0i2', ->
            'Choose a file'
          div 'controls', ->
            input 'input-large', id: 'input02', type: 'file', name: 'upload', ->
    div '.modal-footer', ->
      a '.btn', 'data-dismiss': 'modal', -> 'Close'
      input '.btn-primary', type: 'submit', value: 'Upload', ->

text js 'gallery'

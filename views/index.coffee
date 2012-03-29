h1 ->
  "File Upload"

form 'span6 form-horizontal', id: 'pictureSubmit', enctype: 'multipart/form-data', action: '/pictures', method: 'post', ->
  fieldset ->
    div 'control-group', ->
      label 'control-label', for: 'input0i2', ->
        'Choose a file'
      div 'controls', ->
        input 'input-large', id: 'input02', type: 'file', name: 'upload', ->
    div 'form-actions', ->
      input 'btn-primary', type: 'submit', value: 'Upload', ->

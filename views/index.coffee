h1 ->
  "WHATEVER"

form 'span6 form-horizontal', id: 'pictureSubmit', action: '/pictures', method: 'post', ->
  fieldset ->
    legend ->
      "Legend Text"
    div 'control-group', ->
      label 'control-label', for: 'input01', ->
        'Path'
      div 'controls', ->
        input 'input-xlarge', id: 'input01', type: 'text', name: 'path', ->
    div 'form-actions', ->
      input 'btn-primary', type: 'submit', value: 'Upload', ->

html ->
  head ->
    title 'ImageShare'
    link rel: 'stylesheet', href: '/bootstrap/css/bootstrap.min.css'
    link rel: 'stylesheet', href: '/bootstrap/css/bootstrap-responsive.min.css'
    link rel: 'stylesheet', href: '/lightbox/css/jquery.lightbox-0.4.css'
    text css 'main'
    script src: '/javascripts/jquery-1.7.1.min.js'
    script src: '/lightbox/js/jquery.lightbox-0.4.js'
    script src: '/bootstrap/js/bootstrap.js'
  body ->
    div '.navbar .navbar-fixed-top', ->
      div '.navbar-inner', ->
        div '.container', ->
          a '.brand', href: '#', ->
            'ImageShare'
          ul '.nav', ->
            li ->
              i '.icon-picture .icon-white', ->
              a '.image-upload', href:'#', -> 'Upload An Image'
          ul '.nav .pull-right', ->
            li ->
              if @passport.user
                a '.logout-link', href: '/logout', -> 
                  img '.logged-in-user-image', src: "http://graph.facebook.com/#{@passport.user.id}/picture"
                  span '.logged-in-user', -> "#{@passport.user.displayName}"
              else
                a '.login-link', href: '/login', ->
                  span '.facebook-login', ->
    @body


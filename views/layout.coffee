html ->
  head ->
    title 'iShareMyPic - Inspiration for the travel enthusiast'
    link rel: 'stylesheet', href: '/bootstrap/css/bootstrap.min.css'
    link rel: 'stylesheet', href: '/bootstrap/css/bootstrap-responsive.min.css'
    link rel: 'stylesheet', href: '/lightbox/css/jquery.lightbox-0.4.css'
    link rel: 'stylesheet', href: '/css/main.css'
    link rel: 'stylesheet', href: '/css/responsive.css'
    meta name: 'viewport', content: 'width=device-width, initial-scale=1.0'
  body ->
    div '.navbar .navbar-fixed-top', ->
      div '.navbar-inner', ->
        div '.container', ->
          a '.brand', href: '/', -> 'iShareMyPic'
          button '.btn.btn-navbar.collapsed', type: 'button', 'data-toggle': 'collapse', 'data-target': '.nav-collapse', ->
            span '.icon-bar', ->
            span '.icon-bar', ->
            span '.icon-bar', ->
          div '.nav-collapse.collapse', style: 'height: 0px', ->
            ul '.nav.nav-links', ->
              li ->
                a '.home', href: '/', ->
                  i '.icon-home .icon-white', ->
                  span ->'Home'
              if @passport.user
                li ->
                  a '.image-upload', href:'#', ->
                    i '.icon-picture .icon-white', ->
                    span -> 'Upload an image'
              li '.user', ->
                if @passport.user
                  a '.logout-link', href: '/logout', -> 
                    img '.logged-in-user-image', src: "http://graph.facebook.com/#{@passport.user.id}/picture"
                    span '.logged-in-user', -> "#{@passport.user.displayName}"
                else
                  a '.login-link', href: '/login', ->
                    span '.facebook-login', ->
          div '.pull-right.visible-desktop', ->
            ul '.nav', ->
              li ->
                if @passport.user
                  a '.logout-link', href: '/logout', -> 
                    img '.logged-in-user-image', src: "http://graph.facebook.com/#{@passport.user.id}/picture"
                    span '.logged-in-user', -> "#{@passport.user.displayName}"
                else
                  a '.login-link', href: '/login', ->
                    span '.facebook-login', ->
    @body


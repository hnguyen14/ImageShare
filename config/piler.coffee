piler = require 'piler'

clientjs = piler.createJSManager()
clientcss = piler.createCSSManager()

publicDir = "#{__dirname}/../public"
jsDir = "#{publicDir}/js"
cssDir = "#{publicDir}/css"

clientjs.addFile "#{jsDir}/jquery-1.7.1.min.js"
clientjs.addFile "#{jsDir}/underscore.js"

#bootstrap
clientjs.addFile "#{publicDir}/bootstrap/js/bootstrap.min.js"

#lightbox
clientjs.addFile "gallery", "#{publicDir}/lightbox/js/jquery.lightbox-0.4.js"

clientjs.addFile "gallery", "#{jsDir}/backbone.js"
clientjs.addFile "gallery", "#{jsDir}/socket.io.js"
clientjs.addFile "gallery", "#{jsDir}/backbone.iobind.js"
clientjs.addFile "gallery", "#{jsDir}/backbone.iosync.js"
clientjs.addFile "gallery", "#{jsDir}/imagesLoaded.js"
clientjs.addFile "gallery", "#{jsDir}/jquery.masonry.min.js"
clientjs.addFile "gallery", "#{jsDir}/jquery.viewport.min.js"
clientjs.addFile "gallery", "#{jsDir}/moment.min.js"
clientjs.addFile "gallery", "#{jsDir}/twitter-text.js"
clientjs.addFile "gallery", "#{jsDir}/gallery.coffee"

clientcss.addFile "#{publicDir}/bootstrap/css/bootstrap.min.css"
clientcss.addFile "#{publicDir}/lightbox/css/jquery.lightbox-0.4.css"

clientcss.addFile "main", "#{cssDir}/main.css"

clientcss.addFile "responsive", "#{publicDir}/bootstrap/css/bootstrap-responsive.min.css"
clientcss.addFile "responsive", "#{cssDir}/responsive.css"

module.exports =
  js: clientjs
  css: clientcss


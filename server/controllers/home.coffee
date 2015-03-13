glob = require 'glob'
config = require '../config/config'
#
exports.home = (req, res, next) ->

  # Libs
  cssFiles = [
    '/bootstrap/dist/css/bootstrap.css'
  ]
  jsFiles = [
    '/angular/angular.js'
    '/angular-bootstrap/ui-bootstrap-tpls.js'
    '/angular-resource/angular-resource.js'
    '/angular-route/angular-route.js'
    '/angular-ui-router/release/angular-ui-router.js'
    '/lodash/lodash.js'
  ]

  # Filtering paths
  appModules = glob.sync config.root + '/../public/**/*.js'
  appFiles = []
  appFiles.push path.split('public')[1] for path in appModules

  res.render 'index',
    title: 'fullstack coffeescript framework'
    cssFiles: cssFiles
    jsFiles: jsFiles
    appFiles: appFiles

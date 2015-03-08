express  = require 'express'
router = express.Router()
mongoose = require 'mongoose'
glob = require 'glob'
config = require '../config/config'

module.exports = (app) ->
  app.use '/', router

router.get '/', (req, res, next) ->

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

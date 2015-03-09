express = require 'express'
glob = require 'glob'
logger = require 'morgan'
favicon = require 'serve-favicon'

module.exports = (app, config) ->
  app.use(favicon(config.root + '/../public/assets/img/favicon.ico'))

  app.use logger 'dev'
  app.set 'views', config.root + '/views'

  app.engine 'html', require('ejs').renderFile
  app.set 'view engine', 'ejs'

  app.use express.static config.root + '/../public'
  app.use express.static config.root + '/../../bower_components'

  models = glob.sync config.root + '/models/**/*.js'
  models.forEach (model) ->
    require(model)

  routes = glob.sync config.root + '/routes/**/*.js'
  routes.forEach (route) ->
    require(route)(app)

  # catch 404 and forward to error handler
  app.use (req, res, next) ->
    err = new Error 'Not Found'
    err.status = 404
    next err

  # error handlers

  # development error handler
  # will print stacktrace
  if app.get('env') == 'development'
    app.use (err, req, res, next) ->
      res.status err.status || 500
      console.log err.stack
      res.json
        message: err.message
        error: err

  # production error handler
  # no stacktraces leaked to user
  app.use (err, req, res, next) ->
    res.status err.status || 500
    res.render 'error',
      res.json
        message: err.message
        error: err

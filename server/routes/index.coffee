'use strict';

module.exports = (System, app, auth, database) ->
  index = require('../controllers/index')
  app.route('/')
    .get(index.render)

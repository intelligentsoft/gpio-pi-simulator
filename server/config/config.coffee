path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    port: 3000
    db: 'mongodb://localhost/seed-development'

  test:
    root: rootPath
    port: 3000
    db: 'mongodb://localhost/seed-test'

  production:
    root: rootPath
    port: 3000
    db: 'mongodb://localhost/seed-production'

module.exports = config[env]

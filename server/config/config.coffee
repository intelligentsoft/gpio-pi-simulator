path     = require 'path'
rootPath = path.normalize __dirname + '/..'
env      = process.env.NODE_ENV || 'development'

config =
  development:
    root: rootPath
    port: 3000
    db: 'mongodb://localhost/pi-development'

  test:
    root: rootPath
    port: 3000
    db: 'mongodb://localhost/pi-test'

  production:
    root: rootPath
    port: 3000
    db: 'mongodb://localhost/pi-production'

module.exports = config[env]

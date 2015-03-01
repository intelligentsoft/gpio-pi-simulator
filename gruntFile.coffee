module.exports = (grunt) ->

  require('load-grunt-tasks')(grunt)
  config =
    coffee:
      common:
        expand: true
        cwd: '',
        src: ['app.coffee'],
        dest: 'bin',
        ext: '.js'
      server:
        expand: true
        cwd: 'server/',
        src: ['**/*.coffee'],
        dest: 'bin/server/',
        ext: '.js'
      public:
        expand: true
        cwd: 'public/',
        src: ['**/*.coffee'],
        dest: 'bin/public/',
        ext: '.js'
    clean: ["bin"]
    nodemon:
      dev:
        script: 'bin/app.js',
        options:
          args: ['dev'],
          nodeArgs: ['--debug'],
          ext: 'js',
          watch: ['bin/server', 'gruntFile.coffee'],
    concurrent:
      tasks: ['nodemon', 'watch']
      options:
        logConcurrentOutput: true
    watch:
      scripts:
        files: [
          'server/**/*.coffee'
          'app.coffee'
        ]
        tasks: ['coffee']
      views:
        files: [
          'server/views/*'
        ]
        tasks: ['copy']
      html:
        files: 'bin/server/views/**',
        options:
          livereload: true,
          interval: 500
    copy:
      views:
        files: [
          expand: true
          flatten: true
          src: ['server/views/*']
          dest: 'bin/server/views/'
          filter: 'isFile'
        ]
    stylus:
      dist:
        files:
          'bin/public/assets/css/foo.css': 'public/assets/css/**/*.styl'

  grunt.initConfig config

  grunt.registerTask 'default', ['coffee']

  grunt.registerTask 'dev', 'Log some stuff.', ->
    grunt.log.write('Logging some stuff...').ok()
    grunt.task.run [
      'clean'
      'coffee'
      'copy'
      'stylus'
      'concurrent'
    ]

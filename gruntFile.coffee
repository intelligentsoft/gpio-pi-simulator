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
          delay: 1000,

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
    copy:
      main:
        files: [
          {expand: true,flatten: true, src: ['server/views/*'], dest: 'bin/server/views/', filter: 'isFile'},
        ]

  grunt.initConfig config

  grunt.registerTask 'default', ['coffee']

  grunt.registerTask 'dev', 'Log some stuff.', ->
    grunt.log.write('Logging some stuff...').ok()
    grunt.task.run [
      'clean'
      'coffee'
      'copy'
      'concurrent'
    ]

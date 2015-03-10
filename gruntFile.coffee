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
        tasks: ['newer:coffee']
      public:
        files: [
          'public/**/*.coffee'
        ]
        tasks: ['newer:coffee:public']
      publicViews:
        files: [
          'public/views/**/*'
        ]
        tasks: ['newer:copy:public']
      serverViews:
        files: [
          'server/views/**/*'
        ]
        tasks: ['newer:copy']
      stylus:
        files: [
          'public/assets/css/**/*'
        ]
        tasks: ['newer:stylus']
      htmlserver:
        files: [
          'bin/server/views/**'
          'bin/public/**'
        ]
        options:
          livereload: true,
          interval: 500

    copy:
      server:
        files: [
          expand: true
          flatten: true
          src: ['server/views/*']
          dest: 'bin/server/views/'
          filter: 'isFile'
        ]
      public:
        files: [
          expand: true
          flatten: true
          src: ['public/views/*']
          dest: 'bin/public/views/'
          filter: 'isFile'
        ]
      static:
        files: [
          expand: true
          flatten: true
          src: [
            'public/assets/static/*'
          ]
          dest: 'bin/public/assets/static/'
          filter: 'isFile'
        ]
      images:
        files: [
          expand: true
          flatten: true
          src: [
            'public/assets/img/*'
          ]
          dest: 'bin/public/assets/img/'
          filter: 'isFile'
        ]
    stylus:
      dist:
        files:
          'bin/public/assets/css/style.css': 'public/assets/css/**/*.styl'

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

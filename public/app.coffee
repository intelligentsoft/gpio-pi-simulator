'use strict'

angular.module('seed', [
    'ngResource'
    'ngRoute'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        controller: 'HomeCtrl'
        templateUrl: 'views/index.html'
      .when '/about',
        controller: 'AboutCtrl'
        templateUrl: 'views/about.html'
      .otherwise {
        redirectTo: '/'
      }

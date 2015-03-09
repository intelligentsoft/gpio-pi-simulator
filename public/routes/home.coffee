'use strict'

angular.module 'seedApp'
.config ['$urlRouterProvider', '$stateProvider',
  ($urlRouterProvider, $stateProvider) ->

    path = '/views'
    $stateProvider.state 'home',
      url: '/'
      templateUrl: path + '/index.html'
      controller: 'HomeController'
    $stateProvider.state 'about',
      url: '/about'
      templateUrl: path + '/about.html'
      controller: 'HomeController'

    $urlRouterProvider.otherwise '/'
]

'use strict'

angular.module('seedApp')
.controller 'MainController', ['$scope',
  ($scope) ->

    $scope.pins = []

    specialPins =
      '3V':
        title: '3x3'
        subtitle: ''
      '+5V':
        title: '5V'
        subtitle: ''
      '5V':
        title: '5V'
        subtitle: ''
      '+ground':
        title: 'Ground'
        subtitle: ''
      'ground':
        title: 'Ground'
        subtitle: ''
      'gpio':
        title: 'GPIO'
        subtitle: ''

    PINS = 26

    type =
      'gpio': 'green'
      '+ground': 'black'
      'ground': 'white'
      '3V': 'orange'
      '+5V': 'red'
      '5V': 'white'

    config =
      '3V': [1]
      '+5V': [2]
      '5V': [4]
      '+ground': [6]
      'ground': [9, 14, 17, 20, 25]

    gpioConfig = []
    gpioConfig[7] = {title: 'GPIO4', subtitle: 'GPCLKO'}
    gpioConfig[8] = {title: 'GPIO14'}
    gpioConfig[10] = {title: 'GPIO15'}
    gpioConfig[10] = {title: 'GPIO17'}
    gpioConfig[12] = {title: 'GPIO18'}
    gpioConfig[13] = {title: 'GPIO21'}
    gpioConfig[15] = {title: 'GPIO22'}
    gpioConfig[16] = {title: 'GPIO23'}
    gpioConfig[18] = {title: 'GPIO24'}
    gpioConfig[19] = {title: 'GPIO10'}
    gpioConfig[21] = {title: 'GPIO9'}
    gpioConfig[22] = {title: 'GPIO25'}
    gpioConfig[23] = {title: 'GPIO11'}
    gpioConfig[24] = {title: 'GPIO8'}
    gpioConfig[26] = {title: 'GPIO7'}

    $scope.buildGpioConfigObj = (pin, configType) ->
      pinConfig = _.clone specialPins[configType]
      unless pinConfig
        throw new Error "There is not default config for this pin #{pin}"
      pinConfig.pin = pin
      pinConfig.type = configType
      pinConfig

    $scope.generateGpioPort = ->
      defaultPins = []
      for configType, pins of config
        for pin in pins
          pinConfig = $scope.buildGpioConfigObj pin, configType
          defaultPins[pin] = pinConfig

      for i in [1..PINS]
        unless defaultPins[i]
          defaultPins[i] = $scope.buildGpioConfigObj i, 'gpio'

      $scope.pins = $scope.loadConfigDefaultConfig defaultPins
      console.log $scope.pins

    $scope.loadConfigDefaultConfig = (pins) ->
      unless gpioConfig
        throw new Error 'gpioConfig is not defined'

      for index, config of gpioConfig
        pinConfig = pins[index]
        for i, value of config
          pinConfig[i] = value
      pins.shift()
      pins

    $scope.generateGpioPort()

]

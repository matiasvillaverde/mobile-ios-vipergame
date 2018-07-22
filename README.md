# Viper Memory Game
> Simple memory game written in Swift 4 using VIPER Architecture.

[![Swift Version][swift-image]][swift-url]
[![Build Status](https://travis-ci.org/matiasvillaverde/mobile-ios-vipergame.svg?branch=master)](https://travis-ci.org/matiasvillaverde/mobile-ios-vipergame)
[![License][license-image]][license-url]
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

The Memory Game is a deck of cards where the user needs to find matches. The 
project’s aim is to show best practices of VIPER architecture in iOS using swift 4. 
Additionally, the game serves as an example of code with robust Unit Test coverage.


![](header.png)

## Features

- [x] VIPER Architecture
- [x] 97% code coverage with Unit Tests
- [x] Travis and Fastlane scripts for Continues Integration
- [x] Best practices

## Requirements

- iOS 10.0+
- Xcode 9.0+

## VIPER

VIPER is an implementation of Clean Architecture to iOS apps. The word VIPER is a
backronym for View, Interactor, Presenter, Entity, and Routing. Clean
Architecture divides an app’s logical structure into distinct layers of
responsibility. This makes it easier to isolate dependencies (e.g. content
  of the cards) and to test the interactions at the boundaries between layers.
  

## Installation

The project doesn't have any external dependencies, frameworks, etc.

1. Open Memory.xcodeproj
2. cmd + R

## Continues Integration

The project contains Fastlane scripts to deploy the app to the store automatically. You
can find the scrips inside ./fastlane. To deploy the app to the store you
must change the ./fastlane/Appfile and ./fastlane/Deliveryfile content 
with your own developer data.

Here you can find detailed information of each  [Lane](https://github.com/matiasvillaverde/mobile-ios-vipergame/tree/master/fastlane)

## Contribute

We would love you for the contribution to **Memory Game**, check the
``LICENSE`` file for more info.

## Meta

Matias Villaverde – [@matiasvillaverde](https://medium.com/@matiasvillaverde)
– contact@matiasvillaverde.com

Licensed under the **MIT** license. See ``LICENSE`` for more information.

[swift-image]:https://img.shields.io/badge/swift-4.1-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com

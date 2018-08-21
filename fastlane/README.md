fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### memory
```
fastlane memory
```
This lane will upload app to crashlytics.
### memory_beta
```
fastlane memory_beta
```
This lane will upload app to crashlytics.

----

## iOS
### ios release_production
```
fastlane ios release_production
```
This Lane run tests, increase build, take screenshots,
  build for deployment, upload to app store.
### ios test
```
fastlane ios test
```
This Lane run tests in most important devices.
### ios increase_build
```
fastlane ios increase_build
```
This Lane will increase build number and push to master.
### ios build
```
fastlane ios build
```
This Lane will build the app for delivery.
### ios screenshots
```
fastlane ios screenshots
```
This Lane will take screenshots and add frames.
### ios deploy
```
fastlane ios deploy
```
This Lane will upload app to the app store.

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

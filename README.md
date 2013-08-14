# JavaScript-to-Native communication bridge benchtest
Performance tests for JS-Native communication across a variety of protocols.

## Platforms
###ios
basic xhr throughput, frequency and bandwidth tests
###android
comming soon!

## Installing
###ios
1. create a Cordova project
2. merge the contents of www/ with the www/ in the cordova project
3. add the native files in src/ios/ to Classes/Plugins/ through xcode
4. there is no step 4

## As a Cordova Plugin
comming soon!

## Dependencies
### Cordova File Plugin
part of the benchmarking is testing file retrieval throughput and bandwidth
### Cordova Console Plugin
for logging
### Cordova Device Plugin
for device info
### Douglas Crockford's js json lib
[specifically](https://github.com/douglascrockford/JSON-js/blob/master/json2.js)
provides JSON.parse functionality in the iOS UIWebview

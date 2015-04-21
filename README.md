LBJSON
=======

[![Version](https://img.shields.io/cocoapods/v/LBJSON.svg?style=flat)](http://cocoapods.org/pods/LBJSON)
[![License](https://img.shields.io/cocoapods/l/LBJSON.svg?style=flat)](http://cocoapods.org/pods/LBJSON)
[![Platform](https://img.shields.io/cocoapods/p/LBJSON.svg?style=flat)](http://cocoapods.org/pods/LBJSON)

 
LBJSON framework is a Swift framework that uses an Enum which helps working with JSON
 
### How to use



```swift

// LBJSON enum properties int, double, bool, string, array and dictionary returns the associated values or nil

if let posts = LBJSON(object: payload[postsKey]) {
    if posts.array?.count > 0 {
        if let firstPost = posts.array?.first {
            firstPostID = firstPost["post_id"]?.string
        }
    }
}
``` 
 
###  
 
### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

CocoaPods 0.36 adds supports for Swift and embedded frameworks. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate LBJSON into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'
use_frameworks!

pod 'LBJSON'
```

Then, run the following command:

```bash
$ pod install
``` 
 
 
LICENSE
=======

This content is released under the MIT License https://github.com/lucianboboc/LBJSON/blob/master/LICENSE.md
 

Enjoy!

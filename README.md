[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS | watchOS | tvOS | macOS](https://img.shields.io/badge/Platforms-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20macOS-lightgray.svg?style=flat)](http://www.apple.com)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](https://github.com/tadija/AEXML/blob/master/LICENSE)

# HandySwiftUI

A library of handy SwiftUI components.

## Installation

Build from source. Supports of CocoaPod, XCFramework coming soon.


## Usage

```swift
// NavigationLinkModifier

Text("text").push {
  SomeView()
} // can be followed by other modifiers

// is equavalent to

NavigationLink(destination: SomeView()) {
    Text("text")
}
```

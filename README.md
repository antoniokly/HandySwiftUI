[![Swift 5.1](https://img.shields.io/badge/Swift-5.1-orange.svg?style=flat)](https://swift.org)
[![Platforms iOS | watchOS | tvOS | macOS](https://img.shields.io/badge/Platforms-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20macOS-lightgray.svg?style=flat)](http://www.apple.com)
[![License MIT](https://img.shields.io/badge/License-MIT-lightgrey.svg?style=flat)](https://github.com/tadija/AEXML/blob/master/LICENSE)

# HandySwiftUI

A library of handy SwiftUI components. Keep growing.

## Installation

Build from source. Supports of CocoaPod, Swift Package, XCFramework(may be) coming soon.


## Usage

```
Import HandySwiftUI
```

### Push
```swift
Text("text").push {
  SomeView()
}.foregroundColor(.red)

// is equivalent to

NavigationLink(destination: SomeView()) {
    Text("text").foregroundColor(.red)
}
```

### Platform Specific
```swift
VStack {
  Text("text")
  Text("text1")
}.watchOS {
  $0.font(.system(size: 12, weight: .light))
}.iOS {
  $0.font(.system(size: 16, weight: .bold))
}
```

### CustomToggleStyle
```swift
Toggle(isOn: .constant(true)) {
  Text("Text")
}.toggleStyle(CustomToggleStyle(onText: "開", offText: "關", onColor: .red))
```


## Donation

[![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=UXRR2S35YMCQC&source=url)

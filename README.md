# VCColorWheel

[![CI Status](https://img.shields.io/travis/passpier/VCColorWheel.svg?style=flat)](https://travis-ci.org/passpier/VCColorWheel)
[![Version](https://img.shields.io/cocoapods/v/VCColorWheel.svg?style=flat)](https://cocoapods.org/pods/VCColorWheel)
[![License](https://img.shields.io/cocoapods/l/VCColorWheel.svg?style=flat)](https://cocoapods.org/pods/VCColorWheel)
[![Platform](https://img.shields.io/cocoapods/p/VCColorWheel.svg?style=flat)](https://cocoapods.org/pods/VCColorWheel)

An iOS color picker built in Objective-C.

![screenshot.png](https://raw.githubusercontent.com/passpier/VCColorWheel/master/Assets/colorwheel_screenshot.png)

## Usage

Import `VCColorWheelView.h` to your project.

```objective-c
VCColorWheelView *colorWheelView = [[VCColorWheelView alloc] init];
[self.view addSubview:colorWheelView];
```
Get selected color

```objective-c
UIColor *color = colorWheelView.selectedColor;
```

Result:

![demo.gif](https://raw.githubusercontent.com/passpier/VCColorWheel/master/Assets/colorwheel_demo.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- iOS 9.0 or later

## Installation

VCColorWheel is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'VCColorWheel'
```

## Author

passpier, poo9810@gmail.com

## License

VCColorWheel is available under the MIT license. See the LICENSE file for more info.

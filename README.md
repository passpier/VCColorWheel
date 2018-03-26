# VCColorWheel

An iOS color picker built in Objective-C.

![screenshot.png](https://github.com/passpier/VCColorWheel/blob/master/Assets/colorwheel_screenshot.png)

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

![demo.gif](https://github.com/passpier/VCColorWheel/blob/master/Assets/colorwheel_demo.gif)

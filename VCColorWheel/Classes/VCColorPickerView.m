//
//  VCColorPickerView.m
//  VCColorWheel
//
//  Created by ping sheng cheng on 2018/1/20.
//  Copyright © 2018年 ping sheng cheng. All rights reserved.
//

#import "VCColorPickerView.h"
#import "VCColorUtility.h"

@interface VCColorPickerView () {
    CGFloat _currentAngle;
    CGPoint _pickerBeganPoint;
}

@property (strong, nonatomic, readwrite) CAShapeLayer *colorPickerCircle;
@property (strong, nonatomic, readwrite) CAShapeLayer *borderCircle;
@property (strong, nonatomic, readwrite) UIColor *selectedColor;

@end

static inline double radians (double degrees) { return degrees * M_PI / 180; }
static inline double degrees (double radians) { return radians * (180 / M_PI); }

@implementation VCColorPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        //self.backgroundColor = [UIColor whiteColor];
        self.borderCircle = [self drawBorderCircle];
        self.colorPickerCircle = [self drawColorPickerCircle];
        // Add to parent layer
        [self.layer addSublayer:_borderCircle];
        [self.layer addSublayer:_colorPickerCircle];
    }
    return self;
}

- (CAShapeLayer *)drawArcFromDegree:(CGFloat)startDegrees to:(CGFloat)endDegrees withColor:(UIColor *)color {
    int radius = 80;
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)) radius:radius startAngle:radians(startDegrees) endAngle:radians(endDegrees) clockwise:1].CGPath;
    // Center the shape in self
    circle.strokeColor = color.CGColor;
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.lineWidth = 0;
    // More smooth
//    circle.rasterizationScale = 2.0 * [UIScreen mainScreen].scale;
//    circle.shouldRasterize = YES;
    
    return circle;
}

- (CAShapeLayer *)drawColorPickerCircle {
    CAShapeLayer *colorPickerCircle = [CAShapeLayer layer];
    CGFloat startDegrees = 0;
    CGFloat endDegrees = 7; // Make selected arrow point the middle of color

    for (int i = 0; i < COLORS.count; i++) {
        startDegrees = endDegrees;
        endDegrees = startDegrees + 15;
        CAShapeLayer *arc = [self drawArcFromDegree:startDegrees-5 to:endDegrees withColor:COLORS[i]];
        [colorPickerCircle addSublayer:arc];
    }
    
    return colorPickerCircle;
}

- (CAShapeLayer *)drawBorderCircle {
    int radius = 40;
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)cornerRadius:radius].CGPath;
    // Center the shape in self
    circle.position = CGPointMake(CGRectGetMidX(self.frame)-radius,CGRectGetMidY(self.frame)-radius);
    circle.fillColor = [UIColor whiteColor].CGColor;
    circle.strokeColor = [UIColor whiteColor].CGColor;
    circle.lineWidth = 0;
    
    return circle;
}

#pragma mark -

- (void)pickAColorWithViewRotationAngle:(CGFloat)angle {
    CGFloat startDegrees = 0;
    CGFloat endDegrees = 0;
    double selectedDegrees = degrees(angle);
    if (selectedDegrees < 0) {
        selectedDegrees = selectedDegrees + 360;
    }
    for (int i = 0; i < COLORS.count; i++) {
        startDegrees = endDegrees;
        endDegrees = startDegrees + 15;
        if( selectedDegrees < endDegrees && selectedDegrees >= startDegrees) {
            _selectedColor = COLORS[COLORS.count - 1 - i];
        }
    }
//    NSLog(@"Pick color: %f",CGColorGetComponents(_selectedColor.CGColor));
}

#pragma mark - Spin color wheel methods

- (void)touchBeganWithPoint:(CGPoint)touchPoint {
    _pickerBeganPoint = touchPoint;
//    NSLog(@"x:%f,y:%f",_pickerBeganPoint.x,_pickerBeganPoint.y);
}

- (void)touchMovedWithPoint:(CGPoint)touchPoint {
    // Rotate the view when touch moved
    CGPoint currentLocation = CGPointMake(touchPoint.x - self.center.x, touchPoint.y - self.center.y);
    CGPoint previousLocation = CGPointMake(_pickerBeganPoint.x - self.center.x, _pickerBeganPoint.y - self.center.y);
    
    CGFloat angle = atan2f(currentLocation.y, currentLocation.x) - atan2(previousLocation.y, previousLocation.x);
    angle = _currentAngle + angle;
    self.transform = CGAffineTransformMakeRotation(angle);
    [self pickAColorWithViewRotationAngle:angle];
}

- (void)touchEndWithPoint:(CGPoint)touchPoint {
    // Save current angle
    float angle = atan2f(self.transform.b, self.transform.a);
    _currentAngle = angle;
}

#pragma mark - Touch area

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    BOOL isInside = (pow((point.x-center.x), 2) + pow((point.y - center.y), 2) < pow((self.bounds.size.width/2), 2)) ? YES:NO;
    
    return isInside;
}

@end

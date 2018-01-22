//
//  VCColorSelectedView.m
//  VCColorWheel
//
//  Created by ping sheng cheng on 2018/1/20.
//  Copyright © 2018年 ping sheng cheng. All rights reserved.
//

#import "VCColorSelectedView.h"
#import "VCColorUtility.h"

@interface VCColorSelectedView ()

@property (strong, nonatomic, readwrite) CAShapeLayer *centerCircle;
@property (strong, nonatomic, readwrite) CAShapeLayer *borderCircle;
@property (strong, nonatomic, readwrite) CAShapeLayer *arrow;

@end

@implementation VCColorSelectedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setOpaque:NO];
        //self.backgroundColor = [UIColor whiteColor];
        self.arrow = [self drawArrow];
        self.borderCircle = [self drawCircle];
        self.centerCircle = [self drawCircle];
        // Add to parent layer
        [self.layer addSublayer:_arrow];
        [self.layer addSublayer:_borderCircle];
        [self.layer addSublayer:_centerCircle];
    }
    return self;
}

- (CAShapeLayer *)drawCircle {
    int radius = 40;
    CAShapeLayer *circle = [CAShapeLayer layer];
    circle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius)cornerRadius:radius].CGPath;
    // Center the shape in self
    circle.position = CGPointMake(CGRectGetMidX(self.frame)-2*radius,CGRectGetMidY(self.frame)-2*radius);
    UIColor *grayColor = COLORS[0];
    circle.fillColor = grayColor.CGColor;
    circle.strokeColor = DIVIDEColor.CGColor;
    circle.lineWidth = 0;
    // More smooth
//    circle.rasterizationScale = 2.0 * [UIScreen mainScreen].scale;
//    circle.shouldRasterize = YES;
    
    return circle;
}

- (CAShapeLayer *)drawArrow {
    int radius = 40;
    CAShapeLayer *arrow = [CAShapeLayer layer];
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    [trianglePath moveToPoint:CGPointMake(radius,2*radius-20)];
    [trianglePath addLineToPoint:CGPointMake(radius + 60,2*radius)];
    [trianglePath addLineToPoint:CGPointMake(radius,2*radius+20)];
    [trianglePath closePath];
    arrow.path = trianglePath.CGPath;
    arrow.position = CGPointMake(20,0);
    arrow.fillColor = DIVIDEColor.CGColor;
    arrow.strokeColor = DIVIDEColor.CGColor;
    arrow.lineWidth = 0;
    return arrow;
}

#pragma mark - Touch area

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    BOOL isInside = (pow((point.x-center.x), 2) + pow((point.y - center.y), 2) < pow((self.bounds.size.width/2), 2)) ? YES:NO;
    
    return isInside;
}

@end

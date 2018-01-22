//
//  VCColorWheelView.m
//  VCColorWheel
//
//  Created by ping sheng cheng on 2018/1/20.
//  Copyright © 2018年 ping sheng cheng. All rights reserved.
//

#import "VCColorWheelView.h"
#import "VCColorSelectedView.h"
#import "VCColorPickerView.h"

typedef NS_ENUM(NSUInteger, VCColorWheelState) {
    VCColorWheelStateUnknown,
    VCColorWheelStateChangePosition,
    VCColorWheelStatePickColor
};

@interface VCColorWheelView () <CAAnimationDelegate> {
    VCColorSelectedView *_colorSelectedView;
    VCColorPickerView *_colorPickerView;
    VCColorWheelState _colorWheelState;
}

@property (strong, nonatomic, readwrite) UIColor *selectedColor;

@end

static const int colorSelectedViewTag = 1;
static const int colorPickerViewTag = 2;

static NSString *const animLineWidth = @"lineWidth";
static NSString *const animPosition = @"position";

@implementation VCColorWheelView

- (instancetype)init {
    self = [super init];
    if (self) {
        // Give a frame
        CGRect frame = CGRectMake(0, 0, COLOR_WHEEL_WIDTH, COLOR_WHEEL_HEIGHT);
        self.frame = frame;
        //self.backgroundColor = [UIColor whiteColor];
        [self initContentViewWithFrame:frame];
        [self addSingleTapGestureRecognizer];
        _colorWheelState = VCColorWheelStateChangePosition;
    }
    return self;
}

- (void)initContentViewWithFrame:(CGRect)frame {
    _colorPickerView = [[VCColorPickerView alloc] initWithFrame:frame];
    _colorPickerView.tag = colorPickerViewTag;
    // Make view smaller for user touch interaction
    CGRect selectedFrame = CGRectMake(40, 40, frame.size.width - 80, frame.size.height - 80);
    _colorSelectedView = [[VCColorSelectedView alloc] initWithFrame:selectedFrame];
    _colorSelectedView.tag = colorSelectedViewTag;
    [self addSubview:_colorPickerView];
    [self addSubview:_colorSelectedView];
}

- (void)addSingleTapGestureRecognizer {
    UITapGestureRecognizer *tapGestureRecognizer;
    tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];
}

#pragma mark -

- (void)startPickColor {
    [CATransaction begin];
    // Step 1 animation
    CABasicAnimation *didSelectedAnim = [self animationForShowingFrom:@0 to:@80 withKey:animLineWidth];
    CABasicAnimation *showBorderFirstAnim = [self animationForShowingFrom:@20 to:@100 withKey:animLineWidth];
    [CATransaction setCompletionBlock:^{
        // Step 2 animation
        CABasicAnimation *showPickerAnim = [self animationForShowingFrom:@0 to:@80 withKey:animLineWidth];
        CABasicAnimation *showBorderSecondAnim = [self animationForShowingFrom:@100 to:@180 withKey:animLineWidth];
        CABasicAnimation *showArrowAnim = [self animationForShowingFrom:@(CGPointMake(20,0)) to:@(CGPointMake(80,0)) withKey:animPosition];
        for (CAShapeLayer *subLayer in _colorPickerView.colorPickerCircle.sublayers) {
            [subLayer addAnimation:showPickerAnim forKey:@"hidePickerAnim"];
        }
        [_colorPickerView.borderCircle addAnimation:showBorderSecondAnim forKey:@"showBorderSecondAnim"];
        [_colorSelectedView.arrow addAnimation:showArrowAnim forKey:@"showArrowAnim"];
        self.userInteractionEnabled = YES;
    }];
    [_colorSelectedView.borderCircle addAnimation:didSelectedAnim forKey:@"didSelectedAnim"];
    [_colorPickerView.borderCircle addAnimation:showBorderFirstAnim forKey:@"showBorderFirstAnim"];
    [CATransaction commit];
}

- (void)endPickColor {
    [CATransaction begin];
    // Step 1 animation
    CABasicAnimation *hidePickerAnim = [self animationForHidingFrom:@80 to:@0 withKey:animLineWidth];
    CABasicAnimation *hideBorderFirstAnim = [self animationForHidingFrom:@180 to:@100 withKey:animLineWidth];
    CABasicAnimation *hideArrowAnim = [self animationForHidingFrom:@(CGPointMake(80,0)) to:@(CGPointMake(20,0)) withKey:animPosition];
    [CATransaction setCompletionBlock:^{
        // Step 2 animation
        CABasicAnimation *notSelectedAnim = [self animationForHidingFrom:@80 to:@0 withKey:animLineWidth];
        CABasicAnimation *hideBorderSecondAnim = [self animationForHidingFrom:@100 to:@0 withKey:animLineWidth];
        [_colorSelectedView.borderCircle addAnimation:notSelectedAnim forKey:@"notSelectedAnim"];
        [_colorPickerView.borderCircle addAnimation:hideBorderSecondAnim forKey:@"hideBorderSecondAnim"];
        self.userInteractionEnabled = YES;
    }];
    for (CAShapeLayer *subLayer in _colorPickerView.colorPickerCircle.sublayers) {
        [subLayer addAnimation:hidePickerAnim forKey:@"hidePickerAnim"];
    }
    [_colorPickerView.borderCircle addAnimation:hideBorderFirstAnim forKey:@"hideBorderFirstAnim"];
    [_colorSelectedView.arrow addAnimation:hideArrowAnim forKey:@"hideArrowAnim"];
    [CATransaction commit];
}

#pragma mark - CAAnimation methods

- (CABasicAnimation *)animationForShowingFrom:(id)fromValue to:(id)toValue withKey:(NSString *)keyPath{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    anim.duration = 0.3;
    anim.fromValue = fromValue;
    anim.toValue = toValue;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    anim.timingFunction =  [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseInEaseOut];
    
    return anim;
}

- (CABasicAnimation *)animationForHidingFrom:(id)fromValue to:(id)toValue withKey:(NSString *)keyPath{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:keyPath];
    anim.duration = 0.1;
    anim.fromValue = fromValue;
    anim.toValue = toValue;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    
    return anim;
}

#pragma mark - Tap event

- (void)singleTap:(UIGestureRecognizer *)recognizer {
    NSLog(@"singleTap: %@", NSStringFromCGPoint([recognizer locationInView:[recognizer.view superview]]));
    
    switch (_colorWheelState) {
        case VCColorWheelStateChangePosition:
            self.userInteractionEnabled = NO;
            [self startPickColor];
            _colorWheelState = VCColorWheelStatePickColor;
            break;
        case VCColorWheelStatePickColor:
            self.userInteractionEnabled = NO;
            [self endPickColor];
            _colorWheelState = VCColorWheelStateChangePosition;
            break;
        default:
            break;
    }
}

#pragma mark - Touch events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //NSLog(@"Touch began");
    if (_colorWheelState == VCColorWheelStatePickColor) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        [_colorPickerView touchBeganWithPoint:touchPoint];
    }
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    //NSLog(@"Touch move");
    UITouch *touch = [touches anyObject];
    switch (_colorWheelState) {
        case VCColorWheelStateChangePosition:
            if (touch.view.tag == colorSelectedViewTag) {
                if ([_delegate respondsToSelector:@selector(colorWheelView:moveTouch:)]) {
                    [_delegate colorWheelView:self moveTouch:touch];
                }
            }
            break;
        case VCColorWheelStatePickColor:
            if (touch.view.tag == colorPickerViewTag) {
                CGPoint touchPoint = [touch locationInView:self];
                [_colorPickerView touchMovedWithPoint:touchPoint];
                self.selectedColor = _colorPickerView.selectedColor;
                _colorSelectedView.centerCircle.fillColor = _selectedColor.CGColor;
            }
            break;
        default:
            break;
    }
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    //NSLog(@"Touch end");
    if (_colorWheelState == VCColorWheelStatePickColor) {
        UITouch *touch = [touches anyObject];
        CGPoint touchPoint = [touch locationInView:self];
        [_colorPickerView touchEndWithPoint:touchPoint];
    }
}

#pragma mark - Touch area

- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event {
    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    BOOL isInside = (pow((point.x-center.x), 2) + pow((point.y - center.y), 2) < pow((self.bounds.size.width/2), 2)) ? YES:NO;
    
    return isInside;
}

@end

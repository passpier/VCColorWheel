//
//  VCColorPickerView.h
//  VCColorWheel
//
//  Created by ping sheng cheng on 2018/1/20.
//  Copyright © 2018年 ping sheng cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCColorPickerView : UIView

@property (strong, nonatomic, readonly) CAShapeLayer *colorPickerCircle;
@property (strong, nonatomic, readonly) CAShapeLayer *borderCircle;
@property (strong, nonatomic, readonly) UIColor *selectedColor;

#pragma mark - Spin color wheel methods

- (void)touchBeganWithPoint:(CGPoint)touchPoint;
- (void)touchMovedWithPoint:(CGPoint)touchPoint;
- (void)touchEndWithPoint:(CGPoint)touchPoint;

@end

//
//  VCColorWheelView.h
//  VCColorWheel
//
//  Created by ping sheng cheng on 2018/1/20.
//  Copyright © 2018年 ping sheng cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COLOR_WHEEL_WIDTH 240
#define COLOR_WHEEL_HEIGHT 240

@class VCColorWheelView;

@protocol VCColorWheelViewDelegate <NSObject>
@required
- (void)colorWheelView:(VCColorWheelView *)colorWheelView moveTouch:(UITouch *)touch;
@end

@interface VCColorWheelView : UIView

@property (weak, nonatomic) id<VCColorWheelViewDelegate> delegate;

@property (strong, nonatomic, readonly) UIColor *selectedColor;

@end

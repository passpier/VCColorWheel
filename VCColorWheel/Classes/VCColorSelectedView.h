//
//  VCColorSelectedView.h
//  VCColorWheel
//
//  Created by ping sheng cheng on 2018/1/20.
//  Copyright © 2018年 ping sheng cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCColorSelectedView : UIView

@property (strong, nonatomic, readonly) CAShapeLayer *centerCircle;
@property (strong, nonatomic, readonly) CAShapeLayer *borderCircle;
@property (strong, nonatomic, readonly) CAShapeLayer *arrow;

@end

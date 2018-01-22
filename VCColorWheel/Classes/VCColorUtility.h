//
//  VCColorUtility.h
//  VCColorWheel
//
//  Created by ping sheng cheng on 2018/1/22.
//  Copyright © 2018年 ping sheng cheng. All rights reserved.
//

#ifndef VCColorUtility_h
#define VCColorUtility_h

#define UIColorFromRGB(rgbValue) \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                    green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                    blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                    alpha:1.0]

#define COLORS \
    @[UIColorFromRGB(0xff0000),UIColorFromRGB(0xff4000),UIColorFromRGB(0xff8000), \
    UIColorFromRGB(0xffbf00),UIColorFromRGB(0xffff00),UIColorFromRGB(0xbfff00), \
    UIColorFromRGB(0x80ff00),UIColorFromRGB(0x40ff00),UIColorFromRGB(0x00ff00), \
    UIColorFromRGB(0x00ff40),UIColorFromRGB(0x00ff80),UIColorFromRGB(0x00ffbf), \
    UIColorFromRGB(0x00ffff),UIColorFromRGB(0x00bfff),UIColorFromRGB(0x0080ff), \
    UIColorFromRGB(0x0040ff),UIColorFromRGB(0x0000ff),UIColorFromRGB(0x4000ff), \
    UIColorFromRGB(0x8000ff),UIColorFromRGB(0xbf00ff),UIColorFromRGB(0xff00ff), \
    UIColorFromRGB(0xff00bf),UIColorFromRGB(0xff0080),UIColorFromRGB(0xff0040)]

#define DIVIDEColor UIColorFromRGB(0x1c1c1c)

#endif /* VCColorUtility_h */

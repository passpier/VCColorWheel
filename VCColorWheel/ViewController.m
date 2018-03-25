//
//  ViewController.m
//  VCColorWheel
//
//  Created by ping sheng cheng on 2018/1/19.
//  Copyright © 2018年 ping sheng cheng. All rights reserved.
//

#import "ViewController.h"
#import "VCColorWheelView.h"

@interface ViewController () <VCColorWheelViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *displayView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    VCColorWheelView *colorWheelView = [[VCColorWheelView alloc] init];
    colorWheelView.delegate = self;
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat x = screenRect.size.width * 0.5;
    CGFloat y = screenRect.size.height * 0.5;
    colorWheelView.center = CGPointMake(x, y);
    [_displayView addSubview:colorWheelView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - VCColorWheelViewDelegate methods

- (void)colorWheelView:(VCColorWheelView *)colorWheelView moveTouch:(UITouch *)touch {
    CGPoint touchPoint = [touch locationInView:_displayView];
    colorWheelView.center = touchPoint;
}

@end

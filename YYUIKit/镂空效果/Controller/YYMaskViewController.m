//
//  YYMaskViewController.m
//  YYUIKit
//
//  Created by Michael on 2019/7/16.
//  Copyright © 2019年 winwayworld. All rights reserved.
//

#import "YYMaskViewController.h"

@interface YYMaskViewController ()

@end

@implementation YYMaskViewController
#pragma mark - Cycle life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];


    //创建一个View
    UIView *maskView = [[UIView alloc] initWithFrame:self.view.bounds];
    maskView.backgroundColor = [UIColor redColor];
    maskView.alpha = 0.8;
    [self.view addSubview:maskView];

    //贝塞尔曲线 画一个带有圆角的矩形
    UIBezierPath *bpath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, ScreenWidth, ScreenHeight) cornerRadius:0];

    //贝塞尔曲线 画一个长方形
    UIBezierPath *firstPath = [[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 80, 100, 50) cornerRadius:0] bezierPathByReversingPath];
    [bpath appendPath:firstPath];

    //贝塞尔曲线 画一个圆形
//    [bpath appendPath:[UIBezierPath bezierPathWithArcCenter:maskView.center radius:20 startAngle:0 endAngle:2*M_PI clockwise:NO]];

    //再画一个圆
//    CGPoint otherCenter = CGPointMake(maskView.center.x, maskView.center.y - 50);
//    [bpath appendPath:[UIBezierPath bezierPathWithArcCenter:otherCenter radius:20 startAngle:0 endAngle:2*M_PI clockwise:NO]];

    //创建一个CAShapeLayer 图层
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bpath.CGPath;



    //添加图层蒙板
    maskView.layer.mask = shapeLayer;
}

#pragma mark - Getter And Setter


@end

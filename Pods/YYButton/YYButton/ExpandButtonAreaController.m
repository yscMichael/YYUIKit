//
//  ExpandButtonAreaController.m
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "ExpandButtonAreaController.h"
#import "ExpandButton.h"

@interface ExpandButtonAreaController ()

@end

@implementation ExpandButtonAreaController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    UIView *coverView = [[UIView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
    coverView.backgroundColor = [UIColor clearColor];
    coverView.layer.borderColor = [UIColor redColor].CGColor;
    coverView.layer.borderWidth = 1.0;
    [self.view addSubview:coverView];

    ExpandButton *button = [[ExpandButton alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    button.hitTestEdgeInsets = UIEdgeInsetsMake(-50, -50, -50, -50);
    [button setTitle:@"点我呀" forState:UIControlStateNormal];
    [button setTitle:@"点中了" forState:UIControlStateHighlighted];
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];

    button.center = coverView.center;
}


@end

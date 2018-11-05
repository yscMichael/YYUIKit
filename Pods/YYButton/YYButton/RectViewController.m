//
//  RectViewController.m
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "RectViewController.h"
#import "YYRectButton.h"

@interface RectViewController ()

@end

@implementation RectViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    YYRectButton *button = [[YYRectButton alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [button setTitle:@"我是图片" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];

    //对字符串多余的结尾部分截断
    button.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.backgroundColor = [UIColor greenColor];
    button.imageView.backgroundColor = [UIColor redColor];

    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 2.0;
    [self.view addSubview:button];
}


@end



//
//  ImageIsBiggerController.m
//  UIButton
//
//  Created by 杨世川 on 18/1/20.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "ImageIsBiggerController.h"

@interface ImageIsBiggerController ()

@end

@implementation ImageIsBiggerController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self imageIsBiggerThanButton];
}

//图片尺寸大于按钮的尺寸
- (void)imageIsBiggerThanButton
{
    //1、添加按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"qq.jpg"] forState:UIControlStateNormal];
    [btn setTitle:@"title" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 1.0;
    btn.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:btn];
}

@end

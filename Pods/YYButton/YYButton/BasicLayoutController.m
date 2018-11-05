//
//  BasicLayoutController.m
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "BasicLayoutController.h"
#import "YYLayoutButton.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BasicLayoutController ()

@end

@implementation BasicLayoutController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self imageUp];
    [self imageDown];
    [self imageLeft];
    [self imageRight];
}

- (void)imageUp
{
    YYLayoutButton *button = [[YYLayoutButton alloc]initWithFrame:CGRectMake(0, 64, 100, 100)];
    [button setTitle:@"adminadminadmin" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];

    //这个是需要自己设置的
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.imageType = YYLayoutButtonTypeImageUp;
    //这些参数会影响按钮宽高
    button.buttonImageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    button.buttonTitleEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);

    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 2.0;
    [self.view addSubview:button];
}

- (void)imageDown
{
    YYLayoutButton *button = [[YYLayoutButton alloc]initWithFrame:CGRectMake(0, 200, 100, 100)];
    [button setTitle:@"adminadminadmin" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];

    //这个是需要自己设置的
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.imageType = YYLayoutButtonTypeImageDown;
    //这些参数会影响按钮宽高
    button.buttonTitleEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    button.buttonImageEdgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);

    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 2.0;
    [self.view addSubview:button];
}

- (void)imageLeft
{
    YYLayoutButton *button = [[YYLayoutButton alloc]initWithFrame:CGRectMake(0, 350, 120, 50)];
    [button setTitle:@"admin" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];

    //这个是需要自己设置的
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.imageType = YYLayoutButtonTypeImageLeft;
    //这些参数会影响按钮宽高
    button.buttonTitleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    button.buttonImageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);

    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 2.0;
    [self.view addSubview:button];
}

- (void)imageRight
{
    YYLayoutButton *button = [[YYLayoutButton alloc]initWithFrame:CGRectMake(0, 450, 120, 50)];
    [button setTitle:@"admin" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];

    //这个是需要自己设置的
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    button.imageType = YYLayoutButtonTypeImageRight;
    //这些参数会影响按钮宽高
    button.buttonTitleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    button.buttonImageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    button.layer.borderColor = [UIColor redColor].CGColor;
    button.layer.borderWidth = 2.0;
    [self.view addSubview:button];
    
}


@end





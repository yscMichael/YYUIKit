//
//  YYNavViewController.m
//  YYUIKit
//
//  Created by Michael on 2019/7/25.
//  Copyright © 2019年 winwayworld. All rights reserved.
//

#import "YYNavViewController.h"

@interface YYNavViewController ()
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UIButton *rightButton;
@end

@implementation YYNavViewController
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)initNavBar
{
    //设置返回按钮没有文字

    //设置右边的按钮


}

#pragma mark - Getter And Setter
- (UIButton *)backButton
{
    if (!_backButton)
    {
        _backButton = [[UIButton alloc] initWithFrame:CGRectZero];
    }
    return _backButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton)
    {
        _rightButton = [[UIButton alloc] initWithFrame:CGRectZero];
    }
    return _rightButton;
}


@end

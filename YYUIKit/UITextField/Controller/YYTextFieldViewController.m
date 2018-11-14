//
//  YYTextFieldViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/5.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTextFieldViewController.h"

@interface YYTextFieldViewController ()
//textField输入框
@property (weak, nonatomic) IBOutlet UITextField *YYTextField;
//按钮
@property (weak, nonatomic) IBOutlet UIButton *YYButton;
@end

@implementation YYTextFieldViewController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - 点击按钮
- (IBAction)clickButton:(UIButton *)sender
{
    [self.YYTextField resignFirstResponder];
    self.YYTextField.text = @"123456";
}

@end

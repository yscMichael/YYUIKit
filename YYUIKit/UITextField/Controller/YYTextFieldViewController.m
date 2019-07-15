//
//  YYTextFieldViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/5.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTextFieldViewController.h"

static NSInteger stringLength = 20;

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
    //添加监听事件
    [self.YYTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - Custom Delegate
#pragma mark - UITextFieldDelegate
- (void)textFieldDidChange:(UITextField *)textField
{
    //textFieldString是点击键盘输入的字符
    NSString *contentString = textField.text;
    //防止外部粘贴崩溃
    //去除系统弹出的撤销弹出框，防止崩溃
    [textField.undoManager removeAllActions];
    //去除字符串空格、其他特殊字符也可以过滤、待定
    NSString *textFieldString = [contentString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    //根据不同的textField可以设置不同的限制长度
    //检测当前的输入法
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"])
    {//中文输入
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position)
        {//没有高亮选择的字，则对已输入的文字进行字数统计和限制
            if (textFieldString.length > stringLength)
            {
                textField.text = [textFieldString substringToIndex:stringLength];
            }
        }
        else
        {//有高亮选择的字符串，则暂不对蚊子进行统计和限制、随便输入、因为你输入三个字母，可能只出现一个字，做限制会影响用户输入；但是，一旦字符不变成高亮的，进入textField，就会走上面程序，即使字符过长，也会被截断
            NSLog(@"有高亮字符串");
        }
    }
    else
    {//中文输入法以外的，直接对其统计限制即可，不考虑其他语种情况
        if (textFieldString.length > stringLength)
        {
            //判断最后一个字符的长度
            NSRange rangeIndex = [textFieldString rangeOfComposedCharacterSequenceAtIndex:stringLength];
            if (rangeIndex.length == 1)
            {//最后一个是正常字符
                textField.text = [textFieldString substringToIndex:stringLength];
            }
            else
            {//最后一个不是正常字符
                //根据最后一个字符、重新计算包含当前字符串的范围
                NSRange rangeRange = [textFieldString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, stringLength)];
                textField.text = [textFieldString substringWithRange:rangeRange];
            }
        }
    }
}

#pragma mark - Event Response
#pragma mark - 点击按钮
- (IBAction)clickButton:(UIButton *)sender
{
    [self.YYTextField resignFirstResponder];
    self.YYTextField.text = @"123456";
}

@end

//
//  YYDatePickerController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/9/27.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYDatePickerController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 20

@interface YYDatePickerController ()
//系统时间选择器
@property (nonatomic ,strong) UIDatePicker *datePicker;
@end

@implementation YYDatePickerController
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.datePicker];
    [self.datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
    //设置地区: zh-中国
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
    self.datePicker.locale = locale;
    //设置当前时间
    //[self.datePicker setDate:[NSDate date] animated:YES];
    //设置最大时间
//    [self.datePicker setMaximumDate:[NSDate date]];
    //设置最小时间
    NSDate *currentDate = [NSDate date];
    NSCalendar*calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setYear:-10];//设置最小时间为：当前时间前推十年
    NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
//    [self.datePicker setMinimumDate:minDate];


    //设置模式
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];


    //[self.datePicker setCalendar:[NSCalendar currentCalendar]];
    //[self.datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
    //[self.datePicker setCountDownDuration:10 * 60];
    //self.datePicker.minuteInterval = 15;

    //[self.datePicker setDatePickerMode:UIDatePickerModeTime];
    //[self.datePicker setDatePickerMode:UIDatePickerModeDateAndTime];
    //[self.datePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
}

#pragma mark - Event Response
#pragma mark - 日期选择器变化
- (void)dateChange:(UIDatePicker*)dateSender
{
    UIDatePicker *ctrl = (UIDatePicker*)dateSender;
    NSDate *date = ctrl.date;
    NSLog(@"日期选择器变化 = %@",date);
}

#pragma mark - Getter And Setter
- (UIDatePicker *)datePicker
{
    if (!_datePicker)
    {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, ScreenHeight - 300, ScreenWidth, 300)];
        _datePicker.layer.borderColor = [UIColor redColor].CGColor;
        _datePicker.layer.borderWidth = 1.0;
    }
    return _datePicker;
}

@end

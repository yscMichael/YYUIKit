//
//  YYRunTimeViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/12/25.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYRunTimeViewController.h"
#import "Tool.h"
#import "Person.h"

@interface YYRunTimeViewController ()

@end

@implementation YYRunTimeViewController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    //1、模型
    Person *personOne = [[Person alloc] init];
    personOne.name = @"张三";
    personOne.age = 12;
    //动态添加属性
    [Tool addAssociatedWithtarget:personOne withPropertyName:@"weight" withValue:@"150kg"];
    NSString *weight = [Tool getAssociatedValueWithTarget:personOne withPropertyName:@"weight"];
    NSLog(@"personOnepersonOne = %@",weight);

    Person *personTwo = [[Person alloc] init];
    personTwo.name = @"李四";
    personTwo.age = 10;
    NSString *weightTwo = [Tool getAssociatedValueWithTarget:personTwo withPropertyName:@"weight"];
    NSLog(@"personTwopersonTwo = %@",weightTwo);
}

#pragma mark - Getter And Setter

@end

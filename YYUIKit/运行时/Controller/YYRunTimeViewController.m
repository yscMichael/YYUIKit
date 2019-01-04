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
#import "YYTestPerson.h"
#import "YYTestRuntimeModel.h"

@interface YYRunTimeViewController ()

@end

@implementation YYRunTimeViewController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //[self testBasicModel];
    [self runtimeModel];
}

#pragma mark - 测试基本模型
- (void)testBasicModel
{
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

#pragma mark - 测试运行时模型
- (void)runtimeModel
{
    //1、初始化
    YYTestRuntimeModel *testRuntimeModel = [[YYTestRuntimeModel alloc] init];
    testRuntimeModel.name = @"张三";
    testRuntimeModel.testPerson.name = @"张三---123";
    YYTestPerson *testPerson = [[YYTestPerson alloc] init];
    testPerson.name = @"张三---person";
    [testRuntimeModel.testModelArray addObject:testPerson];
    //2、拷贝
    YYTestRuntimeModel *tempModel = [testRuntimeModel mutableCopy];
    tempModel.name = @"李四";
    tempModel.testPerson.name = @"李四---123";
    YYTestPerson *tempPerson = [tempModel.testModelArray lastObject];
    tempPerson.name = @"李四---person";
    NSLog(@"tempModel%@",tempModel);
}

#pragma mark - Getter And Setter

@end

//
//  YYMathViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/12/18.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYMathViewController.h"

@interface YYMathViewController ()

@end

@implementation YYMathViewController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    NSMutableArray *dataSource = [[NSMutableArray alloc] init];
    NSString *first = @"first";
    NSNumber *number = [NSNumber numberWithInt:1];
    [dataSource addObject:first];
    [dataSource addObject:number];
    NSLog(@"dataSourcedataSource = %@",dataSource);
}

#pragma mark - Getter And Setter


//备注:
//https://www.jianshu.com/p/b9552f2d76dd
//round  如果参数是小数  则求本身的四舍五入.
//ceil   如果参数是小数  则求最小的整数但不小于本身.
//floor  如果参数是小数  则求最大的整数但不大于本身.
@end

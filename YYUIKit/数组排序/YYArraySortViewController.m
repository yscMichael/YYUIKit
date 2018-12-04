//
//  YYArraySortViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/10/30.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYArraySortViewController.h"

@interface YYArraySortViewController ()
//数据源
@property (nonatomic ,strong) NSMutableArray *dataArray;
@end

@implementation YYArraySortViewController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //升序
    //[self ascendingArray];
    //降序
    //[self descendingArray];
    //删除元素
    [self deleteItemInArray];
}

#pragma mark - 升序
- (void)ascendingArray
{
    NSArray *tempArr = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        if (obj1.intValue > obj2.intValue)
        {
            return NSOrderedDescending;//交换数字
        }
        return NSOrderedAscending;
    }];
    NSLog(@"升序结果 = %@",tempArr);
}

#pragma mark - 降序
- (void)descendingArray
{
    NSArray *tempArr = [self.dataArray sortedArrayUsingComparator:^NSComparisonResult(NSNumber *obj1, NSNumber *obj2) {
        if (obj1.intValue > obj2.intValue)
        {
            return NSOrderedAscending;//不交换数字
        }
        return NSOrderedDescending;
    }];
    NSLog(@"降序结果 = %@",tempArr);
}

#pragma mark - 数组遍历删除元素
- (void)deleteItemInArray
{
    NSMutableArray *dataSource = [[NSMutableArray alloc] initWithObjects:
                                  @"1",
                                  @"4",
                                  @"3",
                                  @"5",
                                  @"3",
                                  @"6",
                                  @"7",
                                  @"3",
                                  @"1",nil];
    for (int i = 0; i < dataSource.count; i ++)
    {
        NSString *item = dataSource[i];
        if ([item isEqualToString:@"3"])
        {
            [dataSource removeObject:item];
            i --;
        }
    }
    NSLog(@"dataSource = %@",dataSource);
}


#pragma mark - Getter And Setter
- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc] initWithObjects:
                      @1,
                      @0,
                      @3,
                      @9,
                      @4,
                      @6,nil];
    }
    return _dataArray;
}

@end

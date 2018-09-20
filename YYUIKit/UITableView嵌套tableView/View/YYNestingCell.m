//
//  YYNestingCell.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/9/20.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYNestingCell.h"
#import "YYNestingSmallCell.h"

@interface YYNestingCell ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation YYNestingCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.tableViewHeight.constant = 45.0;
    self.tableView.bounces = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"YYNestingSmallCell" bundle:nil] forCellReuseIdentifier:@"YYNestingSmallCell"];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //动态设置的高度
    if(indexPath.row == ((NSIndexPath *)[[tableView indexPathsForVisibleRows] firstObject]).row)
    {
        NSLog(@"--------");
        dispatch_async(dispatch_get_main_queue(), ^{

            //1、这个也没有用
            //CGRect frame = tableView.frame;
            //frame.size.height = tableView.contentSize.height;
            //self.tableView.frame = frame;

            //2、这句话不刷新界面没有用
            //self.tableViewHeight.constant = tableView.contentSize.height;

            //3、下面两行代码会引起死循环
            //UITableView *tableView = [self getRefreshTableView];
            //[tableView reloadData];
        });
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYNestingSmallCell *smallCell = [tableView dequeueReusableCellWithIdentifier:@"YYNestingSmallCell"];
    //赋值
    smallCell.titleLabel.text = self.dataSource[indexPath.row];
    return smallCell;
}

#pragma mark - Private Methods
- (UITableView *)getRefreshTableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView)
    {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}

#pragma mark - Getter And Setter
- (void)setDataSource:(NSMutableArray *)dataSource
{
    _dataSource = dataSource;
    [self.tableView reloadData];
}

@end

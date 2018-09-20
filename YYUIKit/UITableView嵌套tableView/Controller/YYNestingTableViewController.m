//
//  YYNestingTableViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/9/20.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYNestingTableViewController.h"
#import "YYNestingCell.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 20

@interface YYNestingTableViewController ()<UITableViewDelegate,UITableViewDataSource>
//数据源
@property (nonatomic,strong) NSMutableArray *dataSource;
//列表
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation YYNestingTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *tempArray = self.dataSource[indexPath.row];
    return (tempArray.count * 45.0 + 20);
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYNestingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYNestingCell"];
    //赋值
    NSMutableArray *tempArray = self.dataSource[indexPath.row];
    cell.dataSource = tempArray;
    return cell;
}

#pragma mark - Getter And Setter
- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc] initWithObjects:
                       @[@"0--1"],
                       @[@"1--1",@"1--2"],
                       @[@"2--1"],
                       @[@"3--1",@"3--2",@"3--3"],
                       @[@"5--1",@"5--2"],
                       @[@"6--1"],
                       @[@"7--1",@"7--2",@"7--3",@"7--4"],
                       @[@"8--1",@"8--2"],
                       @[@"9--1"],
                       @[@"10--1",@"10--2"],nil];
    }
    return _dataSource;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64)];
        _tableView.backgroundColor = [UIColor greenColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"YYNestingCell" bundle:nil] forCellReuseIdentifier:@"YYNestingCell"];
        //自适应高度
        _tableView.estimatedRowHeight = 90;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

@end

//
//  YYTableViewSectionSingleController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/15.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTableViewSectionSingleController.h"
#import "YYTestCell.h"
#import "YYTestModel.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 20

@interface YYTableViewSectionSingleController ()<UITableViewDelegate,UITableViewDataSource>
//数据源
@property (nonatomic,strong) NSMutableArray *dataSource;
//列表
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation YYTableViewSectionSingleController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - 初始化模型
- (void)initData
{
    //第一组
    YYTestModel *one = [[YYTestModel alloc] init];
    one.groupNo = 1;

    YYTestModel *two = [[YYTestModel alloc] init];
    two.groupNo = 0;

    //第二组
    YYTestModel *three = [[YYTestModel alloc] init];
    three.groupNo = 2;

    YYTestModel *four = [[YYTestModel alloc] init];
    four.groupNo = 0;

    //第三组
    YYTestModel *five = [[YYTestModel alloc] init];
    five.groupNo = 3;

    YYTestModel *six = [[YYTestModel alloc] init];
    six.groupNo = 0;

    YYTestModel *seven = [[YYTestModel alloc] init];
    seven.groupNo = 0;

    [self.dataSource addObject:one];
    [self.dataSource addObject:two];
    [self.dataSource addObject:three];
    [self.dataSource addObject:four];
    [self.dataSource addObject:five];
    [self.dataSource addObject:six];
    [self.dataSource addObject:seven];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYTestCell"];
    //赋值
    YYTestModel *model = self.dataSource[indexPath.row];
    cell.testModel = model;
    return cell;
}

#pragma mark - Getter And Setter
- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc] init];
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
        [_tableView registerNib:[UINib nibWithNibName:@"YYTestCell" bundle:nil] forCellReuseIdentifier:@"YYTestCell"];
        //自适应高度
        _tableView.estimatedRowHeight = 90;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

@end

//
//  YYTableViewSectionManyController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/15.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTableViewSectionManyController.h"
#import "YYManyCell.h"
#import "YYTestModel.h"
#import "YYHeadTestView.h"
#import "YYFootTestView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 20

@interface YYTableViewSectionManyController ()<UITableViewDelegate,UITableViewDataSource>
//列表
@property (nonatomic,strong) UITableView *tableView;
//数据源
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation YYTableViewSectionManyController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)initView
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.tableView];
}

- (void)initData
{
    YYTestModel *one = [[YYTestModel alloc] init];
    one.groupNo = 1;
    [one.dataSource addObject:@"1"];
    [one.dataSource addObject:@"1"];
    [one.dataSource addObject:@"1"];

    YYTestModel *two = [[YYTestModel alloc] init];
    two.groupNo = 0;
    [two.dataSource addObject:@"1"];
    [two.dataSource addObject:@"1"];

    YYTestModel *three = [[YYTestModel alloc] init];
    three.groupNo = 2;
    [three.dataSource addObject:@"1"];
    [three.dataSource addObject:@"1"];
    [three.dataSource addObject:@"1"];

    YYTestModel *four = [[YYTestModel alloc] init];
    four.groupNo = 0;
    [four.dataSource addObject:@"1"];
    [four.dataSource addObject:@"1"];

    YYTestModel *five = [[YYTestModel alloc] init];
    five.groupNo = 3;
    [five.dataSource addObject:@"1"];

    YYTestModel *six = [[YYTestModel alloc] init];
    six.groupNo = 0;
    [six.dataSource addObject:@"1"];
    [six.dataSource addObject:@"1"];
    [six.dataSource addObject:@"1"];

    YYTestModel *seven = [[YYTestModel alloc] init];
    seven.groupNo = 0;
    [seven.dataSource addObject:@"1"];
    [seven.dataSource addObject:@"1"];


    [self.dataSource addObject:one];
    [self.dataSource addObject:two];
    [self.dataSource addObject:three];
    [self.dataSource addObject:four];
    [self.dataSource addObject:five];
    [self.dataSource addObject:six];
    [self.dataSource addObject:seven];
}

#pragma mark - UITableViewDelegate
//head
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YYHeadTestView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"YYHeadTestView"];
    YYTestModel *model = self.dataSource[section];
    headView.model = model;
    return headView;
}

//head-height
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    YYTestModel *model = self.dataSource[section];
    if (model.groupNo == 0)
    {
        return 65;
    }
    else
    {
        return 80;
    }
}

//foot
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    YYFootTestView *footView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"YYFootTestView"];
    return footView;
}

//foot-height
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 80;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    YYTestModel *model = self.dataSource[section];
    return model.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYManyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYManyCell"];
    //赋值
    YYTestModel *model = self.dataSource[indexPath.section];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor greenColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //cell
        [_tableView registerNib:[UINib nibWithNibName:@"YYManyCell" bundle:nil] forCellReuseIdentifier:@"YYManyCell"];
        //head
        [_tableView registerNib:[UINib nibWithNibName:@"YYHeadTestView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"YYHeadTestView"];
        //foot
        [_tableView registerNib:[UINib nibWithNibName:@"YYFootTestView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"YYFootTestView"];
        //自适应高度
        _tableView.estimatedRowHeight = 90;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}


@end

//
//  YYTableViewLayoutController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/14.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTableViewLayoutController.h"
#import "YYLayoutCell.h"
#import "YYLayoutModel.h"

static float tableViewEstimatedRowHeight = 80.0;
@interface YYTableViewLayoutController ()<UITableViewDelegate,UITableViewDataSource>
//数据源
@property (nonatomic,strong) NSMutableArray *dataSoure;
//列表
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation YYTableViewLayoutController
//用iPad进行测试
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
}

- (void)initView
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)initData
{
    //1.头孢克洛胶囊(10粒/盒）  香港澳美制药  1 盒  120元
    YYLayoutModel *modelOne = [[YYLayoutModel alloc] init];
    modelOne.key_name = @"1.头孢克洛胶囊(10粒/盒)--测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长测试名字太长";
    modelOne.factoryString = @"香港澳美制药";
    modelOne.countString = @"1";
    modelOne.unitString = @"盒";
    modelOne.priceString = @"110元";

    YYLayoutModel *modelTwo = [[YYLayoutModel alloc] init];
    modelTwo.key_name = @"2.头孢克洛胶囊(10粒/盒）";
    modelTwo.factoryString = @"香港澳美制药--我是不是太长了我是不是太长了我是不是太长了我是不是太长了我是不是太长了我是不是太长了我是不是太长了我是不是太长了我是不是太长了我是不是太长了";
    modelTwo.countString = @"2";
    modelTwo.unitString = @"盒";
    modelTwo.priceString = @"120元";

    YYLayoutModel *modelThree = [[YYLayoutModel alloc] init];
    modelThree.key_name = @"3.头孢克洛胶囊(10粒/盒）";
    modelThree.factoryString = @"香港澳美制药";
    modelThree.countString = @"3";
    modelThree.unitString = @"盒-我哒哒哒哒哒哒哒哒哒哒哒哒";
    modelThree.priceString = @"130元";

    YYLayoutModel *modelFour = [[YYLayoutModel alloc] init];
    modelFour.key_name = @"3.头孢克洛胶囊(10粒/盒）";
    modelFour.factoryString = @"香港澳美制药";
    modelFour.countString = @"3";
    modelFour.unitString = @"盒";
    modelFour.priceString = @"130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元130元";

    [self.dataSoure addObject:modelOne];
    [self.dataSoure addObject:modelTwo];
    [self.dataSoure addObject:modelThree];
    [self.dataSoure addObject:modelFour];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section
{
    return self.dataSoure.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYLayoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYLayoutCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //赋值
    YYLayoutModel *model = self.dataSoure[indexPath.row];
    cell.model = model;
    return cell;
}

#pragma mark - Getter And Setter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64,ScreenWidth, ScreenHeight - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"YYLayoutCell" bundle:nil] forCellReuseIdentifier:@"YYLayoutCell"];
        //自适应高度
        _tableView.estimatedRowHeight = tableViewEstimatedRowHeight;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)dataSoure
{
    if (!_dataSoure)
    {
        _dataSoure = [[NSMutableArray alloc] init];
    }
    return _dataSoure;
}

@end

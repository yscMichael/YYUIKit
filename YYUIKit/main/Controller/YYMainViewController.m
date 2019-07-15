//
//  YYMainViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/9/2.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYMainViewController.h"
#import "YYMainTableViewCell.h"
#import "YYArraySortViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 20

@interface YYMainViewController ()<UITableViewDataSource,UITableViewDelegate>
//列表
@property (nonatomic,strong) UITableView *tableView;
//展示数据源
@property (nonatomic,strong) NSMutableArray *dataSoure;
//控制器数据源
@property (nonatomic,strong) NSMutableArray *controllerSoure;
@end

@implementation YYMainViewController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 80, 100, 50)];
//    button.backgroundColor = [UIColor blueColor];
//    [button addTarget:self action:@selector(pressentCtrl:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];

    [self.view addSubview:self.tableView];
}

- (void)pressentCtrl:(UIButton *)sender
{
    NSLog(@"pressentCtrlpressentCtrlpressentCtrlpressentCtrl");
    YYArraySortViewController *testCtrl = [[YYArraySortViewController alloc] init];
    [self presentViewController:testCtrl animated:YES completion:^{
        
    }];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ctrlString = self.controllerSoure[indexPath.row];
    Class viewControl = NSClassFromString(ctrlString);
    YYLog(@"ctrlStringctrlString = %@",ctrlString);
    UIViewController *viewcontroller = [[viewControl alloc]init];
    [self.navigationController pushViewController:viewcontroller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section
{
    return self.dataSoure.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.titleLabel.text = self.dataSoure[indexPath.row];
    return cell;
}

#pragma mark - Getters And Setters
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"YYMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSMutableArray *)dataSoure
{
    if (!_dataSoure)
    {

        _dataSoure = [[NSMutableArray alloc]initWithObjects:
                      @"数组排序",
                      @"Label相关",
                      @"UITextField相关",
                      @"UITableView分组",
                      @"tableView自动布局",
                      @"UICollectionView分组",
                      @"UICollectionSearch框",
                      @"UITableView嵌套",
                      @"TableView分组(单个cell)",
                      @"TableView分组(多个cell)",
                      @"tableView动态更新头部",
                      @"OC中的数学函数",
                      @"运行时相关知识介绍",
                      @"数组拷贝",
                      @"子View超出父类范围",
                      @"UIDatePicker时间选择器",
                      @"轮播图",
                      @"二维码扫描",
                      @"自定义按钮",nil];
    }
    return _dataSoure;
}

- (NSMutableArray *)controllerSoure
{
    if (!_controllerSoure)
    {
        _controllerSoure = [[NSMutableArray alloc] initWithObjects:
                            @"YYArraySortViewController",
                            @"YYLabelViewController",
                            @"YYTextFieldViewController",
                            @"YYTableViewController",
                            @"YYTableViewLayoutController",
                            @"YYCollectionViewController",
                            @"YYCollectionSearchController",
                            @"YYNestingTableViewController",
                            @"YYTableViewSectionSingleController",
                            @"YYTableViewSectionManyController",
                            @"YYTableViewHeaderViewController",
                            @"YYMathViewController",
                            @"YYRunTimeViewController",
                            @"YYArrayCopyViewController",
                            @"YYBeyondParentViewController",
                            @"YYDatePickerController",
                            @"YYScrollController",
                            @"scanQRCodeController",
                            @"ViewController",nil];
    }
    return _controllerSoure;
}

@end

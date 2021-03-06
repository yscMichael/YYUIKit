//
//  YYTableViewController.m
//  TestTableViewProject
//
//  Created by 杨世川 on 2018/9/7.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTableViewController.h"
#import "YYTableViewCell.h"
#import "YYFootView.h"
#import "YYDrugModel.h"
#import "YYNoDataView.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 20

@interface YYTableViewController ()<UITableViewDataSource,UITableViewDelegate>

//列表
@property (nonatomic,strong) UITableView *tableView;
//数据源
@property (nonatomic,strong) NSMutableArray *dataSoure;
//footView
@property (nonatomic,strong) YYFootView *footView;
//底部按钮
@property (nonatomic,strong) UIButton *bottomButton;
//增加新的药品分组
@property (nonatomic,assign) BOOL isAddNewSectionDrug;
//在当前选中分组下增加药品
@property (nonatomic,assign) BOOL isAddNewDrug;
//当前添加药品的数组
@property (nonatomic,strong) NSMutableArray *currentArray;
//当前选中的cell
@property (nonatomic,strong) YYTableViewCell *currentCell;
//无数据提示
@property (nonatomic,strong) YYNoDataView *noDataView;
//无数据
@property (nonatomic,assign) BOOL isNoData;

@end

@implementation YYTableViewController

#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initData];
    [self initView];
}

- (void)initData
{
    self.isAddNewSectionDrug = NO;
    self.isAddNewDrug = NO;
    self.isNoData = NO;
    NSMutableArray *tempOne = [[NSMutableArray alloc] initWithObjects:[[YYDrugModel alloc] init], nil];
    NSMutableArray *tempTwo = [[NSMutableArray alloc] initWithObjects:[[YYDrugModel alloc] init], nil];
    NSMutableArray *tempThree = [[NSMutableArray alloc] initWithObjects:[[YYDrugModel alloc] init],[[YYDrugModel alloc] init], nil];
    [self.dataSoure addObject:tempOne];
    [self.dataSoure addObject:tempTwo];
    [self.dataSoure addObject:tempThree];
}

- (void)initView
{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomButton];

    self.tableView.tableFooterView = self.footView;
    self.footView.frame = CGRectMake(0, 0, ScreenWidth, 50);
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //动态设置TableView加载完毕后TableView的高度
    if(indexPath.row == ((NSIndexPath *)[[tableView indexPathsForVisibleRows] lastObject]).row)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, ScreenWidth, tableView.contentSize.height);
            //需要重新设置footView
            CGRect frame = self.footView.frame;
            frame.size.height = 50;
            self.footView.frame = frame;
        });
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 25)];
    view.backgroundColor = [UIColor redColor];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSoure.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) section
{
    NSArray *sectionArray = self.dataSoure[section];
    return sectionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //位置
    cell.indexPath = indexPath;
    //模型
    NSArray *sourceArray = self.dataSoure[indexPath.section];
    YYDrugModel *model = (YYDrugModel *)sourceArray[indexPath.row];
    cell.drugModel = model;
    //点击数量按钮
    __weak typeof(self) weakSelf = self;
    cell.clickCountBlock = ^(NSIndexPath *indexPath,BOOL isSelected,YYTableViewCell *cell){
        [weakSelf clickCountButton:indexPath isSelected:isSelected withCell:cell];
    };
    //点击删除按钮
    cell.clickDeleteBlock = ^(NSIndexPath *indexPath){
        [weakSelf clickDeleteButton:indexPath];
    };
    if (model.isDrugSelected)
    {//指定当前对象
        self.isAddNewDrug = YES;
        self.currentCell = cell;
        self.currentArray = self.dataSoure[indexPath.section];
    }
    return cell;
}

#pragma mark - Event Response
#pragma mark - 点击数量按钮
- (void)clickCountButton:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected withCell:(YYTableViewCell *)cell
{
    //选中标志
    self.isAddNewDrug = isSelected;
    //当前数组处理
    self.currentArray = isSelected ? self.dataSoure[indexPath.section]: nil;
    //旧模型取消选中
    self.currentCell.countButton.selected = NO;
    self.currentCell.drugModel.isDrugSelected = NO;
    //当前模型状态更新
    self.currentCell = cell;
    self.currentCell.countButton.selected = isSelected;
    self.currentCell.drugModel.isDrugSelected = isSelected;
    //底部按钮选中消除
    self.footView.addButton.selected = NO;
    self.isAddNewSectionDrug = NO;
}

#pragma mark - 点击删除按钮
- (void)clickDeleteButton:(NSIndexPath *)indexPath
{
    NSMutableArray *tempArray = self.dataSoure[indexPath.section];
    //判断模型是否是选中状态(防止删除的是选中的那个)
    YYDrugModel *model = tempArray[indexPath.row];
    if (model.isDrugSelected)
    {
        if (tempArray.count > 1)
        {
            [tempArray removeObjectAtIndex:indexPath.row];
            YYDrugModel *model = [tempArray firstObject];
            model.isDrugSelected = YES;
        }
        else
        {
            self.isAddNewDrug = NO;
            [tempArray removeObjectAtIndex:indexPath.row];
        }
    }
    else
    {
        [tempArray removeObjectAtIndex:indexPath.row];
    }
    //遍历数组(去除空数组)
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.dataSoure.count; i ++)
    {
        NSMutableArray *temp = (NSMutableArray *)self.dataSoure[i];
        if (temp.count != 0)
        {
            [resultArray addObject:temp];
        }
    }
    [self.dataSoure removeAllObjects];
    [self.dataSoure addObjectsFromArray:resultArray];
    //处理无数据
    if (self.dataSoure.count == 0)
    {
        [self dealNoData];
    }
    [self.tableView reloadData];
}

#pragma mark - 增加分组
- (void)clickAddButton:(UIButton *)sender
{
    NSLog(@"选中增加分组按钮");
    sender.selected = !sender.selected;
    //设置选中标志
    self.isAddNewSectionDrug = sender.selected;
    //设置显示文字
    NSString *contentString = sender.isSelected ? [NSString stringWithFormat:@"%lu",self.dataSoure.count + 1] : @"";
    [sender setTitle:contentString forState:UIControlStateNormal];
    //设置cell状态
    self.isAddNewDrug = NO;
    self.currentCell.drugModel.isDrugSelected = NO;
    self.currentCell.countButton.selected = NO;
}

#pragma mark - 增加药品
- (void)addDrug:(UIButton *)sender
{
    if (self.isAddNewSectionDrug)
    {//增加新的分组
        NSLog(@"增加新的分组增加新的分组---1");
        YYDrugModel *model = [[YYDrugModel alloc] init];
        model.isDrugSelected = YES;
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:model, nil];
        [self.dataSoure addObject:tempArray];
        if (self.isNoData)
        {
            [self.noDataView removeFromSuperview];
            self.isNoData = NO;
        }
        //刷新列表
        [self.tableView reloadData];
        //重置footView
        self.footView.addButton.selected = NO;
        self.isAddNewSectionDrug = NO;
    }
    else if(self.isAddNewDrug)
    {//增加新的药品
        NSLog(@"增加新的药品----2");
        [self.currentArray addObject:[[YYDrugModel alloc] init]];
        [self.tableView reloadData];
    }
    else
    {
        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择分组" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVc addAction:sureAction];
        [self presentViewController:alertVc animated:YES completion:^{
        }];
    }
}

#pragma mark - Private Methods
- (void)dealNoData
{
    CGRect frame = self.tableView.frame;
    frame.size.height = 200;
    self.tableView.frame = frame;
    self.footView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [self.view addSubview:self.noDataView];
    [self.view bringSubviewToFront:self.noDataView];
    self.isAddNewSectionDrug = YES;
    self.isNoData = YES;
}

#pragma mark - Getter And Setter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 100 - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor greenColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"YYTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (YYFootView *)footView
{
    if (!_footView)
    {
        _footView = [[[NSBundle mainBundle] loadNibNamed:@"YYFootView" owner:nil options:nil] lastObject];
        [_footView.addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}

- (YYNoDataView *)noDataView
{
    if (!_noDataView)
    {
        _noDataView = [[[NSBundle mainBundle] loadNibNamed:@"YYNoDataView" owner:nil options:nil] lastObject];
        _noDataView.frame = CGRectMake(0, 64, ScreenWidth, 200);
    }
    return _noDataView;
}

- (UIButton *)bottomButton
{
    if (!_bottomButton)
    {
        _bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight - 50, ScreenWidth, 50)];
        _bottomButton.backgroundColor = [UIColor blueColor];
        [_bottomButton setTitle:@"添加药品" forState:UIControlStateNormal];
        [_bottomButton addTarget:self action:@selector(addDrug:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomButton;
}

- (NSMutableArray *)dataSoure
{
    if (!_dataSoure)
    {
        _dataSoure = [[NSMutableArray alloc] init];
    }
    return _dataSoure;
}

- (NSMutableArray *)currentArray
{
    if (!_currentArray)
    {
        _currentArray = [[NSMutableArray alloc] init];
    }
    return _currentArray;
}

@end

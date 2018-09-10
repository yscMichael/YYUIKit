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

@end

@implementation YYTableViewController

#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    [self initView];
}

- (void)initData
{
    self.isAddNewSectionDrug = NO;
    self.isAddNewDrug = NO;
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
    [self.view addSubview:self.footView];
    [self.view addSubview:self.bottomButton];
    self.footView.frame = CGRectMake(0, ScreenHeight - 100, ScreenWidth, 50);
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    view.backgroundColor = [UIColor lightGrayColor];
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
    //组号
    cell.sectionInt = (int)indexPath.section;
    //行号
    cell.row = (int)indexPath.row;
    //模型
    NSArray *sourceArray = self.dataSoure[indexPath.section];
    YYDrugModel *model = (YYDrugModel *)sourceArray[indexPath.row];
    cell.drugModel = model;
    //判断当前cell是否是选中状态
    if (model.isDrugSelected)
    {
        //根据组号获取数组
        self.currentArray = self.dataSoure[indexPath.section];
        self.isAddNewDrug = YES;
        //当前选中模型
        self.currentCell = cell;
        self.currentCell.countButton.selected = YES;
        self.currentCell.drugModel.isDrugSelected = YES;

    }
    //点击数量按钮
    __weak typeof(self) weakSelf = self;
    cell.clickCountBlock = ^(int section,BOOL isSelected,YYTableViewCell *cell){
        [weakSelf clickCountButton:section isSelected:isSelected withCell:cell];
    };
    //点击删除按钮
    cell.clickDeleteBlock = ^(int row,int sectionInt){
        [weakSelf clickDeleteButton];
    };
    return cell;
}

#pragma mark - Event Response
#pragma mark - 点击数量按钮
- (void)clickCountButton:(int)sectionInt isSelected:(BOOL)isSelected withCell:(YYTableViewCell *)cell
{
    if (isSelected)
    {
        NSLog(@"sectionIntsectionInt = %d",sectionInt);
        //根据组号获取数组
        self.currentArray = self.dataSoure[sectionInt];
        self.isAddNewDrug = YES;
        //旧模型取消选中
        self.currentCell.countButton.selected = NO;
        self.currentCell.drugModel.isDrugSelected = NO;
        //当前选中cell,选中(放置选中同一个)
        self.currentCell = cell;
        self.currentCell.countButton.selected = YES;
        self.currentCell.drugModel.isDrugSelected = YES;
        //底部按钮选中消除
        self.footView.addButton.selected = NO;
        self.isAddNewSectionDrug = NO;
    }
    else
    {
        self.isAddNewDrug = NO;
    }
}

#pragma mark - 点击删除按钮
- (void)clickDeleteButton
{

}

#pragma mark - 增加分组
- (void)clickAddButton:(UIButton *)sender
{
    NSLog(@"选中增加分组按钮");
    sender.selected = !sender.selected;
    if (sender.isSelected)
    {
        self.currentCell.drugModel.isDrugSelected = NO;
        self.currentCell.countButton.selected = NO;
        self.isAddNewDrug = NO;
        [sender setTitle:[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSoure.count + 1] forState:UIControlStateNormal];
        self.isAddNewSectionDrug = YES;
    }
    else
    {
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.isAddNewSectionDrug = NO;
    }
}

#pragma mark - 增加药品
- (void)addDrug:(UIButton *)sender
{
    if (self.isAddNewSectionDrug)
    {
        NSLog(@"增加新的分组");
        //数据源中添加药品
        YYDrugModel *model = [[YYDrugModel alloc] init];
        model.isDrugSelected = YES;
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:model, nil];
        [self.dataSoure addObject:tempArray];
        //刷新列表
        [self.tableView reloadData];
        //重置footView
        self.footView.addButton.selected = NO;
        self.isAddNewSectionDrug = NO;
    }
    else if(self.isAddNewDrug)
    {
        NSLog(@"增加新的药品");
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

#pragma mark - Getter And Setter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 180)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor greenColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"YYTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
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

- (YYFootView *)footView
{
    if (!_footView)
    {
        _footView = [[[NSBundle mainBundle] loadNibNamed:@"YYFootView" owner:nil options:nil] lastObject];
        [_footView.addButton addTarget:self action:@selector(clickAddButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footView;
}

- (NSMutableArray *)currentArray
{
    if (!_currentArray)
    {
        _currentArray = [[NSMutableArray alloc] init];
    }
    return _currentArray;
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

@end

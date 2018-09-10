//
//  YYCollectionViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/9/10.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYCollectionViewController.h"
#import "YYCollectionViewCell.h"
#import "YYFootView.h"
#import "YYDrugModel.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 20

//左边间距
static float WWLeftMargin = 0;
//右边间距
static float WWRightMargin = 0;
//cell宽度
static float WWCellWidth = 0.0;
//cell高度
static float WWCellHeight = 40;
//垂直方向间距
static float WWLineSpacing = 0;

@interface YYCollectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
//列表
@property (nonatomic ,strong) UICollectionView *collectionView;
//布局
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
//数据源
@property (nonatomic ,strong) NSMutableArray *dataSource;
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
@property (nonatomic,strong) YYCollectionViewCell *currentCell;

@end

@implementation YYCollectionViewController

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
    WWCellWidth = (ScreenWidth - WWLeftMargin - WWRightMargin)/2.0;
    self.isAddNewSectionDrug = NO;
    self.isAddNewDrug = NO;
    NSMutableArray *tempOne = [[NSMutableArray alloc] initWithObjects:[[YYDrugModel alloc] init], nil];
    NSMutableArray *tempTwo = [[NSMutableArray alloc] initWithObjects:[[YYDrugModel alloc] init], nil];
    NSMutableArray *tempThree = [[NSMutableArray alloc] initWithObjects:[[YYDrugModel alloc] init],[[YYDrugModel alloc] init], nil];
    [self.dataSource addObject:tempOne];
    [self.dataSource addObject:tempTwo];
    [self.dataSource addObject:tempThree];
}

- (void)initView
{
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.footView];
    [self.view addSubview:self.bottomButton];
    self.footView.frame = CGRectMake(0, ScreenHeight - 100, ScreenWidth, 50);
}

#pragma mark - UICollectionViewDataSource
- (UICollectionReusableView *)collectionView:(UICollectionView *)
collectionView viewForSupplementaryElementOfKind:(NSString *)
kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *headerId = @"headerId";
    UICollectionReusableView *view;
    if (kind == UICollectionElementKindSectionHeader)
    {
        view = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                  withReuseIdentifier:headerId forIndexPath:indexPath];
        view.backgroundColor = [UIColor lightGrayColor];
    }
    return view;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *tempArray = self.dataSource[section];
    return tempArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)
collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YYCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYCollectionViewCell" forIndexPath:indexPath];
    //位置
    cell.indexPath = indexPath;
    //模型
    NSArray *sourceArray = self.dataSource[indexPath.section];
    YYDrugModel *model = (YYDrugModel *)sourceArray[indexPath.row];
    cell.model = model;
    //点击数量按钮
    __weak typeof(self) weakSelf = self;
    cell.clickCountBlock = ^(NSIndexPath *indexPath,BOOL isSelected,YYCollectionViewCell *cell){
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
        self.currentArray = self.dataSource[indexPath.section];
    }
    return cell;
}

#pragma mark - Event Response
#pragma mark - 点击数量按钮
- (void)clickCountButton:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected withCell:(YYCollectionViewCell *)cell
{
    //选中标志
    self.isAddNewDrug = isSelected;
    //当前数组处理
    self.currentArray = isSelected ? self.dataSource[indexPath.section]: nil;
    //旧模型取消选中
    self.currentCell.countButton.selected = NO;
    self.currentCell.model.isDrugSelected = NO;
    //当前模型状态更新
    self.currentCell = cell;
    self.currentCell.countButton.selected = isSelected;
    self.currentCell.model.isDrugSelected = isSelected;
    //底部按钮选中消除
    self.footView.addButton.selected = NO;
    self.isAddNewSectionDrug = NO;
}

#pragma mark - 点击删除按钮
- (void)clickDeleteButton:(NSIndexPath *)indexPath
{
    NSMutableArray *tempArray = self.dataSource[indexPath.section];
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
    for (int i = 0; i < self.dataSource.count; i ++)
    {
        NSMutableArray *temp = (NSMutableArray *)self.dataSource[i];
        if (temp.count != 0)
        {
            [resultArray addObject:temp];
        }
    }
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:resultArray];
    [self.collectionView reloadData];
}

#pragma mark - 增加分组
- (void)clickAddButton:(UIButton *)sender
{
    NSLog(@"选中增加分组按钮");
    sender.selected = !sender.selected;
    //设置选中标志
    self.isAddNewSectionDrug = sender.selected;
    //设置显示文字
    NSString *contentString = sender.isSelected ? [NSString stringWithFormat:@"%lu",self.dataSource.count + 1] : @"";
    [sender setTitle:contentString forState:UIControlStateNormal];
    //设置cell状态
    self.isAddNewDrug = NO;
    self.currentCell.model.isDrugSelected = NO;
    self.currentCell.countButton.selected = NO;
}

#pragma mark - 增加药品
- (void)addDrug:(UIButton *)sender
{
    NSLog(@"增加药品");
    if (self.isAddNewSectionDrug)
    {//增加新的分组
        NSLog(@"增加新的分组增加新的分组---1");
        YYDrugModel *model = [[YYDrugModel alloc] init];
        model.isDrugSelected = YES;
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithObjects:model, nil];
        [self.dataSource addObject:tempArray];
        //刷新列表
        [self.collectionView reloadData];
        //重置footView
        self.footView.addButton.selected = NO;
        self.isAddNewSectionDrug = NO;
    }
    else if(self.isAddNewDrug)
    {//增加新的药品
        NSLog(@"增加新的药品----2");
        [self.currentArray addObject:[[YYDrugModel alloc] init]];
        [self.collectionView reloadData];
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

#pragma mark  - Getter And Setter
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight - 64 - 100) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor greenColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"YYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"YYCollectionViewCell"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout)
    {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //设置该UICollectionView只支持垂直方向
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //设置各分区上、下、左、右空白的大小
        _flowLayout.sectionInset = UIEdgeInsetsMake(0, WWLeftMargin, 0, WWRightMargin);
        //设置两行单元格之间的行距，即垂直方向的距离
        _flowLayout.minimumLineSpacing = WWLineSpacing;
        //设置两个单元格之间的间距
        _flowLayout.minimumInteritemSpacing = 0;
        //设置UICollectionView中各单元格的大小
        _flowLayout.itemSize = CGSizeMake(WWCellWidth, WWCellHeight);
        //设置头部参数
        _flowLayout.headerReferenceSize = CGSizeMake(ScreenWidth, 5);
    }
    return _flowLayout;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
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

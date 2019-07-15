//
//  collectionViewController.m
//  YYCarousel
//
//  Created by 杨世川 on 18/1/22.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "collectionViewController.h"
#import "CollectionViewCell.h"
#import "XLCardSwitchFlowLayout.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 64

@interface collectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) XLCardSwitchFlowLayout *switchFlowLayout;
@end

@implementation collectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self initView];
    [self loadImageData];
}

#pragma mark - 初始化View
- (void)initView
{
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.collectionView];
}

#pragma mark - 加载图片数据
- (void)loadImageData
{//这里直接使用本地数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"imageData" ofType:@"plist"];
    NSArray *array = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    [self dealDataSourceWithData:array];
    [self.collectionView setContentOffset:CGPointMake(ScreenWidth, 0)];
}

#pragma mark - 处理数据
- (void)dealDataSourceWithData:(NSArray *)array
{
    for (int i = 0; i < array.count; i ++)
    {
        UIImage *image = [UIImage imageNamed:array[i]];
        [self.dataArray addObject:image];
    }
    //我们称为冒牌第一张图片
    UIImage *firstImage = [self.dataArray firstObject];
    //我们称为冒牌最后一张图片
    UIImage *lastImage = [self.dataArray lastObject];

    //冒牌第一张图片添加到最后
    [self.dataArray addObject:firstImage];
    //冒牌最后一张图片添加到最前面
    [self.dataArray insertObject:lastImage atIndex:0];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"imageCell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    cell.image = self.dataArray[indexPath.row];

    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offsetX = self.collectionView.contentOffset.x;
    int dataCount = (int)self.dataArray.count;

    if (offsetX >= (dataCount - 1) * ScreenWidth)
    {//滑动到冒牌的第一张图片
        //鬼使神差移动到真正的第一张图片
        [self.collectionView setContentOffset:CGPointMake(ScreenWidth, 0)];
    }
    if (offsetX <= 0)
    {//滑动到冒牌的最后一张图片
        //鬼使神差移动到真正的最后一张图片
        [self.collectionView setContentOffset:CGPointMake((dataCount - 2) * ScreenWidth, 0)];
    }
}

#pragma mark - Getters And Setters
- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0,BarHeight, ScreenWidth, ScreenHeight - BarHeight) collectionViewLayout:self.switchFlowLayout];
        _collectionView.backgroundColor = [UIColor redColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        //是否分页显示、只会显示整数倍的屏幕宽度
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"imageCell"];

    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout
{
    if (!_flowLayout)
    {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.itemSize = CGSizeMake(ScreenWidth, ScreenHeight - BarHeight);
        _flowLayout.minimumLineSpacing = 0;
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _flowLayout;
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

- (XLCardSwitchFlowLayout *)switchFlowLayout
{
    if (!_switchFlowLayout)
    {
        _switchFlowLayout = [[XLCardSwitchFlowLayout alloc] init];
    }
    return _switchFlowLayout;
}

@end




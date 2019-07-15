//
//  twoImageViewController.m
//  YYCarousel
//
//  Created by 杨世川 on 18/1/22.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "twoImageViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 64

@interface twoImageViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *otherImageView;
@property (nonatomic,strong) UIImageView *currentImageView;

@property (nonatomic,assign) NSInteger leftImageIndex;
@property (nonatomic,assign) NSInteger rightImageIndex;
@property (nonatomic,assign) NSInteger currentImageIndex;

@property (nonatomic,assign) BOOL isOnRight;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation twoImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self initData];
    [self initView];
    [self loadImageData];
}

#pragma mark - 初始化数据
- (void)initData
{
    self.isOnRight = NO;
    self.leftImageIndex = 0;
    self.rightImageIndex = 1;
    self.currentImageIndex = 0;
}

#pragma mark - 初始化View
- (void)initView
{
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.currentImageView];
    [self.scrollView addSubview:self.otherImageView];
}

#pragma mark - 加载数据
- (void)loadImageData
{//这里直接使用本地数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"imageData" ofType:@"plist"];
    NSArray *array = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    for (int i = 0; i < array.count; i ++)
    {
        UIImage *image = [UIImage imageNamed:array[i]];
        [self.dataArray addObject:image];
    }

    [self calculateRightAndLeftIndex];
    [self initImageView];
}

#pragma mark - 初始化imageView
- (void)initImageView
{
    self.otherImageView.image = [self.dataArray lastObject];
    self.currentImageView.image = self.dataArray[self.currentImageIndex];
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth * 3, 0)];
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{//scrollView最终停止滑动，此时的偏移量
    [self calculateCurrentImageIndex];
    [self calculateRightAndLeftIndex];
    [self reloadImage];
    //移动到中间
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeOtherImageViewPosition];
}

#pragma mark - 重新加载图片
- (void)reloadImage
{
    self.currentImageView.image = self.dataArray[self.currentImageIndex];

    if (self.isOnRight)
    {
        self.otherImageView.image = self.dataArray[self.rightImageIndex];
    }
    else
    {
        self.otherImageView.image = self.dataArray[self.leftImageIndex];
    }
}

#pragma mark - 更改otherImageView位置
- (void)changeOtherImageViewPosition
{
    CGFloat offsetX = self.scrollView.contentOffset.x;
    //改变otherImageView的位置
    if (offsetX > ScreenWidth)
    {
        if (!self.isOnRight)
        {
            self.isOnRight = YES;
            self.otherImageView.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight - BarHeight);
        }
        self.otherImageView.image = self.dataArray[self.rightImageIndex];
    }
    else
    {
        if (self.isOnRight)
        {
            self.isOnRight = NO;
            self.otherImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - BarHeight);
        }
        self.otherImageView.image = self.dataArray[self.leftImageIndex];
    }
}

#pragma mark - 计算当前图片索引
- (void)calculateCurrentImageIndex
{
    int dataCount = (int)self.dataArray.count;
    CGPoint offset = self.scrollView.contentOffset;

    if (offset.x > ScreenWidth)
    {//滑动到rightImageView
        self.currentImageIndex = (self.currentImageIndex + 1) % dataCount;
    }
    else
    {//滑动到leftImageView
        self.currentImageIndex = (self.currentImageIndex + dataCount - 1) % dataCount;
    }
}

#pragma mark - 计算左右两边的索引
- (void)calculateRightAndLeftIndex
{
    int dataCount = (int)self.dataArray.count;
    //重新设置左右图片
    self.leftImageIndex = (self.currentImageIndex + dataCount - 1) % dataCount;
    self.rightImageIndex = (self.currentImageIndex + 1) % dataCount;
}

#pragma mark - getters and setters
- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, BarHeight, ScreenWidth, ScreenHeight - BarHeight)];
        _scrollView.delegate = self;
        //是否有弹簧效果、有弹簧效果可以看见scrollView背景颜色
        _scrollView.bounces = NO;
        //是否展示底部滚动条
        _scrollView.showsHorizontalScrollIndicator = NO;
        //是否启用分页，如果启动则每次移动超过屏幕一半，自动移动到下一页
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIImageView *)currentImageView
{
    if (!_currentImageView)
    {
        _currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - BarHeight)];
    }
    return _currentImageView;
}

- (UIImageView *)otherImageView
{
    if (!_otherImageView)
    {
        _otherImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - BarHeight)];
    }
    return _otherImageView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}



@end

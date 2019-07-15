//
//  threeImageViewController.m
//  YYCarousel
//
//  Created by 杨世川 on 18/1/22.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "threeImageViewController.h"
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 64

static  NSInteger const imageViewCount = 3;

@interface threeImageViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView *leftImageView;
@property (nonatomic,strong) UIImageView *rightImageView;
@property (nonatomic,strong) UIImageView *centerImageView;

@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,assign) NSInteger currentImageIndex;

@end

@implementation threeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self initData];
    [self initView];
}

#pragma mark - 初始化数据
- (void)initData
{
    self.currentImageIndex = 0;
}

#pragma mark - 初始化View
- (void)initView
{
    self.view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.scrollView];
    [self addImageView];
    [self loadImageData];
}

#pragma mark - 添加3个imageView
- (void)addImageView
{
    [self.scrollView addSubview:self.leftImageView];
    [self.scrollView addSubview:self.centerImageView];
    [self.scrollView addSubview:self.rightImageView];
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth * imageViewCount, ScreenHeight - BarHeight)];
}

- (void)loadImageData
{//这里直接使用本地数据
    //获取已有完整路径
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"imageData" ofType:@"plist"];
    NSArray *array = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    for (int i = 0; i < array.count; i ++)
    {
        UIImage *image = [UIImage imageNamed:array[i]];
        [self.dataArray addObject:image];
    }
    [self initImageView];
}

- (void)initImageView
{
    UIImage *lastImage = [self.dataArray lastObject];
    UIImage *firstImage = self.dataArray[self.currentImageIndex];
    UIImage *secondImage = self.dataArray[1];

    self.leftImageView.image = lastImage;
    self.centerImageView.image = firstImage;
    self.rightImageView.image = secondImage;
}

#pragma mark - UIScrollViewDelegate
#pragma mark - scrollView最终停止滑动，此时的偏移量
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //重新加载图片
    [self reloadImage];
    //移动到中间
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0) animated:NO];
    //设置左右两个图片缩放
    self.leftImageView.transform=CGAffineTransformMakeScale(0.8, 0.8);
    self.rightImageView.transform=CGAffineTransformMakeScale(0.8, 0.8);
}

#pragma mark 重新加载图片--这里设计到一个循环计算的算法
-(void)reloadImage
{
    int leftImageIndex,rightImageIndex;
    int dataCount = (int)self.dataArray.count;
    CGPoint offset = self.scrollView.contentOffset;

    //计算index
    if (offset.x > ScreenWidth)
    {//滑动到rightImageView
        self.currentImageIndex = (self.currentImageIndex + 1) % dataCount;
    }
    else if(offset.x < ScreenWidth)
    {//滑动到leftImageView
        self.currentImageIndex = (self.currentImageIndex + dataCount - 1) % dataCount;
    }
    //设置中心点图片
    self.centerImageView.image = self.dataArray[self.currentImageIndex];

    //重新设置左右图片
    leftImageIndex = (self.currentImageIndex + dataCount - 1) % dataCount;
    rightImageIndex = (self.currentImageIndex + 1) % dataCount;

    self.leftImageView.image = self.dataArray[leftImageIndex];
    self.rightImageView.image = self.dataArray[rightImageIndex];
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

- (UIImageView *)leftImageView
{
    if (!_leftImageView)
    {
        _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - BarHeight)];
    }
    return _leftImageView;
}

- (UIImageView *)centerImageView
{
    if (!_centerImageView)
    {
        _centerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight - BarHeight)];
    }
    return _centerImageView;
}

- (UIImageView *)rightImageView
{
    if (!_rightImageView)
    {
        _rightImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, ScreenHeight - BarHeight)];
    }
    return _rightImageView;
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



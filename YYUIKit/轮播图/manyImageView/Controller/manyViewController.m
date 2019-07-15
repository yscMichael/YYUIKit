//
//  manyViewController.m
//  YYCarousel
//
//  Created by 杨世川 on 18/1/22.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "manyViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 64

@interface manyViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation manyViewController

- (void)viewDidLoad
{
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
    [self.view addSubview:self.scrollView];
}

#pragma mark - 下载数据
- (void)loadImageData
{//这里直接使用本地数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"imageData" ofType:@"plist"];
    NSMutableArray *array = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    [self dealDataSourceWithData:array];
    [self initImageView];
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

#pragma mark - 在scrollView添加(n + 2)个imageView
- (void)initImageView
{
    for (int i = 0; i < self.dataArray.count; i ++)
    {
        CGFloat imageViewX = i * ScreenWidth;
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(imageViewX, 0, ScreenWidth, ScreenHeight - BarHeight)];
        imageView.image = self.dataArray[i];
        [self.scrollView addSubview:imageView];
    }
    [self.scrollView setContentSize:CGSizeMake(self.dataArray.count * ScreenWidth, ScreenHeight - BarHeight)];
    [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
}

#pragma mark - UIScrollViewDelegate
#pragma mark - scrollView最终停止滑动，此时的偏移量
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= (self.dataArray.count - 1) * ScreenWidth)
    {//滑动到冒牌的第一张图片
        //鬼使神差移动到真正的第一张图片
        [self.scrollView setContentOffset:CGPointMake(ScreenWidth, 0)];
    }

    if (scrollView.contentOffset.x <= 0)
    {//滑动到冒牌的最后一张图片
        //鬼使神差移动到真正的最后一张图片
        [self.scrollView setContentOffset:CGPointMake((self.dataArray.count - 2) * ScreenWidth, 0)];
    }
}

#pragma mark - 滑动scrollView结束时，scrollView偏移量
//此处用不到这个方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{

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

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}


@end



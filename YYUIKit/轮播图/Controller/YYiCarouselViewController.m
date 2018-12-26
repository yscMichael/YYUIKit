//
//  YYiCarouselViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/12/4.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYiCarouselViewController.h"
#import "iCarousel.h"
#import "YYScrollView.h"
#import "UIView+Extension.h"

static int YYIndex = 1;
@interface YYiCarouselViewController ()<iCarouselDataSource, iCarouselDelegate>
@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) UIPageControl *pageControl;
@end

@implementation YYiCarouselViewController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initView];
    [self initData];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(beginScrollView) userInfo:nil repeats:YES];
}

- (void)initView
{
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.carousel];
    [self.carousel addSubview:self.pageControl];
    self.pageControl.frame = CGRectMake(0, self.carousel.height - 20, ScreenWidth, 20);
}

- (void)initData
{
    self.pageControl.numberOfPages = self.items.count;
}

- (void)beginScrollView
{
    NSLog(@"beginScrollView------");
    [self.carousel scrollToItemAtIndex:YYIndex animated:YES];
    YYIndex ++;
    YYIndex = (YYIndex > self.items.count - 1) ? 0 : YYIndex;
}

#pragma mark - iCarouselDataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.items.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(nullable UIView *)view
{
    if (view == nil)
    {
        YYScrollView *targetView = [[[NSBundle mainBundle] loadNibNamed:@"YYScrollView" owner:nil options:nil] lastObject];
        targetView.frame = CGRectMake(0, 0, ScreenWidth - 200, 200);
        NSString *imageName = [NSString stringWithFormat:@"%@.jepg",self.items[index]];
        targetView.imageView.image = [UIImage imageNamed:imageName];
        view = (UIView *)targetView;
    }
    else
    {
        YYScrollView *targetView = (YYScrollView *)view;
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",self.items[index]];
        targetView.imageView.image = [UIImage imageNamed:imageName];
    }
    return view;
}

#pragma mark - iCarouselDelegate
- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    static CGFloat max_sacle = 1.0f;
    static CGFloat min_scale = 0.6f;
    if (offset <= 1 && offset >= -1)
    {
        float tempScale = offset < 0 ? 1+offset : 1-offset;
        float slope = (max_sacle - min_scale) / 1;
        CGFloat scale = min_scale + slope*tempScale;
        transform = CATransform3DScale(transform, scale, scale, 1);
    }
    else
    {
        transform = CATransform3DScale(transform, min_scale, min_scale, 1);
    }
    return CATransform3DTranslate(transform, offset * self.carousel.itemWidth * 1.4, 0.0, 0.0);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //return value * 1.05;//不会循环
    //以下会循环
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return YES;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return value * 1.05;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (self.items)[(NSUInteger)index];
    NSLog(@"点击第几个: %@", item);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"当前是第几个: %@", @(self.carousel.currentItemIndex));
    //设置分页控制器
    self.pageControl.currentPage = self.carousel.currentItemIndex;
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
    NSLog(@"carouselWillBeginDragging");
    //[self.timer invalidate];//永久停止
    [self.timer setFireDate:[NSDate distantFuture]];//暂停
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{
    NSLog(@"------------");
    //[self.timer fire];
    [self.timer setFireDate:[NSDate distantPast]];//开启定时器
}

- (BOOL)navigationShouldPopOnBackButton
{
    [self.carousel removeFromSuperview];//防止轮播图重影
    [self.timer invalidate];
    self.timer = nil;
    return YES;
}

- (void)valueChanged:(UIPageControl *)pageControl
{

}

- (void)dealloc
{
    //不执行
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - Getter And Setter
- (iCarousel *)carousel
{
    if (!_carousel)
    {
        _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth - 100, 200)];
        _carousel.type = iCarouselTypeCustom;
        _carousel.dataSource = self;
        _carousel.delegate = self;
        _carousel.pagingEnabled = YES;
        _carousel.backgroundColor = [UIColor redColor];
    }
    return _carousel;
}

- (NSMutableArray *)items
{
    if (!_items)
    {
        _items = [[NSMutableArray alloc] initWithObjects:
                  @"1",
                  @"2",
                  @"3",
                  @"4",nil];
    }
    return _items;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
        _pageControl.pageIndicatorTintColor = [UIColor greenColor];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.hidesForSinglePage = YES;
        [_pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _pageControl;
}

@end

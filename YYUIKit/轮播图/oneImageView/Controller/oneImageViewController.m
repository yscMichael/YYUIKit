//
//  oneImageViewController.m
//  YYCarousel
//
//  Created by 杨世川 on 18/1/22.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "oneImageViewController.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define BarHeight 64

@interface oneImageViewController ()

@property (nonatomic,strong) UIImageView *currentImageView;

@property (nonatomic,assign) NSInteger leftImageIndex;
@property (nonatomic,assign) NSInteger rightImageIndex;
@property (nonatomic,assign) NSInteger currentImageIndex;

@property (nonatomic, strong) CATransition *transition;

@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation oneImageViewController

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
    self.leftImageIndex = 0;
    self.rightImageIndex = 0;
    self.currentImageIndex = 0;
}

#pragma mark - 初始化View
- (void)initView
{
    self.view.backgroundColor = [UIColor greenColor];
    [self addImageView];
}

#pragma mark - 添加3个imageView
- (void)addImageView
{
    [self.view addSubview:self.currentImageView];
}

#pragma mark - 加载图片数据
- (void)loadImageData
{//这里直接使用本地数据
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"imageData" ofType:@"plist"];
    NSArray *array = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    for (int i = 0; i < array.count; i ++)
    {
        UIImage *image = [UIImage imageNamed:array[i]];
        [self.dataArray addObject:image];
    }
    [self initImageView];
}

#pragma mark - 初始化图片
- (void)initImageView
{
    self.currentImageView.image = self.dataArray[0];
}

#pragma mark - Event Response
- (void)changeDisplayImage:(UISwipeGestureRecognizer *)sender
{
    int dataCount = (int)self.dataArray.count;
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft)
    {
        self.transition.subtype = kCATransitionFromRight;
        self.currentImageIndex = (self.currentImageIndex + 1) % dataCount;
    }
    else if (sender.direction == UISwipeGestureRecognizerDirectionRight)
    {
        self.transition.subtype = kCATransitionFromLeft;
        self.currentImageIndex = (self.currentImageIndex + dataCount - 1) % dataCount;
    }

    [self reloadImage];
}

#pragma mark - Private Methods
#pragma mark - 重新加载图片
- (void)reloadImage
{
    //更改图片
    self.currentImageView.image = self.dataArray[self.currentImageIndex];
    //添加动画
    [self.currentImageView.layer addAnimation:self.transition forKey:@"transition"];
}

#pragma mark - getters and setters
- (UIImageView *)currentImageView
{
    if (!_currentImageView)
    {
        _currentImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, BarHeight, ScreenWidth, ScreenHeight - BarHeight)];
        _currentImageView.userInteractionEnabled = YES;
        //添加轻扫手势
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeDisplayImage:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [_currentImageView addGestureRecognizer:swipeLeft];

        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(changeDisplayImage:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [_currentImageView addGestureRecognizer:swipeRight];
    }
    return _currentImageView;
}

- (CATransition *)transition
{
    if (!_transition) {

        _transition = [CATransition animation];
        _transition.type = kCATransitionPush;
        _transition.duration = 0.3;
    }
    return _transition;
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



//
//  YYBeyondParentViewController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/12/28.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYBeyondParentViewController.h"
#import "HitTestView.h"

@interface YYBeyondParentViewController ()
//超级父类
//@property (nonatomic,strong) UIView *superView;
@property (nonatomic,strong) HitTestView *superView;
//父类View
@property (nonatomic,strong) HitTestView *parentView;
//@property (nonatomic,strong) UIView *parentView;
//子类View
@property (nonatomic,strong) UIView *childView;
//testView
@property (nonatomic,strong) UIView *testView;
@end

@implementation YYBeyondParentViewController
#pragma mark - Life Cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //[self initView];
    [self testScrollView];
}

- (void)testScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 500, ScreenWidth, 50)];
    scrollView.backgroundColor = [UIColor lightGrayColor];
    scrollView.clipsToBounds = NO;
    [self.view addSubview:scrollView];

    UIView *testView = [[UIView alloc] initWithFrame:CGRectMake(-20, -20, 50, 50)];
    testView.backgroundColor = [UIColor redColor];

    [scrollView addSubview:testView];
}

- (void)initView
{
    [self.view addSubview:self.superView];
    [self.superView addSubview:self.parentView];
    self.parentView.center = CGPointMake(0, 0);
    [self.parentView addSubview:self.childView];
    self.childView.center = CGPointMake(0, 0);
    [self.superView addSubview:self.testView];

    //添加手势
    UITapGestureRecognizer *superTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSuperTap:)];
    [self.superView addGestureRecognizer:superTap];

    UITapGestureRecognizer *parentTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickParentTap:)];
    [self.parentView addGestureRecognizer:parentTap];

    UITapGestureRecognizer *childTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickChildTap:)];
    [self.childView addGestureRecognizer:childTap];
}

#pragma mark - Private Methods
#pragma mark - 点击superView
- (void)clickSuperTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击superView");
}

#pragma mark - 点击parentView
- (void)clickParentTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击parentView");
}

#pragma mark - 点击childView
- (void)clickChildTap:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击childView");
}

#pragma mark - Getter And Setter
//- (UIView *)superView
//{
//    if (!_superView)
//    {
//        _superView = [[UIView alloc] initWithFrame:CGRectMake(150, 250, 200, 200)];
//        _superView.layer.borderColor = [UIColor redColor].CGColor;
//        _superView.layer.borderWidth = 1.0;
//    }
//    return _superView;
//}

- (HitTestView *)superView
{
    if (!_superView)
    {
        _superView = [[HitTestView alloc] initWithFrame:CGRectMake(150, 250, 200, 200)];
        _superView.layer.borderColor = [UIColor redColor].CGColor;
        _superView.layer.borderWidth = 1.0;
    }
    return _superView;
}

//- (UIView *)parentView
//{
//    if (!_parentView)
//    {
//        _parentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
//        _parentView.layer.borderColor = [UIColor greenColor].CGColor;
//        _parentView.layer.borderWidth = 1.0;
//    }
//    return _parentView;
//}

- (HitTestView *)parentView
{
    if (!_parentView)
    {
        _parentView = [[HitTestView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
        _parentView.layer.borderColor = [UIColor greenColor].CGColor;
        _parentView.layer.borderWidth = 1.0;
    }
    return _parentView;
}

- (UIView *)childView
{
    if (!_childView)
    {
        _childView = [[UIView alloc] initWithFrame:CGRectMake(25, 50, 100, 100)];
        _childView.backgroundColor = [UIColor lightGrayColor];
    }
    return _childView;
}

- (UIView *)testView
{
    if (!_testView)
    {
        _testView = [[UIView alloc] initWithFrame:CGRectMake(-10, -10, 30, 30)];
        _testView.backgroundColor = [UIColor brownColor];
    }
    return _testView;
}

//结论:
//1、如果不加入- (nullable UIView *)hitTest:(CGPoint)point withEvent:(nullable UIEvent *)event方法
//   不在父类范围内是不能点击的
//2、如果当前View的父类因为超出范围不能响应，当前View肯定不能响应
//3、如果当前View因为超出父类不能响应，需要重写其父类的hitTest方法,如果其父类还有父类，则需要重写其父类的父类的
//   hitTest方法,否则会出问题
//   但是此时,当前View能够正常显示，它的父类范围扩大的太大了，它父类的父类直接点击没有反应
//
//系统View是反应链的顶端嘛？？
//


@end

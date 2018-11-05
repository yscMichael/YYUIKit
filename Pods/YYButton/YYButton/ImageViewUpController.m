//
//  ImageViewUpController.m
//  UIButton
//
//  Created by 杨世川 on 18/1/20.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "ImageViewUpController.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

static CGFloat imageViewX = 0;
static CGFloat imageViewY = 0;
static CGFloat titleLabelX = 0;
static CGFloat titleLabelY = 0;

@interface ImageViewUpController ()

@end

@implementation ImageViewUpController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self imageViewUpWithTitleLabelDown];
}

//图片在上，文字在下
- (void)imageViewUpWithTitleLabelDown
{
    //1、添加按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [btn setTitle:@"title" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 1.0;
    btn.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:btn];

    //2、设置按钮内部控件显示样式
    btn.contentHorizontalAlignment =UIControlContentHorizontalAlignmentCenter;
    btn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    //3、获取控件宽度
    CGFloat imageViewWidth = btn.imageView.frame.size.width;
    CGFloat imageViewHeight = btn.imageView.frame.size.height;

    CGFloat titleWidth = btn.titleLabel.frame.size.width;
    CGFloat titleHeight = btn.titleLabel.frame.size.height;

    //4、设置内边距
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, imageViewWidth, imageViewHeight, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(titleHeight, 0, 0, titleWidth)];

    //5、添加边界线、方便观察
    imageViewX = 62;
    imageViewY = 79.5;
    titleLabelX = 107.5;
    titleLabelY = 89.5;
    [self setBorderLineWith:btn];
}


//添加边界线、方便观察
- (void)setBorderLineWith:(UIButton *)btn
{
    CGFloat x = btn.frame.origin.x;
    CGFloat y = btn.frame.origin.y;

    CGFloat imageViewWidth = btn.imageView.frame.size.width;
    CGFloat imageViewHeight = btn.imageView.frame.size.height;

    CGFloat titleLabelWidth = btn.titleLabel.frame.size.width;
    CGFloat titleLabelHeight = btn.titleLabel.frame.size.height;

    UIView *viewOne = [[UIView alloc]initWithFrame:CGRectMake(x + imageViewX, y + imageViewY, imageViewWidth, imageViewHeight)];
    viewOne.backgroundColor = [UIColor clearColor];
    viewOne.layer.borderWidth = 0.5;
    viewOne.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:viewOne];

    UIView *viewTwo = [[UIView alloc]initWithFrame:CGRectMake(x + titleLabelX, y + titleLabelY, titleLabelWidth, titleLabelHeight)];
    viewTwo.backgroundColor = [UIColor clearColor];
    viewTwo.layer.borderWidth = 0.5;
    viewTwo.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:viewTwo];

    UIView *viewThree = [[UIView alloc]initWithFrame:CGRectMake(x, y + 100, 200, 1)];
    viewThree.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewThree];

    UIView *viewFour = [[UIView alloc]initWithFrame:CGRectMake(x + 100, y, 1, 200)];
    viewFour.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewFour];
    
}


@end

//
//  FinalViewController.m
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "FinalViewController.h"
#import "YYButton.h"

static int top = 25;
static int left = 25;
static int right = 25;
static int bottom = 25;

@interface FinalViewController ()

@property (nonatomic,strong) YYButton *button;
@property (nonatomic,strong) UIView *backView;

@end

@implementation FinalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self initSubViews];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self changeBackViewFrame];
    [self.view addSubview:self.backView];
    [self.view bringSubviewToFront:self.button];
}

- (void)initSubViews
{
    YYButton *buttonOne = [[YYButton alloc]initWithFrame:CGRectMake(0, 64, 120, 50)];
    [buttonOne setTitle:@"admin" forState:UIControlStateNormal];
    [buttonOne setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    [buttonOne addTarget:self action:@selector(clickButtonOne:) forControlEvents:UIControlEventTouchUpInside];

    //这个是需要自己设置的
    [buttonOne setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonOne.imageType = YYButtonTypeImageRight;
    //这些参数会影响按钮宽高
    buttonOne.buttonTitleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    buttonOne.buttonImageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

    buttonOne.layer.borderColor = [UIColor redColor].CGColor;
    buttonOne.layer.borderWidth = 2.0;
    [self.view addSubview:buttonOne];

    YYButton *buttonTwo = [[YYButton alloc]initWithFrame:CGRectMake(200, 200, 120, 50)];
    self.button = buttonTwo;

    //基本设置
    [buttonTwo setTitle:@"admin" forState:UIControlStateNormal];
    [buttonTwo setImage:[UIImage imageNamed:@"touxiang"] forState:UIControlStateNormal];
    [buttonTwo addTarget:self action:@selector(clickButtonTwo:) forControlEvents:UIControlEventTouchUpInside];
    [buttonTwo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonTwo.layer.borderWidth = 2.0;
    buttonTwo.layer.borderColor = [UIColor redColor].CGColor;
    [self.view addSubview:buttonTwo];

    //设置内部参数
    buttonTwo.buttonTitleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    buttonTwo.buttonImageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //设置图片右文字左
    buttonTwo.imageType = YYButtonTypeImageRight;
    //设置按钮伸展方向
    buttonTwo.positionType = YYPositionTypeStretchLeft;
    //扩大响应区域
    buttonTwo.hitTestEdgeInsets = UIEdgeInsetsMake(-top, -left, -bottom, -right);
}

- (void)clickButtonOne:(UIButton *)sender
{
    NSString *text = sender.titleLabel.text;
    if (text.length <= 20)
    {
        text = [text stringByAppendingString:@"B"];
    }
    [sender setTitle:text forState:UIControlStateNormal];
}

- (void)clickButtonTwo:(UIButton *)sender
{
    NSString *text = sender.titleLabel.text;
    if (text.length <= 20)
    {
        text = [text stringByAppendingString:@"B"];
    }
    [self changeBackViewFrame];
    [sender setTitle:text forState:UIControlStateNormal];
}

- (void)changeBackViewFrame
{
    CGRect buttonFrame = self.button.frame;
    CGRect backViewFrame = self.backView.frame;

    backViewFrame.origin.x = buttonFrame.origin.x - left;
    backViewFrame.origin.y = buttonFrame.origin.y - top;
    backViewFrame.size.height = buttonFrame.size.height + top + bottom;
    backViewFrame.size.width = buttonFrame.size.width + left + right;
    self.backView.frame = backViewFrame;
}

#pragma mark - Getters And Setters
- (UIView *)backView
{
    if (!_backView)
    {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        _backView.backgroundColor = [UIColor clearColor];
        _backView.layer.borderColor = [UIColor blueColor].CGColor;
        _backView.layer.borderWidth = 2.0;
    }
    return _backView;
}



@end



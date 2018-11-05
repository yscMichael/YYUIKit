//
//  YYLayoutButton.m
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "YYLayoutButton.h"

@interface YYLayoutButton ()

@property (nonatomic,assign) CGFloat titleWidth;
@property (nonatomic,assign) CGFloat titleHeight;
@property (nonatomic,assign) CGFloat titleLabelX;
@property (nonatomic,assign) CGFloat titleLabelY;

@property (nonatomic,assign) CGFloat imageViewX;
@property (nonatomic,assign) CGFloat imageViewY;

@property (nonatomic,assign) CGFloat buttonW;
@property (nonatomic,assign) CGFloat buttonH;

@end

@implementation YYLayoutButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initPara];
    }
    return self;
}

#pragma mark - 初始化参数
- (void)initPara
{
    self.buttonImageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.buttonTitleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.imageViewWidth = 0;
    self.imageViewHeight = 0;
    self.titleFont = 15.0;
    self.buttonW = 0;
    self.buttonH = 0;

    self.imageType = YYLayoutButtonTypeImageRight;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.backgroundColor = [UIColor redColor];
    self.titleLabel.backgroundColor = [UIColor greenColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    switch (self.imageType) {
        case YYLayoutButtonTypeImageUp:
             [self imageUp];
             break;
        case YYLayoutButtonTypeImageDown:
             [self imageDown];
             break;
        case YYLayoutButtonTypeImageLeft:
             [self imageLeft];
             break;
        case YYLayoutButtonTypeImageRight:
             [self imageRight];
             break;
        default:
            [self imageRight];
            break;
    }
}

#pragma mark - 图片上文字下
- (void)imageUp
{
    [self dealImageViewWidthAndHeight];
    [self dealTitleLabelWidthAndHeight];
    [self dealButtonWidth];
    [self dealImageUpFrame];
}

#pragma mark - 图片下文字上
- (void)imageDown
{
    [self dealImageViewWidthAndHeight];
    [self dealTitleLabelWidthAndHeight];
    [self dealButtonWidth];
    [self dealImageDownFrame];
}

#pragma mark - 图片左文字右
- (void)imageLeft
{
    [self dealImageViewWidthAndHeight];
    [self dealTitleLabelWidthAndHeight];
    [self dealButtonHeight];
    [self dealImageLeftFrame];
}

#pragma mark - 图片右文字左
- (void)imageRight
{
    [self dealImageViewWidthAndHeight];
    [self dealTitleLabelWidthAndHeight];
    [self dealButtonHeight];
    [self dealImageRightFrame];
}

#pragma mark - 设置按钮的宽度、高度一定
- (void)dealButtonWidth
{
    CGFloat imageViewW = self.buttonImageEdgeInsets.left + self.buttonImageEdgeInsets.right + self.imageViewWidth;
    CGFloat imageViewH = self.buttonImageEdgeInsets.top + self.buttonImageEdgeInsets.bottom + self.imageViewHeight;
    CGFloat titleLabelW = self.buttonTitleEdgeInsets.left + self.buttonTitleEdgeInsets.right + self.titleWidth;
    CGFloat titleLabelH = self.buttonTitleEdgeInsets.top + self.buttonTitleEdgeInsets.bottom + self.titleHeight;

    self.buttonW = (imageViewW > titleLabelW) ? imageViewW : titleLabelW;
    self.buttonH = imageViewH + titleLabelH;

    CGRect frame = self.frame;
    frame.size.width = self.buttonW;
    frame.size.height = self.buttonH;
    self.frame = frame;
}

#pragma mark - 设置按钮的高度、宽度一定
- (void)dealButtonHeight
{
    CGFloat imageViewW = self.buttonImageEdgeInsets.left + self.buttonImageEdgeInsets.right + self.imageViewWidth;
    CGFloat imageViewH = self.buttonImageEdgeInsets.top + self.buttonImageEdgeInsets.bottom + self.imageViewHeight;
    CGFloat titleLabelW = self.buttonTitleEdgeInsets.left + self.buttonTitleEdgeInsets.right + self.titleWidth;
    CGFloat titleLabelH = self.buttonTitleEdgeInsets.top + self.buttonTitleEdgeInsets.bottom + self.titleHeight;

    self.buttonW = imageViewW + titleLabelW;
    self.buttonH = (imageViewH > titleLabelH) ? imageViewH : titleLabelH;

    CGRect frame = self.frame;
    frame.size.width = self.buttonW;
    frame.size.height = self.buttonH;
    self.frame = frame;
}

#pragma mark - 设置imageUp的frame
- (void)dealImageUpFrame
{
    //1、imageView
    self.imageViewX = (self.buttonW/2.0 - self.imageViewWidth/2.0);
    self.imageViewY = self.buttonImageEdgeInsets.top;
    self.imageView.frame = CGRectMake(self.imageViewX, self.imageViewY, self.imageViewWidth, self.imageViewHeight);

    //2、titleLabel
    self.titleLabelX = (self.buttonW/2.0 - self.titleWidth/2.0);
    self.titleLabelY = CGRectGetMaxY(self.imageView.frame) + self.buttonImageEdgeInsets.bottom + self.buttonTitleEdgeInsets.top;
    self.titleLabel.frame = CGRectMake(self.titleLabelX, self.titleLabelY, self.titleWidth, self.titleHeight);
}

#pragma mark - 设置ImageDown的frame
- (void)dealImageDownFrame
{
    //1、titleLabel
    self.titleLabelX = (self.buttonW/2.0 - self.titleWidth/2.0);
    self.titleLabelY = self.buttonTitleEdgeInsets.top;
    self.titleLabel.frame = CGRectMake(self.titleLabelX, self.titleLabelY, self.titleWidth, self.titleHeight);

    //2、imageView
    self.imageViewX = (self.buttonW/2.0 - self.imageViewWidth/2.0);
    self.imageViewY = CGRectGetMaxY(self.titleLabel.frame) + self.buttonTitleEdgeInsets.bottom + self.buttonImageEdgeInsets.top;
    self.imageView.frame = CGRectMake(self.imageViewX, self.imageViewY, self.imageViewWidth, self.imageViewHeight);
}

#pragma mark - 设置imageLeft的frame
- (void)dealImageLeftFrame
{
    //1、imageView
    self.imageViewX = self.buttonImageEdgeInsets.left;
    self.imageViewY = (self.buttonH/2.0 - self.imageViewHeight/2.0);
    self.imageView.frame = CGRectMake(self.imageViewX, self.imageViewY, self.imageViewWidth, self.imageViewHeight);

    //2、titleLabel
    self.titleLabelX = CGRectGetMaxX(self.imageView.frame) + self.buttonImageEdgeInsets.right + self.buttonTitleEdgeInsets.left;
    self.titleLabelY = (self.buttonH/2.0 - self.titleHeight/2.0);
    self.titleLabel.frame = CGRectMake(self.titleLabelX, self.titleLabelY, self.titleWidth, self.titleHeight);
}

#pragma mark - 设置imageRight的frame
- (void)dealImageRightFrame
{
    //1、titleLabel
    self.titleLabelX = self.buttonTitleEdgeInsets.left;
    self.titleLabelY = (self.buttonH/2.0 - self.titleHeight/2.0);
    self.titleLabel.frame = CGRectMake(self.titleLabelX, self.titleLabelY, self.titleWidth, self.titleHeight);

    //2、imageView
    self.imageViewX = CGRectGetMaxX(self.titleLabel.frame) + self.buttonTitleEdgeInsets.right + self.buttonImageEdgeInsets.left;
    self.imageViewY = (self.buttonH/2.0 - self.imageViewHeight/2.0);
    self.imageView.frame = CGRectMake(self.imageViewX, self.imageViewY, self.imageViewWidth, self.imageViewHeight);
}

#pragma mark - 设置imageView的宽高
- (void)dealImageViewWidthAndHeight
{
    //1、设置图片的Frame、此时只考虑buttonImageEdgeInsets的top和bottom、默认垂直居中
    UIImage *image = self.imageView.image;
    //2、是否需要设置imageViewWidth、imageViewHeight
    CGFloat imageViewWidth = (self.imageViewWidth == 0) ? image.size.width : self.imageViewWidth;
    CGFloat imageViewHeight = (self.imageViewHeight == 0) ? image.size.height : self.imageViewHeight;

    self.imageViewWidth = imageViewWidth;
    self.imageViewHeight = imageViewHeight;
}

#pragma mark - 设置titleLabel的宽高
- (void)dealTitleLabelWidthAndHeight
{

    CGSize titleSize = [self calculateTitleSizeWithText:self.titleLabel.text];
    self.titleWidth = titleSize.width;
    self.titleHeight = titleSize.height;
}

#pragma mark - 计算文本宽高
- (CGSize)calculateTitleSizeWithText:(NSString *)text
{
    if (!self.fontName)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:self.titleFont];
    }
    else
    {
        self.titleLabel.font = [UIFont fontWithName:self.fontName size:self.titleFont];
    }
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font,NSFontAttributeName,nil]];

    return size;
}

#pragma mark - Getters And Setters
- (void)setButtonImageEdgeInsets:(UIEdgeInsets)buttonImageEdgeInsets
{
    _buttonImageEdgeInsets = buttonImageEdgeInsets;
}

- (void)setButtonTitleEdgeInsets:(UIEdgeInsets)buttonTitleEdgeInsets
{
    _buttonTitleEdgeInsets = buttonTitleEdgeInsets;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];

    if (self.positionType == YYLayoutPositionTypeLeftUnchanged)
    {
        CGSize titleSize = [self calculateTitleSizeWithText:title];
        CGRect frame = self.frame;
        frame.origin.x -= (titleSize.width - self.titleWidth);
        self.frame = frame;
    }
}


@end





//
//  YYButton.m
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "YYButton.h"

@interface YYButton ()

//button
@property (nonatomic,assign) CGFloat buttonW;
@property (nonatomic,assign) CGFloat buttonH;
//imageView
@property (nonatomic,assign) CGFloat imageViewX;
@property (nonatomic,assign) CGFloat imageViewY;
//titleLabel
@property (nonatomic,assign) CGFloat titleWidth;
@property (nonatomic,assign) CGFloat titleHeight;
@property (nonatomic,assign) CGFloat titleLabelX;
@property (nonatomic,assign) CGFloat titleLabelY;
//titleLabel内容
@property (nonatomic ,copy) NSString *titleString;

@end

@implementation YYButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initParaWithFrame:frame];
    }
    return self;
}

#pragma mark - 初始化参数
- (void)initParaWithFrame:(CGRect)frame
{
    self.buttonW = 0;
    self.buttonH = 0;
    self.buttonWidth = frame.size.width;
    self.buttonHeight = frame.size.height;

    self.imageViewWidth = 0;
    self.imageViewHeight = 0;
    self.buttonImageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.buttonTitleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    self.imageType = YYButtonTypeImageRight;
    self.positionType = YYPositionTypeStretchNormal;
    self.hitTestEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

#pragma mark - 扩大点击区域(超出父类范围、不可点击、除非重写父类的hitTest方法)
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden)
    {
        return [super pointInside:point withEvent:event];
    }

    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);

    return CGRectContainsPoint(hitFrame, point);
}

#pragma mark - 重新布局子控件
- (void)layoutSubviews
{
    [super layoutSubviews];

    switch (self.imageType) {
        case YYButtonTypeImageUp:
            [self imageUp];
            break;
        case YYButtonTypeImageDown:
//            [self imageDown];
            break;
        case YYButtonTypeImageLeft:
            [self imageLeft];
            break;
        case YYButtonTypeImageRight:
//            [self imageRight];
            break;
        default:
//            [self imageRight];
            break;
    }
}

#pragma mark - 图片上文字下
- (void)imageUp
{
    //判断按钮的高度是否固定
    if ((self.buttonWidth != 0) && (self.buttonHeight != 0))
    {//按钮高度已经固定、不需要自适应
     //这里只需要知道图标top、文字bottom、图标size、文字size
        [self dealImageUpFrameWithButtonSizeFixed];
    }
    else
    {//按钮高度不固定、需要自适应
        [self dealButtonWidth];
        [self dealImageUpFrame];
    }
}

#pragma mark - 图片下文字上
- (void)imageDown
{
    [self dealButtonWidth];
    [self dealImageDownFrame];
}

#pragma mark - 图片左文字右
- (void)imageLeft
{
    //判断按钮的frame是否固定
    if ((self.buttonWidth != 0) && (self.buttonHeight != 0))
    {//按钮高度已经固定、不需要自适应
        //这里只需要知道图标left、right、图标size、文字size
        [self dealImageLeftFrameWithButtonSizeFixed];
    }
    else
    {//按钮高度不固定、需要自适应
        [self dealButtonHeight];
        [self dealImageLeftFrame];
    }
}

#pragma mark - 图片右文字左
- (void)imageRight
{
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

#pragma mark - 设置imageUp的frame(按钮size自适应)
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

#pragma mark - 设置imageUp的frame(按钮size固定)
- (void)dealImageUpFrameWithButtonSizeFixed
{
    //1、imageView
    self.imageViewX = (self.buttonWidth/2.0 - self.imageViewWidth/2.0);
    self.imageViewY = self.buttonImageEdgeInsets.top;
    self.imageView.frame = CGRectMake(self.imageViewX, self.imageViewY, self.imageViewWidth, self.imageViewHeight);

    //2、titleLabel
    self.titleLabelX = (self.buttonWidth/2.0 - self.titleWidth/2.0);
    self.titleLabelY = self.buttonHeight - self.buttonTitleEdgeInsets.bottom - self.titleHeight;
    self.titleLabel.frame = CGRectMake(self.titleLabelX, self.titleLabelY, self.titleWidth, self.titleHeight);
}

#pragma mark - 设置imageLeft的frame(按钮size固定)
//用Masonry约束会比系统的提早执行、会出问题;因此这里直接手动计算
- (void)dealImageLeftFrameWithButtonSizeFixed
{
    //1、imageView
    self.imageViewX = self.buttonImageEdgeInsets.left;
    self.imageViewY = (self.buttonHeight - self.imageViewHeight) / 2.0;
    self.imageView.frame = CGRectMake(self.imageViewX, self.imageViewY, self.imageViewWidth, self.imageViewHeight);

    //2、titleLabel
    self.titleLabelX = (self.buttonImageEdgeInsets.left + self.imageViewWidth + self.buttonImageEdgeInsets.right + self.buttonTitleEdgeInsets.left);
    self.titleLabelY = (self.buttonHeight - self.titleHeight) / 2.0;
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

#pragma mark - 计算文本宽高
- (CGSize)calculateTitleSizeWithText:(NSString *)text
{
    if (!self.textFont)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
    else
    {
        self.titleLabel.font = self.textFont;
    }
    CGSize size = [text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:self.titleLabel.font,NSFontAttributeName,nil]];

    return size;
}

#pragma mark - Getters And Setters
#pragma mark - 设置Label文字大小
- (void)setTextFont:(UIFont *)textFont
{//重新计算文字宽高
    _textFont = textFont;
    CGSize titleSize = [self calculateTitleSizeWithText:self.titleString];
    self.titleWidth = titleSize.width;
    self.titleHeight = titleSize.height;
    [self.titleLabel setFont:textFont];
}

#pragma mark - 设置文字颜色
- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.titleLabel.textColor = textColor;
    [self setTitleColor:textColor forState:UIControlStateNormal];
}

#pragma mark - 设置图片的内切边距
- (void)setButtonImageEdgeInsets:(UIEdgeInsets)buttonImageEdgeInsets
{
    _buttonImageEdgeInsets = buttonImageEdgeInsets;
}

#pragma mark - 设置文字的内切边距
- (void)setButtonTitleEdgeInsets:(UIEdgeInsets)buttonTitleEdgeInsets
{
    _buttonTitleEdgeInsets = buttonTitleEdgeInsets;
}

#pragma mark - 文字动态变化时,设置Button变化方向
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    self.titleString = title;
    //计算title宽高
    CGSize titleSize = [self calculateTitleSizeWithText:title];
    self.titleWidth = titleSize.width;
    self.titleHeight = titleSize.height;

    if (self.positionType == YYPositionTypeStretchLeft)
    {
        CGSize titleSize = [self calculateTitleSizeWithText:title];
        CGRect frame = self.frame;
        frame.origin.x -= (titleSize.width - self.titleWidth);
        self.frame = frame;
    }
}

#pragma mark - 重写image方法
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    //1、设置图片的Frame、此时只考虑buttonImageEdgeInsets的top和bottom、默认垂直居中
    //2、是否需要设置imageViewWidth、imageViewHeight
    CGFloat imageViewWidth = (self.imageViewWidth == 0) ? image.size.width : self.imageViewWidth;
    CGFloat imageViewHeight = (self.imageViewHeight == 0) ? image.size.height : self.imageViewHeight;

    self.imageViewWidth = imageViewWidth;
    self.imageViewHeight = imageViewHeight;
}


@end

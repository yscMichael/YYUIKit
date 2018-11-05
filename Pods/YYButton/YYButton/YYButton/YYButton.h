//
//  YYButton.h
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYButtonType) {
    //图片上文字下
    YYButtonTypeImageUp = 0,
    //图片下文字上
    YYButtonTypeImageDown,
    //图片左文字右
    YYButtonTypeImageLeft,
    //图片右文字左
    YYButtonTypeImageRight
};

//动态改变按钮内部文字
typedef NS_ENUM(NSInteger, YYPositionType) {
    //左侧位置固定不变，向右伸展
    YYPositionTypeStretchNormal = 0,
    //右侧固定不变，向左伸展
    YYPositionTypeStretchLeft
};

@interface YYButton : UIButton

//设置文字字体
@property (nonatomic,strong) UIFont *textFont;
//设置文字颜色
@property (nonatomic,strong) UIColor *textColor;
//imageView高度、默认是图片宽度
@property (nonatomic,assign) CGFloat imageViewWidth;
//imageView高度、默认是图片高度
@property (nonatomic,assign) CGFloat imageViewHeight;
//按钮宽度、不设置默认根据图片宽高和UIEdgeInsets计算
@property (nonatomic,assign) CGFloat buttonWidth;
//按钮高度、不设置默认根据图片宽高和UIEdgeInsets计算
@property (nonatomic,assign) CGFloat buttonHeight;
//imageView边距、默认为(0,0,0,0)
@property (nonatomic,assign) UIEdgeInsets buttonImageEdgeInsets;
//titleLabel边距、默认为(0,0,0,0)
@property (nonatomic,assign) UIEdgeInsets buttonTitleEdgeInsets;

//button类型
@property (nonatomic,assign) YYButtonType imageType;
//button动态伸展方向
@property (nonatomic,assign) YYPositionType positionType;
//扩大button响应区域
@property (nonatomic,assign) UIEdgeInsets hitTestEdgeInsets;

@end

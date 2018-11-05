//
//  YYLayoutButton.h
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YYLayoutButtonType) {
    //图片上文字下
    YYLayoutButtonTypeImageUp = 0,
    //图片下文字上
    YYLayoutButtonTypeImageDown,
    //图片左文字右
    YYLayoutButtonTypeImageLeft,
    //图片右文字左
    YYLayoutButtonTypeImageRight
};

typedef NS_ENUM(NSInteger, YYLayoutPositionType) {
    //左侧位置固定不变，向右伸展
    YYLayoutPositionTypeOrigin = 0,
    //右侧固定不变，向左伸展
    YYLayoutPositionTypeLeftUnchanged
};

@interface YYLayoutButton : UIButton

//设置图片边距、默认为(0,0,0,0)
@property (nonatomic,assign) UIEdgeInsets buttonImageEdgeInsets;
//设置文字边距、默认为(0,0,0,0)
@property (nonatomic,assign) UIEdgeInsets buttonTitleEdgeInsets;
//图片高度、默认是图片高度
@property (nonatomic,assign) CGFloat imageViewHeight;
//图片高度、默认是图片宽度
@property (nonatomic,assign) CGFloat imageViewWidth;
//默认是15.0
@property (nonatomic,assign) CGFloat titleFont;
//默认字体是
@property (nonatomic,strong) NSString *fontName;
//按钮类型
@property (nonatomic,assign) YYLayoutButtonType imageType;
//position类型
@property (nonatomic,assign) YYLayoutPositionType positionType;

@end

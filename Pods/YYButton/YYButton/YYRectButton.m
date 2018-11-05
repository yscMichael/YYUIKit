//
//  YYRectButton.m
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "YYRectButton.h"

@implementation YYRectButton

//返回标题的区域
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleWidth = contentRect.size.width - contentRect.size.height;
    return CGRectMake(0, 0, titleWidth, contentRect.size.height);
}

//返回图片等区域
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageHeight = contentRect.size.height;
    CGFloat imageWidth = imageHeight;

    return CGRectMake(contentRect.size.width - imageWidth, 0, imageWidth, imageHeight);
}


@end

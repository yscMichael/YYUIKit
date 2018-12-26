//
//  Tool.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/12/25.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "Tool.h"
#import <objc/runtime.h>

@interface Tool ()

@end

@implementation Tool
#pragma mark - 在目标target上添加关联对象，属性名propertyname(也能用来添加block)，值value
+ (void)addAssociatedWithtarget:(id)target withPropertyName:(NSString *)propertyName withValue:(id)value
{
    id property = objc_getAssociatedObject(target, &propertyName);
    if(property == nil)
    {
        property = value;
        objc_setAssociatedObject(target, &propertyName, property, OBJC_ASSOCIATION_RETAIN);
    }
}

#pragma mark - 获取目标target的指定关联对象值
+ (id)getAssociatedValueWithTarget:(id)target withPropertyName:(NSString *)propertyName
{
    id property = objc_getAssociatedObject(target, &propertyName);
    return property;
}
@end

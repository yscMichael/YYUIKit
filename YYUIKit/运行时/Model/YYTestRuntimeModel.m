//
//  YYTestRuntimeModel.m
//  YYUIKit
//
//  Created by 杨世川 on 2019/1/4.
//  Copyright © 2019年 winwayworld. All rights reserved.
//

#import "YYTestRuntimeModel.h"
#import "YYTestPerson.h"
#import <objc/runtime.h>

@implementation YYTestRuntimeModel
#pragma mark - 拷贝运行时
- (id)mutableCopyWithZone:(NSZone *)zone
{
    id objcopy = [[[self class]allocWithZone:zone] init];
    //1.获取属性列表
    unsigned int count = 0;
    objc_property_t* propertylist = class_copyPropertyList([self class], &count);

    for (int i = 0; i < count ; i++)
    {
        objc_property_t property = propertylist[i];
        //2.获取属性名
        const char * propertyName = property_getName(property);
        NSString * key = [NSString stringWithUTF8String:propertyName];
        //3.获取属性值
        id value = [self valueForKey:key];
        //4.判断属性值对象是否遵守NSMutableCopying协议
        if ([value respondsToSelector:@selector(mutableCopyWithZone:)])
        {
            //5.设置对象属性值
            [objcopy setValue:[value mutableCopy] forKey:key];
        }
        else
        {
            [objcopy setValue:value forKey:key];
        }
    }
    //*****切记需要手动释放
    free(propertylist);
    return objcopy;
}

#pragma mark - 归档运行时



#pragma mark - Getter And Setter
- (YYTestPerson *)testPerson
{
    if (!_testPerson)
    {
        _testPerson = [[YYTestPerson alloc] init];
    }
    return _testPerson;
}

- (NSMutableArray *)testModelArray
{
    if (!_testModelArray)
    {
        _testModelArray = [[NSMutableArray alloc] init];
    }
    return _testModelArray;
}
@end

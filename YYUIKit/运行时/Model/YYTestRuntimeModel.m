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
#pragma mark - 归档运行时
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        //1.复制属性列表
        unsigned int outCount = 0;
        Ivar *varList = class_copyIvarList(self.class, &outCount);
        //2.for循环对每个成员变量进行操作
        for (int i = 0; i < outCount; i++)
        {
            //3.获取成员变量名,转换成OC的名字
            Ivar var = varList[i];
            const char *name = ivar_getName(var);
            NSString *pName = [NSString stringWithUTF8String:name];
            //4.通过属性名解档出对应的值
            id value = [aDecoder decodeObjectForKey:pName];
            //5.通过KVC方式,把值存储到对应的属性中
            [self setValue:value forKey:pName];
        }
        free(varList);
    }
    return self;
}

#pragma mark - 解档运行时
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    //Ivar: 成员变量
    //class_copyIvarList: 拷贝参数一的类的所有属性列表出来,第二参数中会被存入列表中的元素数量
    unsigned int outCount = 0;
    Ivar *varList = class_copyIvarList(self.class, &outCount);
    for (int i = 0; i < outCount; i++)
    {
        //从列表中获取每一个成员变量
        Ivar var = varList[i];
        //获取成员变量的名字
        const char *name = ivar_getName(var);
        //C字符串 -> OC字符串
        NSString *propertyName = [NSString stringWithUTF8String:name];
        NSLog(@"%@", propertyName);
        //KVC
        id value = [self valueForKey:propertyName];
        //归档
        [aCoder encodeObject:value forKey:propertyName];
    }
    //C语言在用完之后手动进行释放
    free(varList);
}

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

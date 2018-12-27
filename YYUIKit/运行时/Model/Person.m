//
//  Person.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/12/25.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "Person.h"
#import "Son.h"

@implementation Person
- (id)copyWithZone:(NSZone *)zone
{
    Person *person = [[[self class] allocWithZone:zone] init];
    person.name = [self.name copy];
    person.age = self.age;
    //NSLog(@"copyWithZone");
    //NSLog(@"self.name内存地址 = %p",self.name);
    //NSLog(@"person.name内存地址 = %p",person.name);
    //NSLog(@"person内存地址 = %p",person);
    return person;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    Person *person = [[[self class] allocWithZone:zone] init];
    person.name = [self.name mutableCopy];
    person.age = self.age;
    //NSLog(@"mutableCopyWithZone");
    //NSLog(@"self.name内存地址 = %p",self.name);
    //NSLog(@"person.name内存地址 = %p",person.name);
    //NSLog(@"person内存地址 = %p",person);
    return person;
}

#pragma mark - Getter And Setter
#pragma mark - 需要自己初始化,以分配内存空间
- (Son *)son
{
    if (!_son)
    {
        _son = [[Son alloc] init];
    }
    return _son;
}

@end

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

- (id)initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.name = [coder decodeObjectForKey:@"name"];
        self.age = (int)[coder decodeIntegerForKey:@"age"];
        self.son = [coder decodeObjectForKey:@"son"];
        self.modelArray = [coder decodeObjectForKey:@"modelArray"];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeInteger:self.age forKey:@"age"];
    [coder encodeObject:self.son forKey:@"son"];
    [coder encodeObject:self.modelArray forKey:@"modelArray"];
}


- (id)copyWithZone:(NSZone *)zone
{
    Person *person = [[[self class] allocWithZone:zone] init];
    person.name = [self.name copy];
    person.age = self.age;
    person.son = [self.son copy];
    person.modelArray = [self.modelArray copy];
    NSLog(@"copyWithZone");
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
    person.son = [self.son mutableCopy];
    person.modelArray = [self.modelArray mutableCopy];
    NSLog(@"mutableCopyWithZone");
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

- (NSMutableArray *)modelArray
{
    if (!_modelArray)
    {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}


@end

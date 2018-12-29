//
//  Son.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/12/26.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "Son.h"

@implementation Son

- (id)initWithCoder: (NSCoder *)coder
{
    if (self = [super init])
    {
        self.name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void) encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
}

- (id)copyWithZone:(NSZone *)zone
{
    Son *son = [[[self class] allocWithZone:zone] init];
    son.name = [self.name copy];
    return son;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    Son *son = [[[self class] allocWithZone:zone] init];
    son.name = [self.name mutableCopy];
    return son;
}

- (NSArray *)testArray
{
    if (!_testArray)
    {
        _testArray = [[NSArray alloc] init];
    }
    return _testArray;
}

- (NSMutableArray *)testMutableArray
{
    if (!_testMutableArray)
    {
        _testMutableArray = [[NSMutableArray alloc] init];
    }
    return _testMutableArray;
}

@end

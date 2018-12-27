//
//  Person.h
//  YYUIKit
//
//  Created by 杨世川 on 2018/12/25.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Son;

@interface Person : NSObject<NSCopying,NSMutableCopying>
//姓名
@property (nonatomic ,copy) NSString *name;
//年龄
@property (nonatomic,assign) int age;
//模型(要初始化)
@property (nonatomic,strong) Son *son;
//数组(要初始化)
@property (nonatomic,strong) NSMutableArray *modelArray;
@end

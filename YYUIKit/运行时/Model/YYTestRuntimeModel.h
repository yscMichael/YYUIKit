//
//  YYTestRuntimeModel.h
//  YYUIKit
//
//  Created by 杨世川 on 2019/1/4.
//  Copyright © 2019年 winwayworld. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YYTestPerson;

@interface YYTestRuntimeModel : NSObject<NSMutableCopying>
//姓名
@property (nonatomic ,copy) NSString *name;
//模型
@property (nonatomic,strong) YYTestPerson *testPerson;
//数组模型
@property (nonatomic,strong) NSMutableArray *testModelArray;
@end

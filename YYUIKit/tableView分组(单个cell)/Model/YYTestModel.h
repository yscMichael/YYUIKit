//
//  YYTestModel.h
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/15.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYTestModel : NSObject
//组号
@property (nonatomic,assign) int groupNo;
//名字
@property (nonatomic ,copy) NSString *key_name;
//数组
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

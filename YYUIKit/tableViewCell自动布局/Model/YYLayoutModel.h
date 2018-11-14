//
//  YYLayoutModel.h
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/14.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYLayoutModel : NSObject
//名字
@property (nonatomic ,copy) NSString *key_name;
//厂商
@property (nonatomic ,copy) NSString *factoryString;
//数量
@property (nonatomic ,copy) NSString *countString;
//单位
@property (nonatomic ,copy) NSString *unitString;
//价钱
@property (nonatomic ,copy) NSString *priceString;
@end

//
//  YYDrugModel.h
//  TestTableViewProject
//
//  Created by 杨世川 on 2018/9/7.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDrugModel : NSObject

//药品名称
@property (nonatomic ,copy) NSArray *name;
//药品价格
@property (nonatomic,assign) float price;
//是否选中
@property (nonatomic,assign) BOOL isDrugSelected;

@end

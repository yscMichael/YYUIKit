//
//  YYTestModel.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/15.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTestModel.h"

@implementation YYTestModel
- (NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
@end

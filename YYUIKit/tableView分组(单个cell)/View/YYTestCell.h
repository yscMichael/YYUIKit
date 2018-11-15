//
//  YYTestCell.h
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/15.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYTestModel.h"

@interface YYTestCell : UITableViewCell
//标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//头部label
@property (weak, nonatomic) IBOutlet UILabel *headlabel;
//模型
@property (nonatomic,strong) YYTestModel *testModel;
@end

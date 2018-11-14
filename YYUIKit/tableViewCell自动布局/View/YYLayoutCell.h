//
//  YYLayoutCell.h
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/14.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYLayoutModel.h"

@interface YYLayoutCell : UITableViewCell
//药品名字
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
//厂商
@property (weak, nonatomic) IBOutlet UILabel *factoryLabel;
//数量
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
//单位
@property (weak, nonatomic) IBOutlet UILabel *unitLabel;
//价钱
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
//删除按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
//模型
@property (nonatomic,strong) YYLayoutModel *model;
@end

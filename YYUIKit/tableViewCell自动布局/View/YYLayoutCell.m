//
//  YYLayoutCell.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/14.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYLayoutCell.h"

@implementation YYLayoutCell
- (void)awakeFromNib
{
    [super awakeFromNib];

}

#pragma mark - 点击删除按钮
- (IBAction)clickDeleteButton:(UIButton *)sender
{
    
}

#pragma mark - Getter And Setter
- (void)setModel:(YYLayoutModel *)model
{
    _model = model;
    //药品名字
    self.titleLabel.text = model.key_name;
    //厂商
    self.factoryLabel.text = model.factoryString;
    //数量
    self.countLabel.text = model.countString;
    //单位
    self.unitLabel.text = model.unitString;
    //价钱
    self.priceLabel.text = model.priceString;
}

@end

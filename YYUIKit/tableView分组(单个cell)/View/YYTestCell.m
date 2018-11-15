//
//  YYTestCell.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/15.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTestCell.h"

@interface YYTestCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headHeight;
@end

@implementation YYTestCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.headHeight.constant = 25.0;
    
}

- (void)setTestModel:(YYTestModel *)testModel
{
    _testModel = testModel;
    if (testModel.groupNo == 0)
    {
        //1、设置高度
        self.headHeight.constant = 2.0;
        //2、设置组号
        self.titleLabel.text = @" ";
        //3、隐藏标题
        self.headlabel.hidden = YES;
    }
    else
    {
        //1、设置高度
        self.headHeight.constant = 25.0;
        //2、设置组号
        self.titleLabel.text = [NSString stringWithFormat:@"第%d组",testModel.groupNo];
        //3、隐藏标题
        self.headlabel.hidden = NO;
    }
}

@end

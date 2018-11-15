//
//  YYHeadTestView.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/15.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYHeadTestView.h"

@interface YYHeadTestView ()
//时间Label
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
//时间高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@end

@implementation YYHeadTestView

- (void)setModel:(YYTestModel *)model
{
    _model = model;
    if (model.groupNo == 0)
    {
        self.height.constant = 5;
        self.timeLabel.text = @" ";
        self.timeLabel.hidden = YES;
    }
    else
    {
        self.height.constant = 20;
        self.timeLabel.text = @"我是日期";
        self.timeLabel.hidden = NO;
    }
}

@end

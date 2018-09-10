//
//  YYFootView.m
//  TestTableViewProject
//
//  Created by 杨世川 on 2018/9/7.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYFootView.h"

@implementation YYFootView
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"ovalDash"] forState:UIControlStateNormal];
    [self.addButton setBackgroundImage:[UIImage imageNamed:@"ovalBlue"] forState:UIControlStateSelected];

    self.layer.borderColor = [UIColor brownColor].CGColor;
    self.layer.borderWidth = 1.0;
}

@end

//
//  YYTableViewCell.m
//  TestTableViewProject
//
//  Created by 杨世川 on 2018/9/7.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTableViewCell.h"
#import "YYDrugModel.h"

@implementation YYTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self.countButton setBackgroundImage:[UIImage imageNamed:@"ovalEmpty"] forState:UIControlStateNormal];
    [self.countButton setBackgroundImage:[UIImage imageNamed:@"ovalBlue"] forState:UIControlStateSelected];

    [self.countButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.countButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
}

#pragma mark - 点击数量按钮
- (IBAction)clickCountButton:(UIButton *)sender
{
    NSLog(@"点击Cell数量按钮");
    sender.selected = !sender.selected;
    if (self.clickCountBlock)
    {
        __weak typeof(self) weakSelf = self;
        self.clickCountBlock(weakSelf.indexPath,sender.isSelected,weakSelf);
    }
}

#pragma mark - 点击删除按钮
- (IBAction)clickDeleteButton:(UIButton *)sender
{
    NSLog(@"点击删除按钮");
    if (self.clickDeleteBlock)
    {
        __weak typeof(self) weakSelf = self;
        self.clickDeleteBlock(weakSelf.indexPath);
    }
}

#pragma mark - Getter And Setter
- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    //设置假组头(每组的第一个)
    [self.countButton setTitle:[NSString stringWithFormat:@"%ld",indexPath.section + 1] forState:UIControlStateNormal];
    self.countButton.hidden = (indexPath.row == 0) ? NO : YES;
}

- (void)setDrugModel:(YYDrugModel *)drugModel
{
    _drugModel = drugModel;
    self.countButton.selected = drugModel.isDrugSelected;
}

@end

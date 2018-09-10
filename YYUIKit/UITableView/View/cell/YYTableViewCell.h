//
//  YYTableViewCell.h
//  TestTableViewProject
//
//  Created by 杨世川 on 2018/9/7.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYTableViewCell;
@class YYDrugModel;
//点击标签按钮
typedef void (^ClickCountButtonBlock)(int sectionInt, BOOL isSelected,YYTableViewCell *cell);
//点击删除按钮
typedef void (^ClickDeleteButtonBlick)(int row,int sectionInt);

@interface YYTableViewCell : UITableViewCell
//按钮
@property (weak, nonatomic) IBOutlet UIButton *countButton;
//删除按钮
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
//组号
@property (nonatomic,assign) int sectionInt;
//行号
@property (nonatomic,assign) int row;
//model
@property (nonatomic,strong) YYDrugModel *drugModel;
//block
@property (nonatomic ,copy) ClickCountButtonBlock clickCountBlock;
@property (nonatomic ,copy) ClickDeleteButtonBlick clickDeleteBlock;
@end

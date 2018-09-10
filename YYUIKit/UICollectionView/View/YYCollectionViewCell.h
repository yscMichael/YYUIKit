//
//  YYCollectionViewCell.h
//  YYUIKit
//
//  Created by 杨世川 on 2018/9/10.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YYDrugModel;
@class YYCollectionViewCell;

typedef void (^ClickCountButtonBlock)(NSIndexPath *indexPath, BOOL isSelected,YYCollectionViewCell *cell);
typedef void (^ClickDeleteButtonBlock)(NSIndexPath *indexPath);

@interface YYCollectionViewCell : UICollectionViewCell
//数量按钮
@property (weak, nonatomic) IBOutlet UIButton *countButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
//位置
@property (nonatomic,strong) NSIndexPath *indexPath;
//模型
@property (nonatomic,strong) YYDrugModel *model;
//block
@property (nonatomic ,copy) ClickCountButtonBlock clickCountBlock;
@property (nonatomic ,copy) ClickDeleteButtonBlock clickDeleteBlock;

@end

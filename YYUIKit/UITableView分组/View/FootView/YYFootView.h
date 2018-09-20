//
//  YYFootView.h
//  TestTableViewProject
//
//  Created by 杨世川 on 2018/9/7.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ClickAddButtonBlock)(void);

@interface YYFootView : UIView
//增加按钮
@property (weak, nonatomic) IBOutlet UIButton *addButton;
//block
@property (nonatomic ,copy) ClickAddButtonBlock clickAddBlock;
@end

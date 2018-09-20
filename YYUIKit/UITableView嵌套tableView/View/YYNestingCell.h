//
//  YYNestingCell.h
//  YYUIKit
//
//  Created by 杨世川 on 2018/9/20.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYNestingCell : UITableViewCell
//列表
@property (weak, nonatomic) IBOutlet UITableView *tableView;
//列表高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
//数据源
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

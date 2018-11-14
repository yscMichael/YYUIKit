//
//  YYTableViewLayoutController.m
//  YYUIKit
//
//  Created by 杨世川 on 2018/11/14.
//  Copyright © 2018年 winwayworld. All rights reserved.
//

#import "YYTableViewLayoutController.h"
#import "YYLayoutCell.h"

static float tableViewEstimatedRowHeight = 80.0;

@interface YYTableViewLayoutController ()<UITableViewDelegate,UITableViewDataSource>
//数据源
@property (nonatomic,strong) NSMutableArray *dataSoure;
//列表
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation YYTableViewLayoutController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}

#pragma mark - Getter And Setter
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, , ScreenHeight - 100 - 64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"WWDrugSearchCell" bundle:nil] forCellReuseIdentifier:@"WWDrugSearchCell"];
        //自适应高度
        _tableView.estimatedRowHeight = tableViewEstimatedRowHeight;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)dataSoure
{
    if (!_dataSoure)
    {
        _dataSoure = [[NSMutableArray alloc] init];
    }
    return _dataSoure;
}

@end

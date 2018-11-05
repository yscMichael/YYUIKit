//
//  LayoutViewController.m
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "LayoutViewController.h"
#import "YYLayoutButton.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface LayoutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *sourceArray;

@end

@implementation LayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]init];
    }
    cell.textLabel.text = self.sourceArray[indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *tempString = self.dataArray[indexPath.row];
    Class viewControl = NSClassFromString(tempString);
    UIViewController *tempControl = [[viewControl alloc] init];
    [self.navigationController pushViewController:tempControl animated:YES];
}

#pragma mark - Getters and Setters
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }

    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray)
    {
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"BasicLayoutController",
                      @"DynamicViewController",
                      nil];
    }

    return _dataArray;
}

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray)
    {
        _sourceArray = [[NSMutableArray alloc]initWithObjects:@"方法静态使用",
                        @"方法动态使用",
                        nil];
    }

    return _sourceArray;
}



@end





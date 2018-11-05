//
//  BasicViewController.m
//  UIButton
//
//  Created by 杨世川 on 18/1/21.
//  Copyright © 2018年 杨世川. All rights reserved.
//

#import "BasicViewController.h"

#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface BasicViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *sourceArray;

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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
        _dataArray = [[NSMutableArray alloc]initWithObjects:@"ImageViewRightController",
                      @"ImageViewUpController",
                      @"ImageViewDownController",
                      @"LeftAndTopButtonController",
                      @"RightAndTopButtonController",
                      @"BottomLeftButtonController",
                      @"BottomRightButtonController",
                      @"ImageIsBiggerController",nil];
    }

    return _dataArray;
}

- (NSMutableArray *)sourceArray
{
    if (!_sourceArray)
    {
        _sourceArray = [[NSMutableArray alloc]initWithObjects:@"图片右文字左",
                        @"图片上文字下",
                        @"图片下文字上",
                        @"图片文字左上角",
                        @"图片文字右上角",
                        @"图片文字左下角",
                        @"图片文字右下角",
                        @"图片大于按钮宽度",nil];
    }

    return _sourceArray;
}

@end

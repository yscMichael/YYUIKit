//
//  YYCollectionSearchController.m
//  YYUIKit
//
//  Created by Michael on 2019/7/15.
//  Copyright © 2019年 winwayworld. All rights reserved.
//

#import "YYCollectionSearchController.h"
#import "MyCollectionViewCell.h"

@interface YYCollectionSearchController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic ,copy) NSMutableArray *sourceArr;
@property (nonatomic,strong) UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation YYCollectionSearchController
#pragma mark - Cycle Life
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.sourceArr.count;
}

- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kMyCollectionViewCellID forIndexPath:indexPath];
    NSString *imgString = self.sourceArr[indexPath.row];
    NSLog(@"imgString = %@",imgString);
    cell.imageView.image = [UIImage imageNamed:imgString];
    cell.indexPath = indexPath;
    cell.textLabel =  self.sourceArr[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//cell的代理方法 === 删除一个图标后，cell进行移动。停止操作后，刷新界面
-(void)deleteCellAtIndexpath:(NSIndexPath *)indexPath cellView:(MyCollectionViewCell *)cell
{
    //这里使用block块，先包裹代码，等代理事件执行的时候再运行
    [self.collectionView performBatchUpdates:^{
        //更新数据源数组
        [self.sourceArr removeObjectAtIndex:indexPath.row];
        //当前collectionview删除某一个cell，不是全部重新刷新界面
        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];

    } completion:^(BOOL finished)
     {
         [self.collectionView reloadData];
     }];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [[MyCollectionViewCell alloc] init];
    cell.firstLabel.text = self.sourceArr[indexPath.row];
    [cell layoutIfNeeded];
    CGRect frame = cell.frame;
    return frame.size;
}

#pragma mark - Getter And Setter
- (NSMutableArray *)sourceArr
{
    if (!_sourceArr)
    {
        _sourceArr = [NSMutableArray arrayWithObjects:@"0000000",@"111111",@"2222",@"333",@"433",@"6665",@"3336",@"117",@"324242",@"555555",@"5464646464",@"353353535353535", nil];
    }
    return _sourceArr;
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout)
    {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(130, 30);
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 2;
    }
    return _layout;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView)
    {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 244, self.view.frame.size.width,30) collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:kMyCollectionViewCellID];
    }
    return _collectionView;
}

@end

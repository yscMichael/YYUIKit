//
//  MyCollectionViewCell.h
//  CollectionViewDemo1
//
//  Created by IOS.Mac on 16/10/27.
//  Copyright © 2016年 com.elepphant.pingchuan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyCollectionViewCell;

FOUNDATION_EXPORT NSString *const kMyCollectionViewCellID;

@protocol CellDelegate <NSObject>

-(void)deleteCellAtIndexpath:(NSIndexPath *)indexPath cellView:(MyCollectionViewCell *)cell;
-(void)showAllDeleteBtn;
-(void)hideAllDeleteBtn;
@end

@interface MyCollectionViewCell : UICollectionViewCell
- (void)configureCellWithPostURL:(NSString *)posterURL;
@property (nonatomic,strong) UIButton *deleteBtn;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) NSString *textLabel;
@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,weak) id<CellDelegate>delegate;
@end

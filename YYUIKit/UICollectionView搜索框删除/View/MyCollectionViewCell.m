//
//  MyCollectionViewCell.m
//  CollectionViewDemo1
//
//  Created by IOS.Mac on 16/10/27.
//  Copyright © 2016年 com.elepphant.pingchuan. All rights reserved.
//

#import "MyCollectionViewCell.h"
#import "Masonry.h"

NSString *const kMyCollectionViewCellID = @"kMyCollectionViewCellID";
@interface MyCollectionViewCell()

@property (strong, nonatomic) UIImageView *posterView;



@end




@implementation MyCollectionViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    _posterView.image = nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setupViews];
    }
    
    return self;
}

- (void)setupViews {
//    if (_posterView) {
//        return;
//    }

    self.backgroundColor = [UIColor whiteColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
//    _posterView = ({
//        UIImageView *imageView = [UIImageView new];
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.clipsToBounds = YES;
//        [self.contentView addSubview:imageView];
//        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self.contentView);
//        }];
//        self.imageView = imageView;
//        
//        imageView;
//    });


    [self addTextLable];
    [self addDeleteButton];
}

- (void)addTextLable
{
    _firstLabel = [[UILabel alloc] init];

    _firstLabel.numberOfLines = 1;

    _firstLabel.textAlignment = NSTextAlignmentCenter;

    _firstLabel.backgroundColor = [UIColor redColor];

    _firstLabel.font = [UIFont systemFontOfSize:25];
    [self.contentView addSubview:_firstLabel];
    self.backgroundColor = [UIColor blackColor];
}

- (void)addDeleteButton
{
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _deleteBtn.frame = CGRectMake(0, 0, 20, 20);
    [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
    _deleteBtn.hidden = NO;

    /**
     *  这里删除一个按钮，添加动画
     *
     *  @param setAnimationType
     *
     *  @return
     */
    [_deleteBtn addTarget:self action:@selector(setAnimationType) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_deleteBtn];
    
}


- (void)setAnimationType
{
    if ([self.delegate respondsToSelector:@selector(deleteCellAtIndexpath:cellView:)])
    {
        [self.delegate deleteCellAtIndexpath:_indexPath cellView:self];
    }
}

- (void)layoutSubviews
{
    NSLog(@"layoutSubviews");
    [super layoutSubviews];
    CGSize sizeForFirstLabel = [self.firstLabel.text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil].size;

    self.firstLabel.frame = CGRectMake(0, 0, sizeForFirstLabel.width, sizeForFirstLabel.height);

//    CGSize sizeForSecondLabel = [self.secondLabel.text boundingRectWithSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, __FLT_MAX__) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,NSFontAttributeName:[UIFont systemFontOfSize:25]} context:nil].size;
//
//    self.secondLabel.frame = CGRectMake(sizeForFirstLabel.width, 0, sizeForSecondLabel.width, sizeForSecondLabel.height);

    CGRect frame = self.contentView.frame;

    frame.size = CGSizeMake(sizeForFirstLabel.width,sizeForFirstLabel.height);

    self.contentView.frame = frame;

    CGRect cellFrame = self.frame;

    cellFrame.size = self.contentView.frame.size;

    self.frame = cellFrame;
}

- (void)setTextLabel:(NSString *)textLabel
{
    self.firstLabel.text = textLabel;
}



#pragma mark - Public Method

- (void)configureCellWithPostURL:(NSString *)posterURL {
    _posterView.image = [UIImage imageNamed:posterURL];
}


@end

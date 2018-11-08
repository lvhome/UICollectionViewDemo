//
//  CollectionViewCell.m
//  CollectionViewDemo
//
//  Created by MAC on 2018/11/7.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "CollectionViewCell.h"
#define SCREEN_RATE       ([UIScreen mainScreen].bounds.size.width/375.0)
@interface CollectionViewCell()
/**
 *  存放所有下载操作的队列
 */
@property (nonatomic, strong) UIImageView *itemIcon;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation CollectionViewCell
@synthesize itemModel = _itemModel;

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initView];
    }
    return self;
}


- (void)initView {
    _itemIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_itemIcon];
    _itemIcon.backgroundColor = [UIColor clearColor];
    //    CGFloat iconWidth = ([UIScreen mainScreen].bounds.size.width / 5.0) * SCREEN_RATE;
    _itemIcon.frame = CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    _itemIcon.center = self.contentView.center;
}

- (CollModel *)itemModel
{
    return _itemModel;
}

- (void)setItemModel:(CollModel *)itemModel
{
    if (!itemModel) {
        return;
    }
    _itemModel = itemModel;
    [self setCellWithModel:_itemModel];
}

- (void)setCellWithModel:(CollModel *)itemModel
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        _itemIcon.image = [UIImage imageNamed:itemModel.url];
    }];
}


@end




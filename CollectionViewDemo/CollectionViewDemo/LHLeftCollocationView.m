//
//  LHLeftCollocationView.m
//  testScrollView
//
//  Created by MAC on 2018/9/28.
//  Copyright © 2018年 MAC. All rights reserved.
//

#import "LHLeftCollocationView.h"

@implementation LHLeftCollocationView



- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect targectRect = CGRectMake(proposedContentOffset.x, 0.0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    NSArray * attriArray = [super layoutAttributesForElementsInRect:targectRect];
    CGFloat horizontalCenterX = proposedContentOffset.x + ([UIScreen mainScreen].bounds.size.width);
    CGFloat offsetAdjustment = CGFLOAT_MAX;
    for (UICollectionViewLayoutAttributes * layoutAttributes in attriArray) {
        CGFloat itemHorizontalCenterX = layoutAttributes.center.x;
        if (fabs(itemHorizontalCenterX-horizontalCenterX) < fabs(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenterX - horizontalCenterX;
        }
    }
    return CGPointMake(proposedContentOffset.x , proposedContentOffset.y);
}

CGFloat ActiveDistance = 400; //垂直缩放除以系数
CGFloat ScaleFactor = 0.50;   //缩放系数  越大缩放越大

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    CGRect  visibleRect = CGRectZero;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    for (UICollectionViewLayoutAttributes *attributes  in array) {
        CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
        CGFloat normalizedDistance = fabs(distance / ActiveDistance);
        CGFloat zoom = 1 - ScaleFactor * normalizedDistance;
        NSLog(@"zoom----%f",zoom);
        attributes.transform3D = CATransform3DMakeScale(1.0, zoom, 1.0);
        //底部显示效果
        attributes.frame = CGRectMake(attributes.frame.origin.x, attributes.frame.origin.y + zoom, attributes.size.width, attributes.size.height);
        //居中显示效果
//        CGFloat scrollDirectionItemHeight = self.itemSize.height;
//        CGFloat sideItemFixedOffset = 0;
//        sideItemFixedOffset = (scrollDirectionItemHeight - scrollDirectionItemHeight * 0.7) / 2;
//        attributes.center = CGPointMake(attributes.center.x, attributes.center.y + zoom);

    }
    return array;
}

////设置放大动画
//-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
//{
//    NSArray *arr = [self getCopyOfAttributes:[super layoutAttributesForElementsInRect:rect]];
//    //屏幕中线
//    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
//    //刷新cell缩放
//    for (UICollectionViewLayoutAttributes *attributes in arr) {
//        CGFloat distance = fabs(attributes.center.x - centerX);
//        //移动的距离和屏幕宽度的的比例
//        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
//        //把卡片移动范围固定到 -π/4到 +π/4这一个范围内
//        CGFloat scale = fabs(cos(apartScale * M_PI/4));
//        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
//        attributes.transform = CGAffineTransformMakeScale(1.0, scale);
//    }
//    return arr;
//}

//防止报错 先复制attributes
- (NSArray *)getCopyOfAttributes:(NSArray *)attributes
{
    NSMutableArray *copyArr = [NSMutableArray new];
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        [copyArr addObject:[attribute copy]];
    }
    return copyArr;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}


@end

//
//  CGXPageCollectionTagsFlowLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "CGXPageCollectionBaseLayout.h"
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CGXPageCollectionTagsHorizontalAlignment) {
    CGXPageCollectionTagsHorizontalAlignmentFlow,   /**< 默认效果 */
    CGXPageCollectionTagsHorizontalAlignmentLeft,   /**< 水平居左 */
    CGXPageCollectionTagsHorizontalAlignmentCenter, /**< 水平居中 */
    CGXPageCollectionTagsHorizontalAlignmentRight   /**< 水平居右 */
};

typedef NS_ENUM(NSInteger, CGXPageCollectionTagsVerticalAlignment) {
    CGXPageCollectionTagsVerticalAlignmentCenter,   /**< 竖直方向居中 */
    CGXPageCollectionTagsVerticalAlignmentTop,      /**< 竖直方向顶部对齐 */
    CGXPageCollectionTagsVerticalAlignmentBottom    /**< 竖直方向底部对齐 */
};

typedef NS_ENUM(NSInteger, CGXPageCollectionTagsDirection) {
    CGXPageCollectionTagsDirectionLTR,              /**< 排布方向从左到右 */
    CGXPageCollectionTagsDirectionRTL               /**< 排布方向从右到左 */
};

@class CGXPageCollectionTagsFlowLayout;

@protocol CGXPageCollectionTagsFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@optional

/// 设置不同 section items 水平方向的对齐方式
/// @param collectionView UICollectionView 对象
/// @param layout 布局对象
/// @param section section
- (CGXPageCollectionTagsHorizontalAlignment)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionTagsFlowLayout *)layout itemsHorizontalAlignmentInSection:(NSInteger)section;

/// 设置不同 section items 竖直方向的对齐方式
/// @param collectionView UICollectionView 对象
/// @param layout 布局对象
/// @param section section
- (CGXPageCollectionTagsVerticalAlignment)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionTagsFlowLayout *)layout itemsVerticalAlignmentInSection:(NSInteger)section;

/// 设置不同 section items 的排布方向
/// @param collectionView UICollectionView 对象
/// @param layout 布局对象
/// @param section section
- (CGXPageCollectionTagsDirection)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionTagsFlowLayout *)layout itemsDirectionInSection:(NSInteger)section;


@end

/// 在 UICollectionViewFlowLayout 基础上，自定义 UICollectionView 对齐布局
/// 实现以下功能：
/// 1. 设置水平方向对齐方式：流式（默认）、居左、居中、居右、平铺；
/// 2. 设置竖直方向对齐方式：居中（默认）、置顶、置底；
/// 3. 设置显示条目排布方向：从左到右（默认）、从右到左。
@interface CGXPageCollectionTagsFlowLayout : CGXPageCollectionBaseLayout

/// 水平方向对齐方式，默认为流式 CGXPageCollectionTagsHorizontalAlignmentFlow
@property (nonatomic) CGXPageCollectionTagsHorizontalAlignment itemsHorizontalAlignment;
/// 竖直方向对齐方式，默认为居中 CGXPageCollectionTagsVerticalAlignmentCenter
@property (nonatomic) CGXPageCollectionTagsVerticalAlignment itemsVerticalAlignment;
/// items 排布方向，默认为从左到右 CGXPageCollectionTagsDirectionLTR
@property (nonatomic) CGXPageCollectionTagsDirection itemsDirection;

@end

@interface CGXPageCollectionTagsFlowLayout (Tagsunavailable)

// 禁用 setScrollDirection: 方法，不可设置滚动方向，默认为竖直滚动 UICollectionViewScrollDirectionVertical
- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection NS_UNAVAILABLE;

@end

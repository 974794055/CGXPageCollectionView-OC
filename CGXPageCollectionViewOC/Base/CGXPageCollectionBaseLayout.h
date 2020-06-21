//
//  CGXPageCollectionBaseLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionRoundModel.h"
#import "CGXPageCollectionFlowLayoutUtils.h"

#import "CGXPageCollectionRoundLayoutAttributes.h"
#import "CGXPageCollectionRoundReusableView.h"

#import "CGXPageCollectionUpdateRoundDelegate.h"

NS_ASSUME_NONNULL_BEGIN


@interface CGXPageCollectionBaseLayout : UICollectionViewFlowLayout

#pragma mark - Subclass Override

- (void)initializeData NS_REQUIRES_SUPER;

/// 是否开始Round计算，（默认YES），当该位置为NO时，计算模块都不开启，包括设置的代理
@property (assign, nonatomic) BOOL isRoundEnabled;
/// 是否使用不规则Cell大小的计算方式(若Cell的大小是相同固定大小，则无需开启该方法)，默认NO
@property (assign, nonatomic) BOOL isCalculateOpenIrregularCell;
@property (nonatomic, strong ,readonly) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

- (void)initializeRoundView;
@end


@interface CGXPageCollectionBaseLayout (BaseLayoutAttributes)

- (CGFloat)gx_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
- (CGFloat)gx_minimumLineSpacingForSectionAtIndex:(NSInteger)section;
- (UIEdgeInsets)gx_insetForSectionAtIndex:(NSInteger)section;

- (CGFloat)gx_referenceSizeForHeaderInSection:(NSInteger)section;
- (CGFloat)gx_referenceSizeForFooterInSection:(NSInteger)section;

- (CGSize)gx_sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface CGXPageCollectionBaseLayout (BaseLayoutline)

- (BOOL)gx_isLineStartAtIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)gx_lineAttributesArrayWithStartAttributes:(UICollectionViewLayoutAttributes *)startAttributes;

@end


@interface CGXPageCollectionBaseLayout (BaseRound)

/// 计算默认不包含headerview和footerview的背景大小
/// @param frame frame description
/// @param sectionInset sectionInset description
- (CGRect)calculateDefaultFrameWithSectionFrame:(CGRect)frame sectionInset:(UIEdgeInsets)sectionInset;

/// 计算headerview背景大小
/// @param isCalculateHeaderView  是否计算头
/// @param section  分区
/// @param numberOfItems 第几个
/// @param isOpen 是否打开不规则运算
- (CGRect)calculateDefaultFrameWithFirstHeader:(BOOL)isCalculateHeaderView
                                      Section:(NSInteger)section
                                NumberOfItems:(NSInteger)numberOfItems
                                        IsOpen:(BOOL)isOpen;
/// 计算footerview的背景大小
/// @param isCalculateFooterView  是否计算脚
/// @param section  分区
/// @param numberOfItems 第几个
/// @param isOpen 是否打开不规则运算
- (CGRect)calculateDefaultFrameWithFirstFooter:(BOOL)isCalculateFooterView
                                      Section:(NSInteger)section
                                NumberOfItems:(NSInteger)numberOfItems
                                        IsOpen:(BOOL)isOpen;

//判断是否计算headerview
- (BOOL)isCalculateHeaderViewSection:(NSInteger)section;
//判断是否计算footerView
- (BOOL)isCalculateFooterViewSection:(NSInteger)section;

//圆角配置
- (CGXPageCollectionRoundLayoutAttributes *)addRoundAttributes:(NSInteger)section
                                                  SectionFrame:(CGRect)sectionFrame
                                                  UIEdgeInsets:(UIEdgeInsets)userCustomSectionInset;
@end


NS_ASSUME_NONNULL_END

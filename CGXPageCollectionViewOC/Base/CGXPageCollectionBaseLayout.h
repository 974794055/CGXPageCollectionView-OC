//
//  CGXPageCollectionBaseLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGXPageCollectionFlowLayoutUtils.h"
#import "CGXPageCollectionRoundModel.h"
#import "CGXPageCollectionRoundLayoutAttributes.h"
#import "CGXPageCollectionRoundReusableView.h"

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
/// item水平间距
/// @param section  分区
- (CGFloat)gx_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
/// item垂直间距
/// @param section  分区
- (CGFloat)gx_minimumLineSpacingForSectionAtIndex:(NSInteger)section;
/// 分区边距
/// @param section  分区
- (UIEdgeInsets)gx_insetForSectionAtIndex:(NSInteger)section;
/// 头分区高度
/// @param section  分区
- (CGSize)gx_referenceSizeForHeaderInSection:(NSInteger)section;
/// 脚分区高度
/// @param section  分区
- (CGSize)gx_referenceSizeForFooterInSection:(NSInteger)section;
/// item的宽高
/// @param indexPath  分区
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


@interface CGXPageCollectionBaseLayout (BaseLayoutAlignment)


/// 将相同y位置的cell集合到一个列表中(竖向)
/// @param layoutAttributesAttrs layoutAttributesAttrs description
- (NSArray *)groupLayoutAttributesForElementsByYLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;
/// 将相同x位置的cell集合到一个列表中(横向)
/// @param layoutAttributesAttrs layoutAttributesAttrs description
- (NSArray *)groupLayoutAttributesForElementsByXLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;

/// 计算AttributesAttrs左对齐
/// @param layout CGXPageCollectionGeneralFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByLeftWithWithCollectionLayout:(UICollectionViewFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;

/// 计算AttributesAttrs居中对齐
/// @param layout CGXPageCollectionGeneralFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByCentertWithWithCollectionLayout:(UICollectionViewFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;

/// 计算AttributesAttrs右对齐
/// @param layout CGXPageCollectionGeneralFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByRightWithWithCollectionLayout:(UICollectionViewFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs;

@end

NS_ASSUME_NONNULL_END

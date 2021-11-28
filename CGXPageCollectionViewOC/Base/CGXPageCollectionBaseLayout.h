//
//  CGXPageCollectionBaseLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGXPageCollectionRoundModel.h"
#import "CGXPageCollectionRoundLayoutAttributes.h"
#import "CGXPageCollectionRoundReusableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionBaseLayout : UICollectionViewFlowLayout

- (void)initializeData NS_REQUIRES_SUPER;

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

/// 不规则cell找出top最高位置
/// @param section section description
/// @param defaultFrame defaultFrame description
- (CGRect)gx_calculateMinTopAtsection:(NSInteger)section defaultFrame:(CGRect)defaultFrame;
/// 不规则cell找出bootom最低位置
/// @param section section description
/// @param defaultFrame defaultFrame description
- (CGRect)gx_calculateMinBottomAtsection:(NSInteger)section defaultFrame:(CGRect)defaultFrame;

@end


NS_ASSUME_NONNULL_END

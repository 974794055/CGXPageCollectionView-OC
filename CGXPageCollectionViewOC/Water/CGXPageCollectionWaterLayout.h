//
//  CGXPageCollectionWaterLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//
#import "CGXPageCollectionBaseLayout.h"
#import <UIKit/UIKit.h>
#import "CGXPageCollectionRoundModel.h"

#import "CGXPageCollectionUpdateRoundDelegate.h"

@protocol CGXPageCollectionWaterLayoutDataSource;

@interface CGXPageCollectionWaterLayout : CGXPageCollectionBaseLayout

@property (nonatomic, weak) id<CGXPageCollectionWaterLayoutDataSource> dataSource;

@property (nonatomic,assign) BOOL sectionHeadersPinTVisibleBounds;
@property (nonatomic,assign) BOOL sectionFootersPinTVisibleBounds;
@end

@protocol CGXPageCollectionWaterLayoutDataSource<NSObject>

@required


/// Return per section's column number(must be greater than 0).
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout*)layout numberOfColumnInSection:(NSInteger)section;
/// Return per item's height   高度设置无效 等宽的
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout*)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath;
@optional
/// Column spacing between columns
//   此方法排列方式  偶数下标在左边。奇数下标在右边。   两列情况下使用
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout*)layout IsParityAItemAtIndexPath:(NSIndexPath *)indexPath;
/*
 某个分区是否是奇偶瀑布流排布
 */
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout*)layout IsParityFlowAtInSection:(NSInteger)section;

@end


@interface CGXPageCollectionWaterLayout (WaterLayoutunavailable)

- (void)setSectionFootersPinTVisibleBounds:(BOOL)sectionFootersPinTVisibleBounds NS_UNAVAILABLE;
- (void)setSectionHeadersPinTVisibleBounds:(BOOL)sectionHeadersPinTVisibleBounds NS_UNAVAILABLE;

@end

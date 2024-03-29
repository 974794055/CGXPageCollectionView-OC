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

@protocol CGXPageCollectionWaterLayoutDataSource;

@interface CGXPageCollectionWaterLayout : CGXPageCollectionBaseLayout

@property (nonatomic, weak) id<CGXPageCollectionWaterLayoutDataSource> dataSource;

@property (nonatomic,assign) BOOL sectionFootersPinTVisibleBounds;

- (void)setSectionFootersPinToVisibleBounds:(BOOL)sectionFootersPinTVisibleBounds NS_UNAVAILABLE;
- (void)setSectionHeadersPinToVisibleBounds:(BOOL)sectionHeadersPinTVisibleBounds NS_UNAVAILABLE;

@end

@protocol CGXPageCollectionWaterLayoutDataSource<CGXPageCollectionUpdateRoundDelegate>

@required

/// Return per section's column number(must be greater than 0).
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout*)layout numberOfColumnInSection:(NSInteger)section;
/// Return per item's height   高度设置无效 等宽的
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout*)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/*此方法排列方式  偶数下标在左边。奇数下标在右边。   两列情况下使用*/
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout*)layout IsParityAItemAtIndexPath:(NSIndexPath *)indexPath;
/*某个分区是否是奇偶瀑布流排布*/
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout*)layout IsParityFlowAtInSection:(NSInteger)section;
/*是否头悬停*/
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout *)collectionViewLayout sectionHeadersPinAtSection:(NSInteger)section;
/*头悬停上部距离*/
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout *)collectionViewLayout sectionHeadersPinTopSpaceAtSection:(NSInteger)section;

@end


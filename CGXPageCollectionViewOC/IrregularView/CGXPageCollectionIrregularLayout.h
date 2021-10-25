//
//  CGXPageCollectionIrregularLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseLayout.h"

#import "CGXPageCollectionIrreguarSectionModel.h"

@class CGXPageCollectionIrregularLayout;

@protocol CGXPageCollectionIrregularLayoutDelegate <NSObject>

@required


/// Return per item's height  普通 几行几列使用
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath;


/// Return  top per item's height  上半部分高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout itemWidth:(CGFloat)width TopHeightForItemAtIndexPath:(NSIndexPath *)indexPath;
/// Return bottom per item's height 下半部分高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout itemWidth:(CGFloat)width BottomHeightForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional;

//存放每个分区的布局属性
- (CGXPageCollectionIrregularLayoutShowType)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout*)collectionViewLayout layoutAttributesTypeArrayForInSection:(NSInteger)section;


- (NSInteger)collectionIrregularView:(UICollectionView *)collectionView numberOfItemsInSectionBottom:(NSInteger)section;
- (NSInteger)collectionIrregularView:(UICollectionView *)collectionView numberOfItemsInSectionTop:(NSInteger)section;
- (NSInteger)collectionIrregularView:(UICollectionView *)collectionView numberOfItemsInRowTop:(NSInteger)section;

@end

@interface CGXPageCollectionIrregularLayout : CGXPageCollectionBaseLayout

@property (nonatomic, assign) id<CGXPageCollectionIrregularLayoutDelegate>delegate;

@end

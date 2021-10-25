//
//  CGXPageCollectionHorizontalLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseLayout.h"

NS_ASSUME_NONNULL_BEGIN

@class CGXPageCollectionIrregularLayout;

@protocol CGXPageCollectionHorizontalLayouttDelegate <NSObject>

@required


@optional;

- (NSInteger)collectionHorizontalView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout numberOfSection:(NSInteger)section;

@end

@interface CGXPageCollectionHorizontalLayout : CGXPageCollectionBaseLayout

@property (nonatomic , weak) id<CGXPageCollectionHorizontalLayouttDelegate>delegate;

/// 是否开始Round计算，（默认YES），当该位置为NO时，计算模块都不开启，包括设置的代理
@property (assign, nonatomic) BOOL isRoundEnabled;
/// 是否使用不规则Cell大小的计算方式(若Cell的大小是相同固定大小，则无需开启该方法)，默认NO
@property (assign, nonatomic) BOOL isCalculateOpenIrregularCell;

@end

NS_ASSUME_NONNULL_END

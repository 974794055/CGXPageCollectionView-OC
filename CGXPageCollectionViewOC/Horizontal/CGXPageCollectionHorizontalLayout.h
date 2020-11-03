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

@end

NS_ASSUME_NONNULL_END

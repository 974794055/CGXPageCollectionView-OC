//
//  CGXPageCollectionHorizontalLayout.h
//  CGXPageCollectionViewOC
//
//  Created by MacMini-1 on 2020/7/8.
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

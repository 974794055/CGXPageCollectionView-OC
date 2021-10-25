//
//  CGXPageCollectionGeneralFlowLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseLayout.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol CGXPageCollectionGeneralFlowLayoutDataDelegate<CGXPageCollectionUpdateRoundDelegate>

@required

@optional

/*
 是否头悬停
 @param collectionView collectionView description
 @param collectionView collectionView description
 @param layout layout description 
 @param section section description
*/
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayou headersPinAtSection:(NSInteger)section;
/*
 头悬停上部距离
 @param collectionView collectionView description
 @param collectionView collectionView description
 @param layout layout description
 @param section section description
*/
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayou headersPinSpaceAtSection:(NSInteger)section;

@end

@interface CGXPageCollectionGeneralFlowLayout : CGXPageCollectionBaseLayout

@property (nonatomic, weak) id<CGXPageCollectionGeneralFlowLayoutDataDelegate> dataSource;

@end

NS_ASSUME_NONNULL_END

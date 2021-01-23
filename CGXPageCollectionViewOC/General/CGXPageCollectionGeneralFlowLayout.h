//
//  CGXPageCollectionGeneralFlowLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseLayout.h"
#import <UIKit/UIKit.h>
#import "CGXPageCollectionUpdateRoundDelegate.h"
NS_ASSUME_NONNULL_BEGIN


@protocol CGXPageCollectionGeneralFlowLayoutDataDelegate<UICollectionViewDelegateFlowLayout>

@required

@optional
/*
 是否悬停
 */
- (BOOL)generalCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sectionHeadersPinAtSection:(NSInteger)section;
/*
 悬停上部距离
 */
- (CGFloat)generalCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sectionHeadersPinTopSpaceAtSection:(NSInteger)section;

@end

@interface CGXPageCollectionGeneralFlowLayout : CGXPageCollectionBaseLayout

@property (nonatomic, weak) id<CGXPageCollectionGeneralFlowLayoutDataDelegate> dataSource;


@end

NS_ASSUME_NONNULL_END

//
//  CGXPageCollectionBaseLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseLayout.h"
@interface CGXPageCollectionBaseLayout ()

//@property (nonatomic, strong , readwrite) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@end
@implementation CGXPageCollectionBaseLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initializeData];
    }
    return self;
}
- (void)initializeData
{

}
- (void)initializeRoundView
{

}

- (CGFloat)gx_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
    if (numberOfItems == 0) {
        return 0;
    }
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return self.minimumInteritemSpacing;
    }
}
- (CGFloat)gx_minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
    if (numberOfItems == 0) {
        return 0;
    }
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    } else {
        return self.minimumLineSpacing;
    }
}
- (CGSize)gx_referenceSizeForHeaderInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(0, 0);
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        size = [delegate collectionView:self.collectionView layout:self referenceSizeForHeaderInSection:section];
    } else{
        size = self.headerReferenceSize;
    }
    return size;
}
- (CGSize)gx_referenceSizeForFooterInSection:(NSInteger)section
{
    CGSize size = CGSizeMake(0, 0);
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        size = [delegate collectionView:self.collectionView layout:self referenceSizeForFooterInSection:section];
    } else{
        size = self.footerReferenceSize;
    }
    return size;
}
- (UIEdgeInsets)gx_insetForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    } else {
        return self.sectionInset;
    }
}
- (CGSize)gx_sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    } else {
        return self.itemSize;
    }
}
/// 不规则cell找出top最高位置
/// @param section section description
/// @param defaultFrame defaultFrame description
- (CGRect)gx_calculateMinTopAtsection:(NSInteger)section defaultFrame:(CGRect)defaultFrame
{
    CGRect firstFrame = defaultFrame;
    NSInteger const numberOfItems = [self.collectionView numberOfItemsInSection:section];
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //竖向
        CGFloat minY = CGRectGetMinY(firstFrame);
        for (NSInteger i = 0; i <= numberOfItems - 1; i ++ ) {
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            minY = MIN(minY, CGRectGetMinY(attr.frame));
        }
        CGRect rect = firstFrame;
        firstFrame = CGRectMake(rect.origin.x, minY, rect.size.width, rect.size.height);
    }else{
        //横向
        CGFloat minX = CGRectGetMinX(firstFrame);
        for (NSInteger i = 0; i <= numberOfItems - 1; i ++ ) {
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            minX = MIN(minX, CGRectGetMinX(attr.frame));
        }
        CGRect rect = firstFrame;
        firstFrame = CGRectMake(minX ,rect.origin.y, rect.size.width, rect.size.height);
    }
    return firstFrame;
}

/// 不规则cell找出bootom最低位置
/// @param section section description
/// @param defaultFrame defaultFrame description
- (CGRect)gx_calculateMinBottomAtsection:(NSInteger)section defaultFrame:(CGRect)defaultFrame
{
    CGRect lastFrame = defaultFrame;
    NSInteger const numberOfItems = [self.collectionView numberOfItemsInSection:section];
    if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //竖向
        CGFloat maxY = CGRectGetMinY(lastFrame);
        NSInteger index = numberOfItems-1;
        for (NSInteger i = 0; i <= numberOfItems - 1; i ++ ) {
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            if (maxY < MAX(maxY, CGRectGetMaxY(attr.frame))) {
                maxY = MAX(maxY, CGRectGetMaxY(attr.frame));
                index = i;
            }
        }
        lastFrame = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]].frame;
    }else{
        //横向
        CGFloat maxX = CGRectGetMaxX(lastFrame);
        NSInteger index = numberOfItems-1;
        for (NSInteger i = 0; i <= numberOfItems - 1; i ++ ) {
            UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            if (maxX < MAX(maxX, CGRectGetMaxX(attr.frame))) {
                maxX = MAX(maxX, CGRectGetMaxX(attr.frame));
                index = i;
            }
        }
        lastFrame = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]].frame;
    }
    return lastFrame;
}


- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;

}

@end

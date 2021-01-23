//
//  CGXPageCollectionGeneralFlowLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionGeneralFlowLayout.h"
#import "CGXPageCollectionFlowLayoutUtils.h"
#import "CGXPageCollectionRoundLayoutAttributes.h"
#import "CGXPageCollectionRoundReusableView.h"

@interface CGXPageCollectionGeneralFlowLayout ()


@end


@implementation CGXPageCollectionGeneralFlowLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.isRoundEnabled = YES;
    }
    return self;
}
- (void)prepareLayout{
    [super prepareLayout];
    [self initializeRoundView];
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * attrsArr = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        [attrsArr addObject:attr];
    }
    
    //    BOOL sectionHeaderViewHovering = NO;
    //    if (self.dataSource && [self.dataSource respondsToSelector:@selector(generalCollectionView:layout:sectionHeadersPinAtSection:)]) {
    //        sectionHeaderViewHovering = [self.dataSource generalCollectionView:self.collectionView layout:self sectionHeadersPinAtSection:0];
    //    }
    //    if (!_sectionHeaderViewHovering) {
    //        return [super layoutAttributesForElementsInRect:rect];
    //    }
    //    NSMutableArray *attributes = [NSMutableArray arrayWithArray:[super layoutAttributesForElementsInRect:rect]];
    //    for (UICollectionViewLayoutAttributes *attribute in attrsArr)
    //    {
    //        if (!CGRectIntersectsRect(rect, attribute.frame))
    //            continue;
    //        [attributes addObject:attribute];
    //    }
//    if (_sectionHeaderViewHovering) {
        [self layoutHeaderFooterAttributesForElementsInRect:rect attributes:attrsArr];
//    }
    return attrsArr;
}


//return YES;表示一旦滑动就实时调用上面这个layoutAttributesForElementsInRect:方法
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
    return YES;
}
// 引用了XLPlainFlowLayout
- (void)layoutHeaderFooterAttributesForElementsInRect:(CGRect)rect attributes:(NSMutableArray *)superAttributes
{
    NSMutableIndexSet *noneHeaderSections = [NSMutableIndexSet indexSet];
    for (UICollectionViewLayoutAttributes *attributes in superAttributes)
    {
        if (attributes.representedElementCategory == UICollectionElementCategoryCell)
        {
            [noneHeaderSections addIndex:attributes.indexPath.section];
        }
    }
    for (UICollectionViewLayoutAttributes *attributes in superAttributes)
    {
        if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader])
        {
            [noneHeaderSections removeIndex:attributes.indexPath.section];
        }
    }
    [noneHeaderSections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop){
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:idx];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexPath];
        if (attributes)
        {
            [superAttributes addObject:attributes];
        }
    }];
    for (UICollectionViewLayoutAttributes *attributes in superAttributes) {
        BOOL sectionHeaderViewHovering = NO;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(generalCollectionView:layout:sectionHeadersPinAtSection:)]) {
            sectionHeaderViewHovering = [self.dataSource generalCollectionView:self.collectionView layout:self sectionHeadersPinAtSection:0];
        }
        CGFloat sectionHeaderViewHoveringTopEdging = 0;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(generalCollectionView:layout:sectionHeadersPinTopSpaceAtSection:)]) {
            sectionHeaderViewHoveringTopEdging = [self.dataSource generalCollectionView:self.collectionView layout:self sectionHeadersPinTopSpaceAtSection:attributes.indexPath.section];
        }
        UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:attributes.indexPath.section];
        
        if (sectionHeaderViewHovering) {
            if ([attributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]){
                NSInteger numberOfItemsInSection = [self.collectionView numberOfItemsInSection:attributes.indexPath.section];
                NSIndexPath *firstItemIndexPath = [NSIndexPath indexPathForItem:0 inSection:attributes.indexPath.section];
                NSIndexPath *lastItemIndexPath = [NSIndexPath indexPathForItem:MAX(0, numberOfItemsInSection-1) inSection:attributes.indexPath.section];
                UICollectionViewLayoutAttributes *firstItemAttributes, *lastItemAttributes;
                if (numberOfItemsInSection>0){
                    firstItemAttributes = [self layoutAttributesForItemAtIndexPath:firstItemIndexPath];
                    lastItemAttributes = [self layoutAttributesForItemAtIndexPath:lastItemIndexPath];
                }else{
                    firstItemAttributes = [UICollectionViewLayoutAttributes new];
                    CGFloat y = CGRectGetMaxY(attributes.frame)+self.sectionInset.top;
                    firstItemAttributes.frame = CGRectMake(0, y, 0, 0);
                    lastItemAttributes = firstItemAttributes;
                }
                CGRect rect = attributes.frame;
                CGFloat offset = self.collectionView.contentOffset.y + sectionHeaderViewHoveringTopEdging;
                CGFloat headerY = firstItemAttributes.frame.origin.y - rect.size.height - sectionInset.top;
                CGFloat maxY = MAX(offset,headerY);
                CGFloat headerMissingY = CGRectGetMaxY(lastItemAttributes.frame) + sectionInset.bottom - rect.size.height;
                rect.origin.y = MIN(maxY,headerMissingY);
                attributes.frame = rect;
                attributes.zIndex = 1;
            }
        }
    }
}

@end





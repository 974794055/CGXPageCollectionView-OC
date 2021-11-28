//
//  CGXPageCollectionGeneralFlowLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionGeneralFlowLayout.h"
#import "CGXPageCollectionRoundLayoutAttributes.h"
#import "CGXPageCollectionRoundReusableView.h"

@interface CGXPageCollectionGeneralFlowLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;
@property (assign, nonatomic) CGSize newBoundsSize;
@end


@implementation CGXPageCollectionGeneralFlowLayout

- (void)initializeData
{
    [super initializeData];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
}
- (void)prepareLayout{
    [super prepareLayout];
    
    id <CGXPageCollectionUpdateRoundDelegate> delegate  = (id <CGXPageCollectionUpdateRoundDelegate>)self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:configModelForSectionAtIndex:)]) {
        [self registerClass:[CGXPageCollectionRoundReusableView class] forDecorationViewOfKind:NSStringFromClass([CGXPageCollectionRoundReusableView class])];
        [self.decorationViewAttrs removeAllObjects];
        NSInteger sections = [self.collectionView numberOfSections];
        for (NSInteger section = 0; section < sections; section++) {
            NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
            UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:section];
            if (numberOfItems > 0) {
                UICollectionViewLayoutAttributes *firstAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                CGRect firstFrame = firstAttr.frame;
                UICollectionViewLayoutAttributes *lastAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(numberOfItems - 1) inSection:section]];
                CGRect lastFrame = lastAttr.frame;
                UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                
                BOOL isHeaderAttr = (headerAttr &&
                                     (headerAttr.frame.size.width != 0  && headerAttr.frame.size.height != 0));
                BOOL isFooterAttr = (footerAttr &&
                                     (footerAttr.frame.size.width != 0  && footerAttr.frame.size.height != 0));
                
                //判断是否计算headerview
                BOOL isCalculateHeaderView = [self isCalculateHeaderViewSection:section] && isHeaderAttr;
                //判断是否计算footerView
                BOOL isCalculateFooterView = [self isCalculateFooterViewSection:section] && isFooterAttr;
                
                
                firstFrame = firstAttr.frame;
                if (isCalculateHeaderView) {
                    if (headerAttr &&
                        (headerAttr.frame.size.width != 0|| headerAttr.frame.size.height != 0)) {
                        firstFrame = headerAttr.frame;
                    }else{
                        CGRect rect = [self gx_calculateMinTopAtsection:section defaultFrame:firstFrame];
                        firstFrame = CGRectMake(rect.origin.x, rect.origin.y, self.collectionView.bounds.size.width, rect.size.height);
                    }
                }else{
                    firstFrame = [self gx_calculateMinTopAtsection:section defaultFrame:firstFrame];
                }
                lastFrame = lastAttr.frame;
                if (isCalculateFooterView) {
                    if (footerAttr &&
                        (footerAttr.frame.size.width != 0 || footerAttr.frame.size.height != 0)) {
                        lastFrame = footerAttr.frame;
                    }else{
                        CGRect rect = [self gx_calculateMinBottomAtsection:section defaultFrame:lastFrame];
                        lastFrame = CGRectMake(rect.origin.x, rect.origin.y, self.collectionView.bounds.size.width, rect.size.height);
                    }
                }else{
                    lastFrame = [self gx_calculateMinBottomAtsection:section defaultFrame:lastFrame];
                }
                
                CGRect sectionFrame = CGRectUnion(firstFrame, lastFrame);
                if (!isCalculateHeaderView && !isCalculateFooterView) {
                    sectionFrame.origin.x -= sectionInset.left;
                    sectionFrame.origin.y -= sectionInset.top;
                    sectionFrame.size.width = self.collectionView.frame.size.width;
                    sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
                }else{
                    if (isCalculateHeaderView && !isCalculateFooterView) {
                        sectionFrame.size.height += sectionInset.bottom;
                        
                    }else if (!isCalculateHeaderView && isCalculateFooterView) {
                        
                        sectionFrame.origin.y -= sectionInset.top;
                        sectionFrame.size.width = self.collectionView.frame.size.width;
                        sectionFrame.size.height += sectionInset.top;
                    }
                }
                
                UIEdgeInsets userCustomSectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
                if ([delegate respondsToSelector:@selector(collectionView:layout:borderEdgeInsertsForSectionAtIndex:)]) {
                    //检测是否实现了该方法，进行赋值
                    userCustomSectionInset = [delegate collectionView:self.collectionView layout:self borderEdgeInsertsForSectionAtIndex:section];
                }
                sectionFrame.origin.x += userCustomSectionInset.left;
                sectionFrame.origin.y += userCustomSectionInset.top;
                if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                    sectionFrame.size.width -= (userCustomSectionInset.left + userCustomSectionInset.right);
                    sectionFrame.size.height -= (userCustomSectionInset.top + userCustomSectionInset.bottom);
                }else{
                    sectionFrame.size.width -= (userCustomSectionInset.left + userCustomSectionInset.right);
                    sectionFrame.size.height -= (userCustomSectionInset.top + userCustomSectionInset.bottom);
                }
                
                
                CGXPageCollectionRoundLayoutAttributes *attr = [CGXPageCollectionRoundLayoutAttributes layoutAttributesForDecorationViewOfKind:NSStringFromClass([CGXPageCollectionRoundReusableView class]) withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
                attr.frame = sectionFrame;
                attr.zIndex = -1;
                id <CGXPageCollectionUpdateRoundDelegate> delegate  = (id <CGXPageCollectionUpdateRoundDelegate>)self.collectionView.delegate;
                if ([delegate respondsToSelector:@selector(collectionView:layout:configModelForSectionAtIndex:)]) {
                    attr.roundModel = [delegate collectionView:self.collectionView layout:self configModelForSectionAtIndex:section];
                }
                [self.decorationViewAttrs addObject:attr];
            }
        }
    }
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * attrsArr = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        [attrsArr addObject:attr];
    }
    [self layoutHeaderFooterAttributesForElementsInRect:rect attributes:attrsArr];
    return attrsArr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (CGSizeEqualToSize(self.newBoundsSize, newBounds.size)) {
        return NO;
    }
    self.newBoundsSize = newBounds.size;
    return YES;
}
- (NSMutableArray<UICollectionViewLayoutAttributes *> *)decorationViewAttrs{
    if (!_decorationViewAttrs) {
        _decorationViewAttrs = [NSMutableArray array];
    }
    return _decorationViewAttrs;
}
//判断是否计算headerview
- (BOOL)isCalculateHeaderViewSection:(NSInteger)section
{
    BOOL isCalculateHeaderView = NO;
    id <CGXPageCollectionUpdateRoundDelegate> delegate  = (id <CGXPageCollectionUpdateRoundDelegate>)self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:isCalculateHeaderViewIndex:)]) {
        isCalculateHeaderView = [delegate collectionView:self.collectionView layout:self isCalculateHeaderViewIndex:section];
    }
    return isCalculateHeaderView;
}
//判断是否计算footerView
- (BOOL)isCalculateFooterViewSection:(NSInteger)section
{
    BOOL isCalculateFooterView = NO;
    id <CGXPageCollectionUpdateRoundDelegate> delegate  = (id <CGXPageCollectionUpdateRoundDelegate>)self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:isCalculateFooterViewIndex:)]) {
        isCalculateFooterView = [delegate collectionView:self.collectionView layout:self isCalculateFooterViewIndex:section];
    }
    return isCalculateFooterView;
}
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
            sectionHeaderViewHovering = [self.dataSource generalCollectionView:self.collectionView layout:self sectionHeadersPinAtSection:attributes.indexPath.section];
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





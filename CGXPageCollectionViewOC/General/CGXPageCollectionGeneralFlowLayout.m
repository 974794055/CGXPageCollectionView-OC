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

@property (nonatomic, strong) NSMutableArray *attrsArr;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@end

@implementation CGXPageCollectionGeneralFlowLayout


- (void)prepareLayout{
    [super prepareLayout];
    // 使用外部传递的delegate，否则使用collectionView自己的
    id <CGXPageCollectionGeneralFlowLayoutDataDelegate> delegate  = self.dataSource;
    if (!delegate) {
        delegate  = (id <CGXPageCollectionGeneralFlowLayoutDataDelegate>)self.collectionView.delegate;
    }
    BOOL isRoundView = NO;
    //检测是否实现了背景样式模块代理
    if ([delegate respondsToSelector:@selector(collectionView:layout:configModelForSectionAtIndex:)]) {
        //1.初始化
        [self registerClass:[CGXPageCollectionRoundReusableView class] forDecorationViewOfKind:NSStringFromClass([CGXPageCollectionRoundReusableView class])];
        [self.decorationViewAttrs removeAllObjects];
        isRoundView = YES;
    }
    NSMutableArray *attributesArr = [NSMutableArray array];
    UICollectionView *collectionView = self.collectionView;
    NSInteger const numberOfSections = collectionView.numberOfSections;
    UIEdgeInsets const contentInset = collectionView.contentInset;
    CGFloat const contentWidth = collectionView.bounds.size.width - contentInset.left - contentInset.right;
    for (int section = 0; section < numberOfSections; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        NSIndexPath *indexP = [NSIndexPath indexPathWithIndex:section];
        UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:section];
        CGFloat headerHeight = [self gx_referenceSizeForHeaderInSection:section].height;
        CGFloat footerHeight = [self gx_referenceSizeForFooterInSection:section].height;

        UIEdgeInsets userCustomSectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        if ([delegate respondsToSelector:@selector(collectionView:layout:borderEdgeInsertsForSectionAtIndex:)]) {
            userCustomSectionInset = [delegate collectionView:self.collectionView layout:self borderEdgeInsertsForSectionAtIndex:section];
        }
        sectionInset = UIEdgeInsetsMake(sectionInset.top, sectionInset.left+userCustomSectionInset.left, sectionInset.bottom, sectionInset.right+userCustomSectionInset.right);

        //判断是否计算headerview
        BOOL isCalculateHeaderView = [self isCalculateHeaderViewSection:section];
        if (isCalculateHeaderView && headerHeight == 0) {
            isCalculateHeaderView = NO;
        }
        //判断是否计算footerView
        BOOL isCalculateFooterView = [self isCalculateFooterViewSection:section];
        if (isCalculateFooterView && footerHeight == 0) {
            isCalculateFooterView = NO;
        }
        CGFloat headerSpace = userCustomSectionInset.top;
        if ([delegate respondsToSelector:@selector(collectionView:layout:spaceHeaderViewIndex:)]) {
            headerSpace = [delegate collectionView:self.collectionView layout:self spaceHeaderViewIndex:section];
        }
        CGFloat footerSpace = userCustomSectionInset.bottom;
        if ([delegate respondsToSelector:@selector(collectionView:layout:spaceFooterViewIndex:)]) {
            footerSpace = [delegate collectionView:self.collectionView layout:self spaceFooterViewIndex:section];
        }

        UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexP];
        if (isCalculateHeaderView) {
            headerAttr.frame = CGRectMake(0, headerAttr.frame.origin.y+headerSpace, contentWidth, headerHeight);
        }

        [attributesArr addObject:headerAttr];

        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:section];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [attributesArr addObject:attrs];
        }
        UICollectionViewLayoutAttributes *footerAttr =[self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexP];
        [attributesArr addObject:footerAttr];

        if (isRoundView) {
            CGRect sectionFrame = CGRectNull;
            sectionFrame = CGRectUnion(headerAttr.frame, footerAttr.frame);
            if (CGRectIsNull(sectionFrame)) {
                continue;
            }
            // 有头分区无脚分区
            if (isCalculateHeaderView && !isCalculateFooterView){
                sectionFrame.size.height -= footerHeight+footerSpace;
            }
            // 无头分区有脚分区
            if (!isCalculateHeaderView && isCalculateFooterView){
                sectionFrame.size.height -= headerHeight+headerSpace;
                sectionFrame.origin.y += headerHeight+headerSpace;
            }
            // 无头分区无脚分区
            if (!isCalculateHeaderView && !isCalculateFooterView){
                sectionFrame.origin.y += headerHeight+headerSpace;
                sectionFrame.size.height -= headerHeight+footerHeight+headerSpace+footerSpace;
            }
            if (CGRectIsNull(sectionFrame)) {
                continue;
            }
            sectionFrame.origin.x += userCustomSectionInset.left;
            sectionFrame.size.width -= (userCustomSectionInset.left + userCustomSectionInset.right);
            CGXPageCollectionRoundLayoutAttributes *attr = [CGXPageCollectionRoundLayoutAttributes layoutAttributesForDecorationViewOfKind:NSStringFromClass([CGXPageCollectionRoundReusableView class]) withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            attr.frame = sectionFrame;
            attr.zIndex = -1;
            attr.borderEdgeInsets = userCustomSectionInset;
            attr.roundModel.backgroundColor = [UIColor redColor];
            if ([delegate respondsToSelector:@selector(collectionView:layout:configModelForSectionAtIndex:)]) {
                attr.roundModel = [delegate collectionView:self.collectionView layout:self configModelForSectionAtIndex:section];
            }
            [self.decorationViewAttrs addObject:attr];
        }
    }
    self.attrsArr = [NSMutableArray arrayWithArray:attributesArr];
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * attrsArr = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.attrsArr) {
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attrsArr addObject:attr];
        }
    }
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        [attrsArr addObject:attr];
    }
    [self layoutHeaderFooterAttributesForElementsInRect:rect attributes:attrsArr];
    return attrsArr;
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
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:layout:headersPinAtSection:)]) {
            sectionHeaderViewHovering = [self.dataSource collectionView:self.collectionView layout:self headersPinAtSection:attributes.indexPath.section];
        }
        CGFloat sectionHeaderViewHoveringTopEdging = 0;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:layout:headersPinSpaceAtSection:)]) {
            sectionHeaderViewHoveringTopEdging = [self.dataSource collectionView:self.collectionView layout:self headersPinSpaceAtSection:attributes.indexPath.section];
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

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBound
{
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

@end





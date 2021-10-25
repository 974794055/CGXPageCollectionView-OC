//
//  CGXPageCollectionWaterLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionWaterLayout.h"
#import "CGXPageCollectionRoundLayoutAttributes.h"
#import "CGXPageCollectionRoundReusableView.h"
@interface CGXPageCollectionWaterLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;

@property (nonatomic, strong) NSMutableArray<NSMutableArray<UICollectionViewLayoutAttributes *> *> *attrsArr;

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *headerAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *footerAttributes;

@property (nonatomic, assign) CGFloat contentHeight;

/// Per section heights.
@property (nonatomic, strong) NSMutableArray<NSNumber *> *heightOfSections;

@end

@implementation CGXPageCollectionWaterLayout
- (void)initializeData
{
    [super initializeData];
}
- (void)prepareLayout{
    [super prepareLayout];
    if (self.collectionView.isDecelerating || self.collectionView.isDragging) {
        return;
    }
    _attrsArr = [NSMutableArray array];
    _headerAttributes = [NSMutableArray array];
    _footerAttributes = [NSMutableArray array];
    _heightOfSections = [NSMutableArray array];
    UICollectionView *collectionView = self.collectionView;
    NSInteger const numberOfSections = collectionView.numberOfSections;
    UIEdgeInsets const contentInset = collectionView.contentInset;
    CGFloat const contentWidth = collectionView.bounds.size.width - contentInset.left - contentInset.right;
    _contentHeight = 0;
    
    // 使用外部传递的delegate，否则使用collectionView自己的
    id <CGXPageCollectionUpdateRoundDelegate> delegate  = (id <CGXPageCollectionUpdateRoundDelegate>)self.collectionView.delegate;
    BOOL isRoundView = NO;
    //检测是否实现了背景样式模块代理
    if ([delegate respondsToSelector:@selector(collectionView:layout:configModelForSectionAtIndex:)]) {
        //1.初始化
        [self registerClass:[CGXPageCollectionRoundReusableView class] forDecorationViewOfKind:NSStringFromClass([CGXPageCollectionRoundReusableView class])];
        [self.decorationViewAttrs removeAllObjects];
        isRoundView = YES;
    }
    
    for (NSInteger section=0; section < numberOfSections; section++) {
        UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:section];
        CGFloat const minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:section];
        CGFloat const minimumInteritemSpacing = [self gx_minimumInteritemSpacingForSectionAtIndex:section];
        CGFloat headerHeight = [self gx_referenceSizeForHeaderInSection:section].height;
        CGFloat footerHeight = [self gx_referenceSizeForFooterInSection:section].height;
        NSInteger const numberOfItems = [collectionView numberOfItemsInSection:section];
        
        UIEdgeInsets userCustomSectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        if ([delegate respondsToSelector:@selector(collectionView:layout:borderEdgeInsertsForSectionAtIndex:)]) {
            userCustomSectionInset = [delegate collectionView:self.collectionView layout:self borderEdgeInsertsForSectionAtIndex:section];
        }
        sectionInset = UIEdgeInsetsMake(sectionInset.top, sectionInset.left+userCustomSectionInset.left, sectionInset.bottom, sectionInset.right+userCustomSectionInset.right);
        
        CGFloat const contentWidthOfSection = contentWidth - sectionInset.left - sectionInset.right;
        
        NSInteger columnOfSection = 1;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:layout:numberOfColumnInSection:)]) {
            columnOfSection = [self.dataSource collectionView:collectionView layout:self numberOfColumnInSection:section];
        }
        NSAssert(columnOfSection > 0, @"[gx_CustomRoundFlowLayout collectionView:layout:numberOfColumnInSection:] must be greater than 0.");
        
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
        
        UICollectionViewLayoutAttributes *headerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        if (isRoundView) {
            if (headerHeight> 0) {
                _contentHeight += headerSpace;
            }
        }
        headerAttr.frame = CGRectMake(0, _contentHeight, contentWidth, headerHeight);
        [self.headerAttributes addObject:headerAttr];
        
        CGFloat offsetOfColumns[columnOfSection];
        for (NSInteger i=0; i<columnOfSection; i++) {
            offsetOfColumns[i] = headerHeight + sectionInset.top;
        }
        
        /*
         某个分区是否是奇偶瀑布流排布
         */
        BOOL isParity = NO;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:layout:IsParityFlowAtInSection:)]) {
            isParity = [self.dataSource collectionView:collectionView layout:self IsParityFlowAtInSection:section];
        }
        NSMutableArray *layoutAttributeOfSection = [NSMutableArray arrayWithCapacity:numberOfItems];
        for (NSInteger item=0; item<numberOfItems; item++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            UICollectionViewLayoutAttributes *layoutAttbiture = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            CGSize sizeItemheight  = [self gx_sizeForItemAtIndexPath:indexPath];
            CGFloat itemHeight = floor(sizeItemheight.height);
            CGFloat itemWidth = sizeItemheight.height;
            if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:layout:itemWidth:heightForItemAtIndexPath:)]) {
                itemWidth = (contentWidthOfSection-(columnOfSection-1)*minimumInteritemSpacing) / columnOfSection;
                itemHeight = [self.dataSource collectionView:collectionView layout:self itemWidth:itemWidth heightForItemAtIndexPath:indexPath].height;
            }
            NSInteger currentColumn = 0;
            for (NSInteger i=1; i<columnOfSection; i++) {
                if (offsetOfColumns[currentColumn] > offsetOfColumns[i]) {
                    currentColumn = i;
                }
            }
            
            if (isParity) {
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:layout:IsParityAItemAtIndexPath:)]) {
                    currentColumn = [self.dataSource collectionView:collectionView layout:self IsParityAItemAtIndexPath:indexPath];
                }
            }
            CGFloat x = sectionInset.left + itemWidth*currentColumn + minimumInteritemSpacing*currentColumn;
            CGFloat y = offsetOfColumns[currentColumn] + (item>=columnOfSection ? minimumLineSpacing : 0.0);
            if (isRoundView) {
                if (!isCalculateHeaderView && item < columnOfSection) {
                    y += headerSpace;
                }
            }
            layoutAttbiture.frame = CGRectMake(x, y+_contentHeight, itemWidth, itemHeight);
            [layoutAttributeOfSection addObject:layoutAttbiture];
            offsetOfColumns[currentColumn] = (y + itemHeight);
        }
        [self.attrsArr addObject:layoutAttributeOfSection];
        CGFloat maxOffsetValue = offsetOfColumns[0];
        for (int i=1; i<columnOfSection; i++) {
            if (offsetOfColumns[i] > maxOffsetValue) {
                maxOffsetValue = offsetOfColumns[i];
            }
        }
        maxOffsetValue += sectionInset.bottom;
        
        UICollectionViewLayoutAttributes *footerAttr = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        
        if (isRoundView) {
            if (!isCalculateFooterView) {
                maxOffsetValue += footerSpace;
            }
        }
        footerAttr.frame = CGRectMake(0, _contentHeight+maxOffsetValue, contentWidth, footerHeight);
        [self.footerAttributes addObject:footerAttr];
        
        CGFloat currentSectionHeight = maxOffsetValue + footerHeight;
        
        [_heightOfSections addObject:@(currentSectionHeight)];
        
        _contentHeight += currentSectionHeight;
        if (footerHeight == 0) {
            _contentHeight -= footerSpace;
        }
        if (isRoundView) {
            CGRect sectionFrame = CGRectNull;
            sectionFrame = CGRectUnion(headerAttr.frame, footerAttr.frame);
            if (CGRectIsNull(sectionFrame)) {
                continue;
            }
            // 有头分区无脚分区
            if (isCalculateHeaderView && !isCalculateFooterView){
                sectionFrame.size.height -= footerHeight;
            }
            // 无头分区有脚分区
            if (!isCalculateHeaderView && isCalculateFooterView){
                sectionFrame.size.height -= headerHeight;
                sectionFrame.origin.y += headerHeight;
            }
            // 无头分区无脚分区
            if (!isCalculateHeaderView && !isCalculateFooterView){
                sectionFrame.origin.y += headerHeight;
                sectionFrame.size.height -= headerHeight+footerHeight;
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
            if ([delegate respondsToSelector:@selector(collectionView:layout:configModelForSectionAtIndex:)]) {
                attr.roundModel = [delegate collectionView:self.collectionView layout:self configModelForSectionAtIndex:section];
            }
            [self.decorationViewAttrs addObject:attr];
            
        }
    }
}
- (CGSize)collectionViewContentSize {
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    CGFloat width = CGRectGetWidth(self.collectionView.bounds) - contentInset.left - contentInset.right;
    CGFloat height = MAX(CGRectGetHeight(self.collectionView.bounds), _contentHeight+contentInset.top+contentInset.bottom);
    return CGSizeMake(width, height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray<UICollectionViewLayoutAttributes *> *attrsArr = [NSMutableArray array];
    [self.attrsArr enumerateObjectsUsingBlock:^(NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributeOfSection, NSUInteger idx, BOOL *stop) {
        [layoutAttributeOfSection enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
            if (CGRectIntersectsRect(rect, attribute.frame)) {
                [attrsArr addObject:attribute];
            }
        }];
    }];
    [self.headerAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
        if (attribute.frame.size.height && CGRectIntersectsRect(rect, attribute.frame)) {
            [attrsArr addObject:attribute];
        }
    }];
    [self.footerAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
        if (attribute.frame.size.height && CGRectIntersectsRect(rect, attribute.frame)) {
            [attrsArr addObject:attribute];
        }
    }];
    
    // Header view hover.
    for (UICollectionViewLayoutAttributes *attriture in attrsArr) {
        if (![attriture.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) continue;
        NSInteger section = attriture.indexPath.section;
        BOOL sectionHeadersPinTVisibleBounds = NO;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:layout:sectionHeadersPinAtSection:)]) {
            sectionHeadersPinTVisibleBounds = [self.dataSource collectionView:self.collectionView layout:self sectionHeadersPinAtSection:section];
        }
        CGFloat sectionHeaderViewHoveringTopEdging = 0;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:layout:sectionHeadersPinTopSpaceAtSection:)]) {
            sectionHeaderViewHoveringTopEdging = [self.dataSource collectionView:self.collectionView layout:self sectionHeadersPinTopSpaceAtSection:section];
        }
        UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:section];
        if (sectionHeadersPinTVisibleBounds) {
            NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            UICollectionViewLayoutAttributes *itemAttribute = [self layoutAttributesForItemAtIndexPath:firstIndexPath];
            CGRect frame = attriture.frame;
            frame.origin.y = MIN(MAX(self.collectionView.contentOffset.y + sectionHeaderViewHoveringTopEdging, CGRectGetMinY(itemAttribute.frame)-CGRectGetHeight(attriture.frame)-sectionInset.top),
                                 CGRectGetMinY(itemAttribute.frame)+[_heightOfSections[section] floatValue]);
            attriture.frame = frame;
            attriture.zIndex = (NSIntegerMax/2)+section;
        }
    }
    
    // Header view hover.
    if (self.sectionFootersPinTVisibleBounds) {
        for (UICollectionViewLayoutAttributes *attriture in attrsArr) {
            if (![attriture.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]) continue;
            NSInteger section = attriture.indexPath.section;
            UIEdgeInsets contentInsetOfSection = [self gx_insetForSectionAtIndex:section];
            NSIndexPath *firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
            UICollectionViewLayoutAttributes *itemAttribute = [self layoutAttributesForItemAtIndexPath:firstIndexPath];
            CGFloat headerHeight = CGRectGetHeight(attriture.frame);
            CGRect frame = attriture.frame;
            frame.origin.y = MIN(
                                 MAX(self.collectionView.contentOffset.y, CGRectGetMinY(itemAttribute.frame)-headerHeight-contentInsetOfSection.top),
                                 CGRectGetMinY(itemAttribute.frame)+[_heightOfSections[section] floatValue]
                                 );
            attriture.frame = frame;
            attriture.zIndex = (NSIntegerMax/2)+section;
        }
    }
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        if (CGRectIntersectsRect(rect, attr.frame)){
            [attrsArr addObject:attr];
        }
    }
    return attrsArr;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
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

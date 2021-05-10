//
//  CGXPageCollectionWaterLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionWaterLayout.h"
#import "CGXPageCollectionFlowLayoutUtils.h"
#import "CGXPageCollectionRoundLayoutAttributes.h"
#import "CGXPageCollectionRoundReusableView.h"
@interface CGXPageCollectionWaterLayout ()

@property (nonatomic, strong) NSMutableArray<NSMutableArray<UICollectionViewLayoutAttributes *> *> *itemLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *headerLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *footerLayoutAttributes;
/// Per section heights.
@property (nonatomic, strong) NSMutableArray<NSNumber *> *heightOfSections;
/// UICollectionView content height.
@property (nonatomic, assign) CGFloat contentHeight;

@property (nonatomic, assign) CGFloat totalHeight;
@end

@implementation CGXPageCollectionWaterLayout

- (void)initializeData
{
    [super initializeData];
    self.isCalculateOpenIrregularCell = YES;
    
}
- (void)prepareLayout {
    [super prepareLayout];
    
    NSAssert(self.dataSource != nil, @"CGXPageCollectionWaterLayout.dataSource cann't be nil.");
    if (self.collectionView.isDecelerating || self.collectionView.isDragging) {
        return;
    }
    
    _contentHeight = 0.0;
    _itemLayoutAttributes = [NSMutableArray array];
    _headerLayoutAttributes = [NSMutableArray array];
    _footerLayoutAttributes = [NSMutableArray array];
    _heightOfSections = [NSMutableArray array];
    
    UICollectionView *collectionView = self.collectionView;
    NSInteger const numberOfSections = collectionView.numberOfSections;
    UIEdgeInsets const contentInset = collectionView.contentInset;
    CGFloat const contentWidth = collectionView.bounds.size.width - contentInset.left - contentInset.right;
    
    self.totalHeight = contentInset.top;
    
    for (NSInteger section=0; section < numberOfSections; section++) {
        NSInteger const columnOfSection = [self.dataSource collectionView:collectionView layout:self numberOfColumnInSection:section];
        NSAssert(columnOfSection > 0, @"[CGXPageCollectionWaterLayout collectionView:layout:numberOfColumnInSection:] must be greater than 0.");
        UIEdgeInsets const contentInsetOfSection = [self gx_insetForSectionAtIndex:section];
        CGFloat const minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:section];
        CGFloat const minimumInteritemSpacing = [self gx_minimumInteritemSpacingForSectionAtIndex:section];
        CGFloat const contentWidthOfSection = contentWidth - contentInsetOfSection.left - contentInsetOfSection.right;
        CGFloat itemWidth = (contentWidthOfSection-(columnOfSection-1)*minimumInteritemSpacing) / columnOfSection;
        NSInteger const numberOfItems = [collectionView numberOfItemsInSection:section];
        
        // Per section header
        CGFloat headerHeight = 0.0;
        headerHeight = [self gx_referenceSizeForHeaderInSection:section].height;
        UICollectionViewLayoutAttributes *headerLayoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        headerLayoutAttribute.frame = CGRectMake(0.0, _contentHeight, contentWidth, headerHeight);
        [_headerLayoutAttributes addObject:headerLayoutAttribute];
        
        // The current section's offset for per column.
        CGFloat offsetOfColumns[columnOfSection];
        for (NSInteger i=0; i<columnOfSection; i++) {
            offsetOfColumns[i] = headerHeight + contentInsetOfSection.top;
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
            // Find minimum offset and fill to it.
            NSInteger currentColumn = 0;
            for (NSInteger i=1; i<columnOfSection; i++) {
                if (offsetOfColumns[currentColumn] > offsetOfColumns[i]) {
                    currentColumn = i;
                }
            }
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            if (isParity) {
                if (self.dataSource && [self.dataSource respondsToSelector:@selector(collectionView:layout:IsParityAItemAtIndexPath:)]) {
                    currentColumn = [self.dataSource collectionView:collectionView layout:self IsParityAItemAtIndexPath:indexPath];
                }
            }
            CGFloat x = contentInsetOfSection.left + itemWidth*currentColumn + minimumInteritemSpacing*currentColumn;
            CGFloat y = offsetOfColumns[currentColumn] + (item>=columnOfSection ? minimumLineSpacing : 0.0);
            
            UICollectionViewLayoutAttributes *layoutAttbiture = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            CGFloat itemHeight = [self.dataSource collectionView:collectionView layout:self itemWidth:itemWidth heightForItemAtIndexPath:indexPath].height;
            
            layoutAttbiture.frame = CGRectMake(x, y+_contentHeight, itemWidth, itemHeight);
            
            [layoutAttributeOfSection addObject:layoutAttbiture];
            // Update y offset in current column
            offsetOfColumns[currentColumn] = (y + itemHeight);
        }
        [_itemLayoutAttributes addObject:layoutAttributeOfSection];
        
        // Get current section height from offset record.
        CGFloat maxOffsetValue = offsetOfColumns[0];
        for (int i=1; i<columnOfSection; i++) {
            if (offsetOfColumns[i] > maxOffsetValue) {
                maxOffsetValue = offsetOfColumns[i];
            }
        }
        maxOffsetValue += contentInsetOfSection.bottom;
        
        // Per section footer
        CGFloat footerHeader = 0.0;
        footerHeader = [self gx_referenceSizeForFooterInSection:section].height;
        UICollectionViewLayoutAttributes *footerLayoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        footerLayoutAttribute.frame = CGRectMake(0.0, _contentHeight+maxOffsetValue, contentWidth, footerHeader);
        [_footerLayoutAttributes addObject:footerLayoutAttribute];
        
        /**
         Update UICollectionView content height.
         Section height contain from the top of the headerView to the bottom of the footerView.
         */
        CGFloat currentSectionHeight = maxOffsetValue + footerHeader;
        [_heightOfSections addObject:@(currentSectionHeight)];
        
        _contentHeight += currentSectionHeight;
    }
    
    [self initializeRoundView];
}

- (CGSize)collectionViewContentSize {
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    CGFloat width = CGRectGetWidth(self.collectionView.bounds) - contentInset.left - contentInset.right;
    CGFloat height = MAX(CGRectGetHeight(self.collectionView.bounds), _contentHeight);
    return CGSizeMake(width, height);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray<UICollectionViewLayoutAttributes *> *result = [NSMutableArray array];
    [_itemLayoutAttributes enumerateObjectsUsingBlock:^(NSMutableArray<UICollectionViewLayoutAttributes *> *layoutAttributeOfSection, NSUInteger idx, BOOL *stop) {
        [layoutAttributeOfSection enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
            if (CGRectIntersectsRect(rect, attribute.frame)) {
                [result addObject:attribute];
            }
        }];
    }];
    [_headerLayoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
        if (attribute.frame.size.height && CGRectIntersectsRect(rect, attribute.frame)) {
            [result addObject:attribute];
        }
    }];
    [_footerLayoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL *stop) {
        if (attribute.frame.size.height && CGRectIntersectsRect(rect, attribute.frame)) {
            [result addObject:attribute];
        }
    }];
    
    
    // Header view hover.
        for (UICollectionViewLayoutAttributes *attriture in result) {
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
        for (UICollectionViewLayoutAttributes *attriture in result) {
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
        [result addObject:attr];
    }
    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_itemLayoutAttributes.count == 0) {
        return nil;
    }
    return _itemLayoutAttributes[indexPath.section][indexPath.item];;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        if (_headerLayoutAttributes.count == 0) {
            return nil;
        }
        return _headerLayoutAttributes[indexPath.item];
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        if (_footerLayoutAttributes.count == 0) {
            return nil;
        }
        return _footerLayoutAttributes[indexPath.item];
    }
    return nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
@end

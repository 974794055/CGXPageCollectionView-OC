//
//  CGXPageCollectionTagsFlowLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionTagsFlowLayout.h"

@interface CGXPageCollectionTagsFlowLayout ()
@property (assign, nonatomic) CGSize newBoundsSize;
@property (nonatomic, strong) NSMutableDictionary *cachedOrigin;
@end

@implementation CGXPageCollectionTagsFlowLayout (Tagsattributes)


- (CGXPageCollectionTagsHorizontalAlignment)gx_itemsHorizontalAlignmentForSectionAtIndex:(NSInteger)section {
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:itemsHorizontalAlignmentInSection:)]) {
        id<CGXPageCollectionTagsFlowLayoutDelegate> delegate = (id<CGXPageCollectionTagsFlowLayoutDelegate>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self itemsHorizontalAlignmentInSection:section];
    } else {
        return self.itemsHorizontalAlignment;
    }
}

- (CGXPageCollectionTagsVerticalAlignment)gx_itemsVerticalAlignmentForSectionAtIndex:(NSInteger)section {
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:itemsVerticalAlignmentInSection:)]) {
        id<CGXPageCollectionTagsFlowLayoutDelegate> delegate = (id<CGXPageCollectionTagsFlowLayoutDelegate>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self itemsVerticalAlignmentInSection:section];
    } else {
        return self.itemsVerticalAlignment;
    }
}

- (CGXPageCollectionTagsDirection)gx_itemsDirectionForSectionAtIndex:(NSInteger)section {
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:itemsDirectionInSection:)]) {
        id<CGXPageCollectionTagsFlowLayoutDelegate> delegate = (id<CGXPageCollectionTagsFlowLayoutDelegate>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self itemsDirectionInSection:section];
    } else {
        return self.itemsDirection;
    }
}

@end

@implementation CGXPageCollectionTagsFlowLayout (Tagsalignment)

- (void)gx_cacheTheItemOrigin:(CGPoint)origin forIndexPath:(NSIndexPath *)indexPath {
    self.cachedOrigin[indexPath] = @(origin);
}

- (NSValue *)gx_cachedItemOriginAtIndexPath:(NSIndexPath *)indexPath {
    return self.cachedOrigin[indexPath];
}

- (void)gx_calculateAndCacheOriginForItemAttributesArray:(NSArray<UICollectionViewLayoutAttributes *> *)array {
    NSInteger section = [array firstObject].indexPath.section;

    //******************** layout infos ********************//
    CGXPageCollectionTagsHorizontalAlignment horizontalAlignment = [self gx_itemsHorizontalAlignmentForSectionAtIndex:section];
    CGXPageCollectionTagsVerticalAlignment verticalAlignment = [self gx_itemsVerticalAlignmentForSectionAtIndex:section];
    CGXPageCollectionTagsDirection direction = [self gx_itemsDirectionForSectionAtIndex:section];
    BOOL isR2L = direction == CGXPageCollectionTagsDirectionRTL;
    UIEdgeInsets sectionInsets = [self gx_insetForSectionAtIndex:section];
    CGFloat minimumInteritemSpacing = [self gx_minimumInteritemSpacingForSectionAtIndex:section];
    UIEdgeInsets contentInsets = self.collectionView.contentInset;
    CGFloat collectionViewWidth = CGRectGetWidth(self.collectionView.frame);
    
    //******************** temp origin.y ********************//
    CGFloat tempOriginY = 0.f;
    NSArray *frameValues = [array valueForKeyPath:@"frame"];
    if (verticalAlignment == CGXPageCollectionTagsVerticalAlignmentTop) {
        tempOriginY = CGFLOAT_MAX;
        for (NSValue *frameValue in frameValues) {
            tempOriginY = MIN(tempOriginY, CGRectGetMinY(frameValue.CGRectValue));
        }
    } else if (verticalAlignment == CGXPageCollectionTagsVerticalAlignmentBottom) {
        tempOriginY = CGFLOAT_MIN;
        for (NSValue *frameValue in frameValues) {
            tempOriginY = MAX(tempOriginY, CGRectGetMaxY(frameValue.CGRectValue));
        }
    }
    //******************** start and space ********************//
    NSMutableArray *widthArray = [[NSMutableArray alloc] init];
    for (UICollectionViewLayoutAttributes *attr in array) {
        [widthArray addObject:@(CGRectGetWidth(attr.frame))];
    }
    CGFloat totalWidth = [[widthArray valueForKeyPath:@"@sum.self"] floatValue];
    CGFloat start = 0.f, space = 0.f;
    NSInteger totalCount = array.count;
    switch (horizontalAlignment) {
        case CGXPageCollectionTagsHorizontalAlignmentLeft: {
            start = isR2L ? (collectionViewWidth - totalWidth - contentInsets.left - contentInsets.right - sectionInsets.left - minimumInteritemSpacing * (totalCount - 1)) : sectionInsets.left;
            space = minimumInteritemSpacing;
        } break;

        case CGXPageCollectionTagsHorizontalAlignmentCenter: {
            CGFloat rest = (collectionViewWidth - totalWidth - contentInsets.left - contentInsets.right - sectionInsets.left - sectionInsets.right - minimumInteritemSpacing * (totalCount - 1)) / 2.f;
            start = isR2L ? sectionInsets.right + rest : sectionInsets.left + rest;
            space = minimumInteritemSpacing;
        } break;

        case CGXPageCollectionTagsHorizontalAlignmentRight: {
            start = isR2L ? sectionInsets.right : (collectionViewWidth - totalWidth - contentInsets.left - contentInsets.right - sectionInsets.right - minimumInteritemSpacing * (totalCount - 1));
            space = minimumInteritemSpacing;
        } break;

        case CGXPageCollectionTagsHorizontalAlignmentFlow: {
            BOOL isEnd = array.lastObject.indexPath.item == [self.collectionView numberOfItemsInSection:section] - 1;
            start = isR2L ? sectionInsets.right : sectionInsets.left;
            space = isEnd ? minimumInteritemSpacing : (collectionViewWidth - totalWidth - contentInsets.left - contentInsets.right - sectionInsets.left - sectionInsets.right) / (totalCount - 1);
        } break;

        default:
            break;
    }
    
    //******************** calculate and cache origin ********************//
    CGFloat lastMaxX = 0.f;
    for (int i = 0; i < widthArray.count; i++) {
        UICollectionViewLayoutAttributes *attr = array[i];
        CGFloat width = [widthArray[i] floatValue];
        CGFloat originX = 0.f;
        if (isR2L) {
            originX = i == 0 ? collectionViewWidth - start - contentInsets.right - contentInsets.left - width : lastMaxX - space - width;
            lastMaxX = originX;
        } else {
            originX = i == 0 ? start : lastMaxX + space;
            lastMaxX = originX + width;
        }
        CGFloat originY;
        if (verticalAlignment == CGXPageCollectionTagsVerticalAlignmentBottom) {
            originY = tempOriginY - CGRectGetHeight(attr.frame);
        } else if (verticalAlignment == CGXPageCollectionTagsVerticalAlignmentCenter) {
            originY = attr.frame.origin.y;
        } else {
            originY = tempOriginY;
        }
        [self gx_cacheTheItemOrigin:CGPointMake(originX, originY) forIndexPath:attr.indexPath];
    }
}

@end

@implementation CGXPageCollectionTagsFlowLayout
- (void)initializeData
{
    [super initializeData];
}
- (void)prepareLayout {
    [super prepareLayout];
    self.cachedOrigin = @{}.mutableCopy;
}
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (CGSizeEqualToSize(self.newBoundsSize, newBounds.size)) {
        return NO;
    }
    self.newBoundsSize = newBounds.size;
    return YES;
}
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * updatedAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    NSArray *originalAttributes = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attributes in originalAttributes) {
        if (!attributes.representedElementKind || attributes.representedElementCategory == UICollectionElementCategoryCell) {
            NSUInteger index = [updatedAttributes indexOfObject:attributes];
            updatedAttributes[index] = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
        }
    }
    return updatedAttributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    // This is likely occurring because the flow layout subclass CGXPageCollectionTagsFlowLayout is modifying attributes returned by UICollectionViewFlowLayout without copying them
    UICollectionViewLayoutAttributes *currentAttributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];

    // 获取缓存的当前 indexPath 的 item origin value
    NSValue *originValue = [self gx_cachedItemOriginAtIndexPath:indexPath];
    CGPoint origin;
    // 如果没有缓存的 item origin value，则计算并缓存然后获取
    if (!originValue) {
        // 判断是否为一行中的首个
        BOOL isLineStart = [self gx_isLineStartAtIndexPath:indexPath];
        // 如果是一行中的首个
        if (isLineStart) {
            // 获取当前行的所有 UICollectionViewLayoutAttributes
            NSArray *line = [self gx_lineAttributesArrayWithStartAttributes:currentAttributes];
            if (line.count) {
                // 计算并缓存当前行的所有 UICollectionViewLayoutAttributes origin
                [self gx_calculateAndCacheOriginForItemAttributesArray:line];
            }
        }
        // 获取位于当前 indexPath 的 item origin
        originValue = [self gx_cachedItemOriginAtIndexPath:indexPath];
    }
    if (originValue) {
        // 设置缓存的当前 indexPath 的 item origin
        origin = [originValue CGPointValue];
        CGRect currentFrame = currentAttributes.frame;
        // 获取当前 indexPath 的 item origin 后修改当前 layoutAttributes.frame.origin
        currentFrame.origin = origin;
        currentAttributes.frame = currentFrame;
    }
    return currentAttributes;
}

- (BOOL)gx_isLineStartAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return YES;
    }
    NSIndexPath *currentIndexPath = indexPath;
    NSIndexPath *previousIndexPath = indexPath.item == 0 ? nil : [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];

    UICollectionViewLayoutAttributes *currentAttributes = [super layoutAttributesForItemAtIndexPath:currentIndexPath];
    UICollectionViewLayoutAttributes *previousAttributes = previousIndexPath ? [super layoutAttributesForItemAtIndexPath:previousIndexPath] : nil;
    CGRect currentFrame = currentAttributes.frame;
    CGRect previousFrame = previousAttributes ? previousAttributes.frame : CGRectZero;

    UIEdgeInsets insets = [self gx_insetForSectionAtIndex:currentIndexPath.section];
    CGRect currentLineFrame = CGRectMake(insets.left, currentFrame.origin.y, CGRectGetWidth(self.collectionView.frame), currentFrame.size.height);
    CGRect previousLineFrame = CGRectMake(insets.left, previousFrame.origin.y, CGRectGetWidth(self.collectionView.frame), previousFrame.size.height);

    return !CGRectIntersectsRect(currentLineFrame, previousLineFrame);
}

- (NSArray *)gx_lineAttributesArrayWithStartAttributes:(UICollectionViewLayoutAttributes *)startAttributes {
    NSMutableArray *lineAttributesArray = [[NSMutableArray alloc] init];
    [lineAttributesArray addObject:startAttributes];
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:startAttributes.indexPath.section];
    UIEdgeInsets insets = [self gx_insetForSectionAtIndex:startAttributes.indexPath.section];
    NSInteger index = startAttributes.indexPath.item;
    BOOL isLineEnd = index == itemCount - 1;
    while (!isLineEnd) {
        index++;
        if (index == itemCount)
            break;
        NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:index inSection:startAttributes.indexPath.section];
        UICollectionViewLayoutAttributes *nextAttributes = [super layoutAttributesForItemAtIndexPath:nextIndexPath];
        CGRect nextLineFrame = CGRectMake(insets.left, nextAttributes.frame.origin.y, CGRectGetWidth(self.collectionView.frame), nextAttributes.frame.size.height);
        isLineEnd = !CGRectIntersectsRect(startAttributes.frame, nextLineFrame);
        if (isLineEnd)
            break;
        [lineAttributesArray addObject:nextAttributes];
    }
    return lineAttributesArray;
}

@end

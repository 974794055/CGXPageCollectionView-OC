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
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{

    return YES;

}

#pragma mark - 不规则Cell计算方案

/// 不规则cell找出top最高位置
/// @param section section description
/// @param numberOfItems numberOfItems description
/// @param defaultFrame defaultFrame description
- (CGRect)calculateIrregularitiesCellByMinTopFrameWithLayout:(UICollectionViewFlowLayout *)layout section:(NSInteger)section numberOfItems:(NSInteger)numberOfItems defaultFrame:(CGRect)defaultFrame{
    CGRect firstFrame = defaultFrame;
    if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //竖向
        CGFloat minY = CGRectGetMinY(firstFrame);
        for (NSInteger i = 0; i <= numberOfItems - 1; i ++ ) {
            UICollectionViewLayoutAttributes *attr = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            minY = MIN(minY, CGRectGetMinY(attr.frame));
        }
        CGRect rect = firstFrame;
        firstFrame = CGRectMake(rect.origin.x, minY, rect.size.width, rect.size.height);
    }else{
        //横向
        CGFloat minX = CGRectGetMinX(firstFrame);
        for (NSInteger i = 0; i <= numberOfItems - 1; i ++ ) {
            UICollectionViewLayoutAttributes *attr = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            minX = MIN(minX, CGRectGetMinX(attr.frame));
        }
        CGRect rect = firstFrame;
        firstFrame = CGRectMake(minX ,rect.origin.y, rect.size.width, rect.size.height);
    }
    return firstFrame;
}

/// 不规则cell找出bootom最低位置
/// @param layout layout description
/// @param section section description
/// @param numberOfItems numberOfItems description
/// @param defaultFrame defaultFrame description
- (CGRect)calculateIrregularitiesCellByMaxBottomFrameWithLayout:(UICollectionViewFlowLayout *)layout section:(NSInteger)section numberOfItems:(NSInteger)numberOfItems defaultFrame:(CGRect)defaultFrame{
    CGRect lastFrame = defaultFrame;
    if (layout.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //竖向
        CGFloat maxY = CGRectGetMinY(lastFrame);
        NSInteger index = numberOfItems-1;
        for (NSInteger i = 0; i <= numberOfItems - 1; i ++ ) {
            UICollectionViewLayoutAttributes *attr = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            if (maxY < MAX(maxY, CGRectGetMaxY(attr.frame))) {
                maxY = MAX(maxY, CGRectGetMaxY(attr.frame));
                index = i;
            }
        }
        lastFrame = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]].frame;
    }else{
        //横向
        CGFloat maxX = CGRectGetMaxX(lastFrame);
        NSInteger index = numberOfItems-1;
        for (NSInteger i = 0; i <= numberOfItems - 1; i ++ ) {
            UICollectionViewLayoutAttributes *attr = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:section]];
            if (maxX < MAX(maxX, CGRectGetMaxX(attr.frame))) {
                maxX = MAX(maxX, CGRectGetMaxX(attr.frame));
                index = i;
            }
        }
        lastFrame = [layout layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:section]].frame;
    }
    return lastFrame;
}

@end

@implementation CGXPageCollectionBaseLayout (BaseLayoutAttributes)

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
@end


@implementation CGXPageCollectionBaseLayout (BaseLayoutline)

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


@implementation CGXPageCollectionBaseLayout (BaseRound)

/// 计算默认不包含headerview和footerview的背景大小
/// @param frame frame description
/// @param sectionInset sectionInset description
- (CGRect)calculateDefaultFrameWithSectionFrame:(CGRect)frame sectionInset:(UIEdgeInsets)sectionInset
{
    CGRect sectionFrame = frame;
    sectionFrame.origin.x -= sectionInset.left;
      sectionFrame.origin.y -= sectionInset.top;
      if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
          sectionFrame.size.width += sectionInset.left + sectionInset.right;
          //减去系统adjustInset的top
          if (@available(iOS 11.0, *)) {
              sectionFrame.size.height = self.collectionView.frame.size.height - self.collectionView.adjustedContentInset.top;
          } else {
              sectionFrame.size.height = self.collectionView.frame.size.height - fabs(self.collectionView.contentOffset.y)/*适配iOS11以下*/;
          }
      }else{
          sectionFrame.size.width = self.collectionView.frame.size.width;
          sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
      }
    return sectionFrame;
}

/// 计算headerview背景大小
/// @param isCalculateHeaderView  是否计算头
/// @param section  分区
/// @param numberOfItems 第几个
/// @param isOpen 是否打开不规则运算
- (CGRect)calculateDefaultFrameWithFirstHeader:(BOOL)isCalculateHeaderView
                                      Section:(NSInteger)section
                                NumberOfItems:(NSInteger)numberOfItems
                                        IsOpen:(BOOL)isOpen
{
    BOOL isCalculateOpenIrregularCell = isOpen;
    // 第一个item
    UICollectionViewLayoutAttributes *firstAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    //headerView
    UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];

    
    CGRect firstFrame = firstAttr.frame;
    if (isCalculateHeaderView) {
        if (headerAttr &&
            (headerAttr.frame.size.width != 0|| headerAttr.frame.size.height != 0)) {
            firstFrame = headerAttr.frame;
        }else{
            CGRect rect = firstFrame;
            if (isCalculateOpenIrregularCell) {
                rect = [self calculateIrregularitiesCellByMinTopFrameWithLayout:self section:section numberOfItems:numberOfItems defaultFrame:rect];
            }
            firstFrame = self.scrollDirection == UICollectionViewScrollDirectionVertical ?
            CGRectMake(rect.origin.x, rect.origin.y, self.collectionView.bounds.size.width, rect.size.height):
            CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, self.collectionView.bounds.size.height);
        }
    }else{
        //不计算headerview的情况
        if (isCalculateOpenIrregularCell) {
            firstFrame = [self calculateIrregularitiesCellByMinTopFrameWithLayout:self section:section numberOfItems:numberOfItems defaultFrame:firstFrame];
        }
    }
    
    return firstFrame;
}
/// 计算footerview的背景大小
/// @param isCalculateFooterView  是否计算脚
/// @param section  分区
/// @param numberOfItems 第几个
/// @param isOpen 是否打开不规则运算
- (CGRect)calculateDefaultFrameWithFirstFooter:(BOOL)isCalculateFooterView
                                      Section:(NSInteger)section
                                NumberOfItems:(NSInteger)numberOfItems
                                        IsOpen:(BOOL)isOpen
{
    BOOL isCalculateOpenIrregularCell = isOpen;
    // 最后一个item
    UICollectionViewLayoutAttributes *lastAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:(numberOfItems - 1) inSection:section]];
    //footerView
    UICollectionViewLayoutAttributes *footerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    
    CGRect lastFrame = lastAttr.frame;
    if (isCalculateFooterView) {
        if (footerAttr &&
            (footerAttr.frame.size.width != 0 || footerAttr.frame.size.height != 0)) {
            lastFrame = footerAttr.frame;
        }else{
            CGRect rect = lastFrame;
            if (isCalculateOpenIrregularCell) {
                rect = [self calculateIrregularitiesCellByMaxBottomFrameWithLayout:self section:section numberOfItems:numberOfItems defaultFrame:rect];
            }
            lastFrame = self.scrollDirection == UICollectionViewScrollDirectionVertical ?
            CGRectMake(rect.origin.x, rect.origin.y, self.collectionView.bounds.size.width, rect.size.height):
            CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, self.collectionView.bounds.size.height);
        }
    }else{
        //不计算footerView的情况
        if (isCalculateOpenIrregularCell) {
            lastFrame = [self calculateIrregularitiesCellByMaxBottomFrameWithLayout:self section:section numberOfItems:numberOfItems defaultFrame:lastFrame];
        }
    }
    return lastFrame;
}


@end

@implementation CGXPageCollectionBaseLayout (BaseLayoutAlignment)


/// 将相同y位置的cell集合到一个列表中(竖向)
/// @param layoutAttributesAttrs layoutAttributesAttrs description
- (NSArray *)groupLayoutAttributesForElementsByYLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    NSMutableDictionary *allDict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (UICollectionViewLayoutAttributes *attr  in layoutAttributesAttrs) {
        
        NSMutableArray *dictArr = allDict[@(CGRectGetMidY(attr.frame))];
        if (dictArr) {
            [dictArr addObject:[attr copy]];
        }else{
            NSMutableArray *arr = [NSMutableArray arrayWithObject:[attr copy]];
            allDict[@(CGRectGetMidY(attr.frame))] = arr;
        }
    }
    return allDict.allValues;
}

/// 将相同x位置的cell集合到一个列表中(横向)
/// @param layoutAttributesAttrs layoutAttributesAttrs description
- (NSArray *)groupLayoutAttributesForElementsByXLineWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    NSMutableDictionary *allDict = [NSMutableDictionary dictionaryWithCapacity:0];
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        NSMutableArray *dictArr = allDict[@(attr.frame.origin.x)];
        if (dictArr) {
            [dictArr addObject:[attr copy]];
        }else{
            NSMutableArray *arr = [NSMutableArray arrayWithObject:[attr copy]];
            allDict[@(attr.frame.origin.x)] = arr;
        }
    }
    return allDict.allValues;
}
/// 计算AttributesAttrs左对齐
/// @param layout CGXPageCollectionGeneralFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByLeftWithWithCollectionLayout:(UICollectionViewFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    //left
    UICollectionViewLayoutAttributes *pAttr = nil;
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x + pAttr.frame.size.width + [self gx_minimumInteritemSpacingForSectionAtIndex:attr.indexPath.section];
            }else{
                frame.origin.x = [self gx_insetForSectionAtIndex:attr.indexPath.section].left;
            }
        }else{
            //横向
            if (pAttr) {
                frame.origin.y = pAttr.frame.origin.y + pAttr.frame.size.height + [self gx_minimumInteritemSpacingForSectionAtIndex:attr.indexPath.section];
            }else{
                frame.origin.y = [self gx_insetForSectionAtIndex:attr.indexPath.section].top;
            }
        }
        attr.frame = frame;
        pAttr = attr;
    }
}

/// 计算AttributesAttrs居中对齐
/// @param layout CGXPageCollectionGeneralFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByCentertWithWithCollectionLayout:(UICollectionViewFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    
    //center
    UICollectionViewLayoutAttributes *pAttr = nil;
    
    CGFloat useWidth = 0;
            NSInteger theSection = ((UICollectionViewLayoutAttributes *)layoutAttributesAttrs.firstObject).indexPath.section;
            for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
                useWidth += attr.bounds.size.width;
            }
    CGFloat firstLeft = (self.collectionView.bounds.size.width - useWidth - ([self gx_minimumInteritemSpacingForSectionAtIndex:theSection] *layoutAttributesAttrs.count))/2.0;
    
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x + pAttr.frame.size.width + [self gx_minimumInteritemSpacingForSectionAtIndex:attr.indexPath.section];
            }else{
                frame.origin.x = firstLeft;
            }
            attr.frame = frame;
            pAttr = attr;
        }else{
            //横向
            if (pAttr) {
                frame.origin.y = pAttr.frame.origin.y + pAttr.frame.size.height + [self gx_minimumInteritemSpacingForSectionAtIndex:attr.indexPath.section];
            }else{
                frame.origin.y = [self gx_insetForSectionAtIndex:attr.indexPath.section].top;
            }
        }
        attr.frame = frame;
        pAttr = attr;
    }
}


/// 计算AttributesAttrs右对齐
/// @param layout CGXPageCollectionGeneralFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByRightWithWithCollectionLayout:(UICollectionViewFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
//    right
    UICollectionViewLayoutAttributes *pAttr = nil;
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x - [self gx_minimumInteritemSpacingForSectionAtIndex:attr.indexPath.section] - frame.size.width;
            }else{
                frame.origin.x = layout.collectionView.bounds.size.width - [self gx_insetForSectionAtIndex:attr.indexPath.section].right - frame.size.width;
            }
        }else{
            
        }
        attr.frame = frame;
        pAttr = attr;
    }
}
@end


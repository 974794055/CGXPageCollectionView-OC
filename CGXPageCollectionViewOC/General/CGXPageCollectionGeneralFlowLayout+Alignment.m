//
//  CGXPageCollectionGeneralFlowLayout+Alignment.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionGeneralFlowLayout+Alignment.h"
#import "CGXPageCollectionFlowLayoutUtils.h"

@implementation CGXPageCollectionGeneralFlowLayout(Alignment)

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
/// 根据不同对齐方式进行Cell位置计算
/// @param layoutAttributesAttrs 传入需计算的AttributesAttrs集合列表
/// @param toChangeAttributesAttrsList 用来保存所有计算后的AttributesAttrs
/// @param alignmentType 对齐方式
- (NSMutableArray *)evaluatedAllCellSettingFrameWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs toChangeAttributesAttrsList:(NSMutableArray *_Nonnull *_Nonnull)toChangeAttributesAttrsList cellAlignmentType:(CGXPageCollectionGeneralFlowLayoutAlignment)alignmentType
{
    NSMutableArray *toChangeList = *toChangeAttributesAttrsList;
    [toChangeList removeAllObjects];
    for (NSArray *calculateAttributesAttrsArr in layoutAttributesAttrs) {
        switch (alignmentType) {
            case CGXPageCollectionGeneralFlowLayoutAlignmentLeft:{
                [self evaluatedCellSettingFrameByLeftWithWithCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            case CGXPageCollectionGeneralFlowLayoutAlignmentCenter:{
                [self evaluatedCellSettingFrameByCentertWithWithCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            case CGXPageCollectionGeneralFlowLayoutAlignmentRight:{
                NSArray* reversedArray = [[calculateAttributesAttrsArr reverseObjectEnumerator] allObjects];
                [self evaluatedCellSettingFrameByRightWithWithCollectionLayout:self layoutAttributesAttrs:reversedArray];
            }break;
            case CGXPageCollectionGeneralFlowLayoutAlignmentRightStart:{
                [self evaluatedCellSettingFrameByRightWithWithCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            default:
                break;
        }
        [toChangeList addObjectsFromArray:calculateAttributesAttrsArr];
    }
    return toChangeList;
}
/// 根据不同对齐方式进行Cell位置计算
/// @param layoutAttributesAttrs 传入需计算的AttributesAttrs集合列表
/// @param toChangeAttributesAttrsList 用来保存所有计算后的AttributesAttrs
/// @param alignmentArr 对齐方式
- (NSMutableArray *)evaluatedAllCellSettingFrameWithLayoutAttributesAttrs:(NSArray *)layoutAttributesAttrs toChangeAttributesAttrsList:(NSMutableArray *_Nonnull *_Nonnull)toChangeAttributesAttrsList AlignmentType:(NSArray *)alignmentArr
{
    NSMutableArray *toChangeList = *toChangeAttributesAttrsList;
    [toChangeList removeAllObjects];
    NSInteger inter = 0;
    for (NSArray *calculateAttributesAttrsArr in layoutAttributesAttrs) {
        CGXPageCollectionGeneralFlowLayoutAlignment alignment = [alignmentArr[inter] integerValue];
        switch (alignment) {
            case CGXPageCollectionGeneralFlowLayoutAlignmentLeft:{
                [self evaluatedCellSettingFrameByLeftWithWithCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            case CGXPageCollectionGeneralFlowLayoutAlignmentCenter:{
                [self evaluatedCellSettingFrameByCentertWithWithCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            case CGXPageCollectionGeneralFlowLayoutAlignmentRight:{
                NSArray* reversedArray = [[calculateAttributesAttrsArr reverseObjectEnumerator] allObjects];
                [self evaluatedCellSettingFrameByRightWithWithCollectionLayout:self layoutAttributesAttrs:reversedArray];
            }break;
            case CGXPageCollectionGeneralFlowLayoutAlignmentRightStart:{
                [self evaluatedCellSettingFrameByRightWithWithCollectionLayout:self layoutAttributesAttrs:calculateAttributesAttrsArr];
            }break;
            default:
                break;
        }
        [toChangeList addObjectsFromArray:calculateAttributesAttrsArr];
    }
    return toChangeList;
}

#pragma mark - alignment

/// 计算AttributesAttrs左对齐
/// @param layout CGXPageCollectionGeneralFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByLeftWithWithCollectionLayout:(CGXPageCollectionGeneralFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
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
                frame.origin.x = pAttr.frame.origin.x + pAttr.frame.size.width + [CGXPageCollectionFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.x = [CGXPageCollectionFlowLayoutUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].left;
            }
        }else{
            //横向
            if (pAttr) {
                frame.origin.y = pAttr.frame.origin.y + pAttr.frame.size.height + [CGXPageCollectionFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.y = [CGXPageCollectionFlowLayoutUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].top;
            }
        }
        attr.frame = frame;
        pAttr = attr;
    }
}

/// 计算AttributesAttrs居中对齐
/// @param layout CGXPageCollectionGeneralFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByCentertWithWithCollectionLayout:(CGXPageCollectionGeneralFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
    
    //center
    UICollectionViewLayoutAttributes *pAttr = nil;
    
    CGFloat useWidth = 0;
            NSInteger theSection = ((UICollectionViewLayoutAttributes *)layoutAttributesAttrs.firstObject).indexPath.section;
            for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
                useWidth += attr.bounds.size.width;
            }
    CGFloat firstLeft = (self.collectionView.bounds.size.width - useWidth - ([CGXPageCollectionFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:theSection]*layoutAttributesAttrs.count))/2.0;
    
    for (UICollectionViewLayoutAttributes *attr in layoutAttributesAttrs) {
        if (attr.representedElementKind != nil) {
            //nil when representedElementCategory is UICollectionElementCategoryCell (空的时候为cell)
            continue;
        }
        CGRect frame = attr.frame;

        if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
            //竖向
            if (pAttr) {
                frame.origin.x = pAttr.frame.origin.x + pAttr.frame.size.width + [CGXPageCollectionFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.x = firstLeft;
            }
            attr.frame = frame;
            pAttr = attr;
        }else{
            //横向
            if (pAttr) {
                frame.origin.y = pAttr.frame.origin.y + pAttr.frame.size.height + [CGXPageCollectionFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section];
            }else{
                frame.origin.y = [CGXPageCollectionFlowLayoutUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].top;
            }
        }
        attr.frame = frame;
        pAttr = attr;
    }
}


/// 计算AttributesAttrs右对齐
/// @param layout CGXPageCollectionGeneralFlowLayout
/// @param layoutAttributesAttrs 需计算的AttributesAttrs列表
- (void)evaluatedCellSettingFrameByRightWithWithCollectionLayout:(CGXPageCollectionGeneralFlowLayout *)layout layoutAttributesAttrs:(NSArray *)layoutAttributesAttrs{
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
                frame.origin.x = pAttr.frame.origin.x - [CGXPageCollectionFlowLayoutUtils evaluatedMinimumInteritemSpacingForSectionWithCollectionLayout:layout atIndex:attr.indexPath.section] - frame.size.width;
            }else{
                frame.origin.x = layout.collectionView.bounds.size.width - [CGXPageCollectionFlowLayoutUtils evaluatedSectionInsetForItemWithCollectionLayout:layout atIndex:attr.indexPath.section].right - frame.size.width;
            }
        }else{
            
        }
        attr.frame = frame;
        pAttr = attr;
    }
}

@end

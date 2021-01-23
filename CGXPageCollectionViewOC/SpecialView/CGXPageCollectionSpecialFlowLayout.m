//
//  CGXPageCollectionSpecialFlowLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionSpecialFlowLayout.h"
@interface CGXPageCollectionSpecialFlowLayout ()

@property (nonatomic, strong,readwrite) NSMutableArray *attrsArr;

@end
@implementation CGXPageCollectionSpecialFlowLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.zoomSpace = 0.5;
    }
    return self;
}
-(void)prepareLayout {
    [super prepareLayout];
    NSMutableArray *attributesArr = [NSMutableArray array];
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (int i = 0; i < sectionCount; i++) {
        NSIndexPath *indexP = [NSIndexPath indexPathWithIndex:i];
        UICollectionViewLayoutAttributes *attr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:indexP];
        [attributesArr addObject:attr];
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < itemCount; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
            [attributesArr addObject:attrs];
        }
        UICollectionViewLayoutAttributes *attr1 = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:indexP];
        [attributesArr addObject:attr1];
    }
    self.attrsArr = [NSMutableArray arrayWithArray:attributesArr];
}
/// contentSize
-(CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
}
- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArr;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    UIEdgeInsets insets = [self gx_insetForSectionAtIndex:indexPath.section];
    CGFloat spaceH = [self gx_minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    CGFloat spaceV = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
    
    CGFloat headHeight = [self gx_referenceSizeForHeaderInSection:indexPath.section].height;
    CGFloat  footHeight = [self gx_referenceSizeForHeaderInSection:indexPath.section].height;
    
    CGFloat hWidth = CGRectGetWidth(self.collectionView.frame)-insets.left-insets.right;
    CGFloat vHeight = CGRectGetHeight(self.collectionView.frame)-insets.top-insets.bottom-headHeight-footHeight;
    CGXPageCollectionSpecialType type = [self.delegate collectionView:self.collectionView TypeForInSection:indexPath.section];
    
    switch (type) {
        case CGXPageCollectionSpecialTypeDefault:
        {
            NSInteger rowInter = [self.collectionView numberOfItemsInSection:indexPath.section];
            CGFloat itemWith = hWidth-spaceH;
            CGFloat itemHeight = (vHeight-spaceV-(rowInter-1)*spaceV)/rowInter;
            layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top + (itemHeight +spaceV)*indexPath.row, itemWith, itemHeight);
        }
            break;
            
        case CGXPageCollectionSpecialTypeDefaultH:
        {
            NSInteger rowInter = [self.collectionView numberOfItemsInSection:indexPath.section];
            CGFloat itemWith = (hWidth-(rowInter-1)*spaceH)/rowInter;;
            CGFloat itemHeight = vHeight-spaceV;
            layoutAttributes.frame = CGRectMake(insets.left+(itemWith +spaceH)*indexPath.row, headHeight+insets.top, itemWith, itemHeight);
        }
            break;
        case CGXPageCollectionSpecialTypeLR21:
        {
            CGFloat itemWith = hWidth-spaceH;
            CGFloat itemHeight = (vHeight-spaceV) / 2;
            switch (indexPath.item) {
                case 0:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top, itemWith*self.zoomSpace, itemHeight);
                    break;
                case 1:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top+itemHeight+spaceV, itemWith*self.zoomSpace, itemHeight);
                    break;
                case 2:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*self.zoomSpace+spaceH,headHeight+insets.top, itemWith*(1-self.zoomSpace), itemHeight*2+spaceV);
                    break;
                default:
                    break;
            }
            layoutAttributes.hidden = indexPath.row > 2 ? YES:NO;
        }
            break;
        case CGXPageCollectionSpecialTypeLR12:
        {
            CGFloat itemWith = hWidth-spaceH;
            CGFloat itemHeight = (vHeight-spaceV) / 2;
            switch (indexPath.item) {
                case 0:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top, itemWith*self.zoomSpace, itemHeight*2+spaceV);
                    break;
                case 1:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*self.zoomSpace+spaceH, headHeight+insets.top, itemWith*(1-self.zoomSpace), itemHeight);
                    break;
                case 2:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*self.zoomSpace+spaceH,headHeight+insets.top+itemHeight+spaceV, itemWith*(1-self.zoomSpace), itemHeight);
                    break;
                default:
                    break;
            }
            layoutAttributes.hidden = indexPath.row > 2 ? YES:NO;
        }
            break;
        case CGXPageCollectionSpecialTypeTB21:
        {
            CGFloat itemWith = (hWidth-spaceH) / 2;
            CGFloat itemHeight = vHeight-spaceV;
            switch (indexPath.item) {
                case 0:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top, itemWith, itemHeight*self.zoomSpace);
                    break;
                case 1:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith+spaceH, headHeight+insets.top, itemWith, itemHeight*self.zoomSpace);
                    break;
                case 2:
                    layoutAttributes.frame = CGRectMake(insets.left,headHeight+insets.top+itemHeight*self.zoomSpace+spaceV, itemWith*2+spaceH, itemHeight*(1-self.zoomSpace));
                    break;
                default:
                    break;
            }
            layoutAttributes.hidden = indexPath.row > 2 ? YES:NO;
        }
            break;
        case CGXPageCollectionSpecialTypeTB12:
        {
            CGFloat itemWith = (hWidth-spaceH) / 2;
            CGFloat itemHeight = vHeight-spaceV;
            switch (indexPath.item) {
                case 0:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top, itemWith*2+spaceH, itemHeight*self.zoomSpace);
                    break;
                case 1:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top+itemHeight*self.zoomSpace+spaceV, itemWith, itemHeight*(1-self.zoomSpace));
                    break;
                case 2:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith+spaceH,headHeight+insets.top+itemHeight*self.zoomSpace+spaceV, itemWith, itemHeight*(1-self.zoomSpace));
                    break;
                default:
                    break;
            }
            layoutAttributes.hidden = indexPath.row > 2 ? YES:NO;
        }
            break;
        case CGXPageCollectionSpecialTypeL1TB12:
        {
            CGFloat itemWith = hWidth-spaceH;
            CGFloat itemHeight = (vHeight-spaceV) / 2;
            switch (indexPath.item) {
                case 0:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top, itemWith*self.zoomSpace, itemHeight*2+spaceV);
                    break;
                case 1:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*self.zoomSpace+spaceH, headHeight+insets.top, itemWith*(1-self.zoomSpace), itemHeight);
                    break;
                case 2:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*self.zoomSpace+spaceH,headHeight+insets.top+itemHeight+spaceV, (itemWith*(1-self.zoomSpace)-spaceH)/2, itemHeight);
                    break;
                case 3:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*self.zoomSpace+spaceH+(itemWith*(1-self.zoomSpace)-spaceH)/2+spaceH,headHeight+insets.top+itemHeight+spaceV, (itemWith*(1-self.zoomSpace)-spaceH)/2, itemHeight);
                    break;
                default:
                    break;
            }
            layoutAttributes.hidden = indexPath.row > 3 ? YES:NO;
        }
            break;
        case CGXPageCollectionSpecialTypeL1TB21:
        {
            CGFloat itemWith = hWidth-spaceH;
            CGFloat itemHeight = (vHeight-spaceV) / 2;
            switch (indexPath.item) {
                case 0:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top, itemWith*self.zoomSpace, itemHeight*2+spaceV);
                    break;
                case 1:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*self.zoomSpace+spaceH,headHeight+insets.top, (itemWith*(1-self.zoomSpace)-spaceH)/2, itemHeight);
                    break;
                case 2:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*self.zoomSpace+spaceH+(itemWith*(1-self.zoomSpace)-spaceH)/2+spaceH,headHeight+insets.top, (itemWith*(1-self.zoomSpace)-spaceH)/2, itemHeight);
                    break;
                case 3:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*self.zoomSpace+spaceH, headHeight+insets.top+itemHeight+spaceV, itemWith*(1-self.zoomSpace), itemHeight);
                    break;
                default:
                    break;
            }
            layoutAttributes.hidden = indexPath.row > 3 ? YES:NO;
        }
            break;
        case CGXPageCollectionSpecialTypeR1TB12:
        {
            CGFloat itemWith = hWidth-spaceH;
            CGFloat itemHeight = (vHeight-spaceV) / 2;
            switch (indexPath.item) {
                case 0:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top, itemWith*(1-self.zoomSpace), itemHeight);
                    break;
                case 1:
                    layoutAttributes.frame = CGRectMake(insets.left,headHeight+insets.top+itemHeight+spaceV, (itemWith*(1-self.zoomSpace)-spaceH)/2, itemHeight);
                    break;
                case 2:
                    layoutAttributes.frame = CGRectMake(insets.left+(itemWith*(1-self.zoomSpace)-spaceH)/2+spaceH,headHeight+insets.top+itemHeight+spaceV, (itemWith*(1-self.zoomSpace)-spaceH)/2, itemHeight);
                    break;
                case 3:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*(1-self.zoomSpace)+spaceH, headHeight+insets.top, itemWith*self.zoomSpace, itemHeight*2+spaceV);
                    break;
                default:
                    break;
            }
            layoutAttributes.hidden = indexPath.row > 3 ? YES:NO;
        }
            break;
        case CGXPageCollectionSpecialTypeR1TB21:
        {
            CGFloat itemWith = hWidth-spaceH;
            CGFloat itemHeight = (vHeight-spaceV) / 2;
            switch (indexPath.item) {
                case 0:
                    layoutAttributes.frame = CGRectMake(insets.left,headHeight+insets.top, (itemWith*(1-self.zoomSpace)-spaceH)/2, itemHeight);
                    break;
                case 1:
                    layoutAttributes.frame = CGRectMake(insets.left+(itemWith*(1-self.zoomSpace)-spaceH)/2+spaceH,headHeight+insets.top, (itemWith*(1-self.zoomSpace)-spaceH)/2, itemHeight);
                    break;
                case 2:
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top+itemHeight+spaceV, itemWith*(1-self.zoomSpace), itemHeight);
                    
                    break;
                case 3:
                    layoutAttributes.frame = CGRectMake(insets.left+itemWith*(1-self.zoomSpace)+spaceH, headHeight+insets.top, itemWith*self.zoomSpace, itemHeight*2+spaceV);
                    break;
                default:
                    break;
            }
            layoutAttributes.hidden = indexPath.row > 3 ? YES:NO;
        }
            break;
            
        case CGXPageCollectionSpecialTypeBig:
        {
            CGFloat itemWith = (hWidth-3*spaceH)/4.0;
            CGFloat itemHeight = itemWith;
            
            if (indexPath.item < 4) {
                layoutAttributes.frame = CGRectMake(insets.left+(itemWith+spaceH)*indexPath.item, headHeight+insets.top, itemWith, itemHeight);
            } else if (indexPath.item >= 9){
                layoutAttributes.frame = CGRectMake(insets.left+(itemWith+spaceH)*(indexPath.item-9), headHeight+insets.top + (itemHeight+spaceV)*3 , itemWith, itemHeight);
            } else{
                if (indexPath.item == 4){
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top + (itemHeight+spaceV) , itemWith, itemHeight);
                }
                if (indexPath.item == 7){
                    layoutAttributes.frame = CGRectMake(insets.left, headHeight+insets.top + (itemHeight+spaceV)*2 , itemWith, itemHeight);
                }
                if (indexPath.item == 6){
                    layoutAttributes.frame = CGRectMake(insets.left+(itemWith+spaceH)*3, headHeight+insets.top + (itemHeight+spaceV) , itemWith, itemHeight);
                }
                if (indexPath.item == 8){
                    layoutAttributes.frame = CGRectMake(insets.left+(itemWith+spaceH)*3, headHeight+insets.top + (itemHeight+spaceV)*2 , itemWith, itemHeight);
                }
                if (indexPath.item == 5){
                    layoutAttributes.frame = CGRectMake(insets.left+(itemWith+spaceH), headHeight+insets.top + (itemHeight+spaceV) , itemWith*2+spaceH, itemHeight*2+spaceV);
                }
            }
            layoutAttributes.hidden = indexPath.row > 12 ? YES:NO;
        }
            break;;
        case CGXPageCollectionSpecialTypeCustom:
        {
            UICollectionViewLayoutAttributes *newlayoutAttributes = [self.delegate collectionView:self.collectionView Attributes:layoutAttributes AtIndex:indexPath.item];
            layoutAttributes.frame = CGRectMake(newlayoutAttributes.frame.origin.x,newlayoutAttributes.frame.origin.y, newlayoutAttributes.frame.size.width, newlayoutAttributes.frame.size.height);
        }
            break;
        default:
            break;
    }

    return layoutAttributes;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGFloat height = 0;
    if (elementKind == UICollectionElementKindSectionHeader) {
        height = [self gx_referenceSizeForHeaderInSection:indexPath.section].height;
        layoutAttrs.frame = CGRectMake(0, 0, CGRectGetWidth(self.collectionView.frame), height);
    } else {
        height = [self gx_referenceSizeForFooterInSection:indexPath.section].height;
        layoutAttrs.frame = CGRectMake(0, CGRectGetHeight(self.collectionView.frame)-height, CGRectGetWidth(self.collectionView.frame), height);
    }
    return layoutAttrs;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (CGFloat)gx_minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    if (self.collectionView.delegate && [self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateFlowLayout> delegate = (id<UICollectionViewDelegateFlowLayout>) self.collectionView.delegate;
        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
    } else {
        return self.minimumInteritemSpacing;
    }
}
- (CGFloat)gx_minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
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

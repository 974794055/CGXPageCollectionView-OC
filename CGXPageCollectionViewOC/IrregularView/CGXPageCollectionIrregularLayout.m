//
//  CGXPageCollectionIrregularLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionIrregularLayout.h"
@interface CGXPageCollectionIrregularLayout ()

@property (nonatomic, assign) CGFloat totalHeight;
@property (nonatomic, strong) NSMutableArray *attrsArr;

@end
@implementation CGXPageCollectionIrregularLayout

-(void)prepareLayout {
    [super prepareLayout];
    self.totalHeight = 0;
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
    return CGSizeMake(self.collectionView.bounds.size.width, self.totalHeight);
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    CGFloat height = 0;
    if (elementKind == UICollectionElementKindSectionHeader) {
        height = [self gx_referenceSizeForHeaderInSection:indexPath.section].height;
    } else {
        height = [self gx_referenceSizeForFooterInSection:indexPath.section].height;
    }
    layoutAttrs.frame = CGRectMake(0, self.totalHeight, self.collectionView.bounds.size.width, height);
    self.totalHeight += height;
    return layoutAttrs;
}
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArr;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *layoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGXPageCollectionIrregularLayoutShowType type = CGXPageCollectionIrregularLayoutDefault;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:layout:layoutAttributesTypeArrayForInSection:)]) {
         type = [self.delegate collectionView:self.collectionView layout:self layoutAttributesTypeArrayForInSection:indexPath.section];
    }
    switch (type) {
        case CGXPageCollectionIrregularLayoutDefault:
            [self layoutAttributesForDefaultLayout:layoutAttributes indexPath:indexPath];
            break;
        case CGXPageCollectionIrregularLayoutLeftRight1T2:
            [self CGXPageCollectionIrregularLayoutLeftRight1T2Layout:layoutAttributes indexPath:indexPath];
            break;
        case CGXPageCollectionIrregularLayoutLeftRight2T1:
            [self CGXPageCollectionIrregularLayoutLeftRight2T1Layout:layoutAttributes indexPath:indexPath];
            break;
        case CGXPageCollectionIrregularLayoutTopBottom2T1:
            [self CGXPageCollectionIrregularLayoutTopBottom2T1Layout:layoutAttributes indexPath:indexPath];
            break;
        case CGXPageCollectionIrregularLayoutTopBottom1T2:
            [self CGXPageCollectionIrregularLayoutTopBottom1T2Layout:layoutAttributes indexPath:indexPath];
            break;
        case CGXPageCollectionIrregularLayoutFirstBigTN:
            [self CGXPageCollectionIrregularLayoutFirstBigTN:layoutAttributes indexPath:indexPath];
            break;

        default:
            break;
    }
    return layoutAttributes;
}
/// 正常垂直排布 
- (void)layoutAttributesForDefaultLayout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *)indexPath  {
    
    UIEdgeInsets insets = [self gx_insetForSectionAtIndex:indexPath.section];
    CGFloat y = self.totalHeight + insets.top;
    CGFloat spaceH = [self gx_minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    CGFloat spaceW = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
    
    NSInteger rowInter = [self numberOfItemsInSection:indexPath.section];
    
    long row = indexPath.item % rowInter;
    CGFloat width = (self.collectionView.frame.size.width-spaceW*(rowInter+1)) / rowInter;
    CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:width heightForItemAtIndexPath:indexPath];
    
    if (indexPath.item>0) {
        itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:width heightForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.section]];
    }
    
    layoutAttributes.frame = CGRectMake(spaceW*(row+1)+width*row, y, width, itemHeight);
    
    if (row == (rowInter-1)) {
        self.totalHeight += itemHeight+spaceH;
    }
    if (indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
        self.totalHeight += insets.top;
    }
}
//左1 右二排列
- (void)CGXPageCollectionIrregularLayoutLeftRight1T2Layout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath:(NSIndexPath *)indexPath
{
    CGFloat spaceH = [self gx_minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    CGFloat spaceW = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
     UIEdgeInsets inset= [self gx_insetForSectionAtIndex:indexPath.section];
    CGFloat width = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW) / 2;
    CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:width heightForItemAtIndexPath:indexPath];
    CGFloat y = self.totalHeight;
    if (indexPath.item <3) {
        itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:width TopHeightForItemAtIndexPath:indexPath];
        switch (indexPath.item) {
            case 0:
                layoutAttributes.frame = CGRectMake(spaceH, y+spaceH, width, itemHeight);
                break;
            case 1:
                layoutAttributes.frame = CGRectMake(spaceH*2+width, y+spaceH, width, (itemHeight-spaceH)/2.0);;
                self.totalHeight += (itemHeight-spaceH)/2.0+spaceH*2;
                break;
            case 2:
                layoutAttributes.frame = CGRectMake(spaceH*2+width, y, width, (itemHeight-spaceH)/2.0);
                self.totalHeight += (itemHeight-spaceH)/2.0+spaceH;
                break;
            default:
                break;
        }
    }else{
        NSInteger rowInter = [self numberOfItemsInSection:indexPath.section];
        width = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW*(rowInter-1)) / rowInter;
        long row = (indexPath.item -3) % rowInter;
        layoutAttributes.frame = CGRectMake(row * width+spaceW*(row+1), y, width, itemHeight);
        if (row == (rowInter-1) || indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
            self.totalHeight += itemHeight+spaceH;
        }
    }
}
//左2 右1排列
- (void)CGXPageCollectionIrregularLayoutLeftRight2T1Layout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *) indexPath
{
    CGFloat spaceH = [self gx_minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    CGFloat spaceW = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
    UIEdgeInsets inset= [self gx_insetForSectionAtIndex:indexPath.section];
    CGFloat width = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW) / 2;
    CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:width heightForItemAtIndexPath:indexPath];
    CGFloat y = self.totalHeight;
    if (indexPath.item <3) {
        itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:width TopHeightForItemAtIndexPath:indexPath];
        switch (indexPath.item) {
            case 0:
                layoutAttributes.frame = CGRectMake(spaceW, y+spaceH, width, (itemHeight-spaceH)/2.0);
                self.totalHeight += (itemHeight-spaceH)/2.0+spaceH;
                break;
            case 1:
                layoutAttributes.frame = CGRectMake(spaceW, y+spaceH, width, (itemHeight-spaceH)/2.0);
                self.totalHeight -= (itemHeight-spaceH)/2.0+spaceH;
                break;
            case 2:
                layoutAttributes.frame = CGRectMake(width+spaceH*2,y+spaceH, width, itemHeight);
                self.totalHeight +=itemHeight+2*spaceH;
                break;
            default:
                break;
        }
    }else{
        NSInteger rowInter = [self numberOfItemsInSection:indexPath.section];
        width = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW*(rowInter-1)) / rowInter;
        long row = (indexPath.item -3) % rowInter;
        layoutAttributes.frame = CGRectMake(row * width+spaceW*(row+1), y, width, itemHeight);
        if (row == (rowInter-1) || indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
            self.totalHeight += itemHeight+spaceH;
        }
    }
}
//上2 下1排列
- (void)CGXPageCollectionIrregularLayoutTopBottom2T1Layout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *) indexPath
{
    CGFloat spaceH = [self gx_minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    CGFloat spaceW = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
    UIEdgeInsets inset= [self gx_insetForSectionAtIndex:indexPath.section];
       CGFloat width = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW) / 2;
    CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:width heightForItemAtIndexPath:indexPath];
    CGFloat y = self.totalHeight;
    if (indexPath.item <3) {
        switch (indexPath.item) {
            case 0:
                layoutAttributes.frame = CGRectMake(spaceW, y+spaceH, width, itemHeight);
                break;
            case 1:
                layoutAttributes.frame = CGRectMake(spaceW*2+width, y+spaceH, width,itemHeight);
                self.totalHeight += itemHeight;
                break;
            case 2:
                layoutAttributes.frame = CGRectMake(spaceW, y+2*spaceH, self.collectionView.frame.size.width-spaceW*2, itemHeight);
                self.totalHeight += itemHeight + 3*spaceH;
                break;
            default:
                break;
        }
    } else{
        NSInteger rowInter = [self numberOfItemsInSection:indexPath.section];
        width = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW*(rowInter-1)) / rowInter;
        long row = (indexPath.item -3) % rowInter;
        layoutAttributes.frame = CGRectMake(row * width+spaceW*(row+1), y, width, itemHeight);
        if (row == (rowInter-1) || indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
            self.totalHeight += itemHeight+spaceH;
        }
    }
}
/// 服务
- (void)CGXPageCollectionIrregularLayoutTopBottom1T2Layout:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath:(NSIndexPath *)indexPath
{
    CGFloat spaceH = [self gx_minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    CGFloat spaceW = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
    UIEdgeInsets inset= [self gx_insetForSectionAtIndex:indexPath.section];
    CGFloat width = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW) / 2;
    CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:width heightForItemAtIndexPath:indexPath];
    CGFloat y = self.totalHeight;
    if (indexPath.item <3) {
            switch (indexPath.item) {
                case 0:
                    layoutAttributes.frame = CGRectMake(spaceW, y+spaceH, self.collectionView.frame.size.width-spaceW*2, itemHeight);
                    self.totalHeight += itemHeight;
                    break;
                case 1:
                    layoutAttributes.frame = CGRectMake(spaceW, y+spaceH*2, width, itemHeight);
                    break;
                case 2:
                    layoutAttributes.frame = CGRectMake(spaceW*2+width, y+spaceH*2, width, itemHeight);
                     self.totalHeight +=itemHeight + 3*spaceH;
                    break;
                default:
                    break;
            }
         
    } else {
        NSInteger rowInter = [self numberOfItemsInSection:indexPath.section];
        width = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW*(rowInter-1)) / rowInter;
        long row = (indexPath.item -3) % rowInter;
        layoutAttributes.frame = CGRectMake(row * width+spaceW*(row+1), y, width, itemHeight);
        if (row == (rowInter-1) || indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
            self.totalHeight += itemHeight+spaceH;
        }
    }
}


- (void)CGXPageCollectionIrregularLayoutFirstBigTN:(UICollectionViewLayoutAttributes *)layoutAttributes indexPath: (NSIndexPath *) indexPath
{
   
    CGFloat spaceH = [self gx_minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    CGFloat spaceW = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
         UIEdgeInsets inset= [self gx_insetForSectionAtIndex:indexPath.section];
    NSInteger sectionTop = [self numberOfItemsInSectionTop:indexPath.section];
    NSInteger rowTop = [self numberOfItemsInRowTop:indexPath.section];
    
    CGFloat itemWidth = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW*rowTop) / (rowTop+1);
    CGFloat itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:itemWidth heightForItemAtIndexPath:indexPath];
    CGFloat y = self.totalHeight+inset.top;
    CGFloat x = inset.left;
    
    if (indexPath.item<1+sectionTop*rowTop) {
        itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:itemWidth TopHeightForItemAtIndexPath:indexPath];
        NSInteger inter = indexPath.item;
        BOOL rowsss = [self judgeStr:rowTop with:indexPath.item];
        if (inter==0) {
            x = spaceW;
        } else{
            long row = (indexPath.item-1)% rowTop;
            x = itemWidth*(row+1)+spaceW + (row+1)*spaceH;
            itemHeight = (itemHeight - (sectionTop-1)*spaceH) / sectionTop;
        }
        if (rowsss) {
            self.totalHeight +=itemHeight+spaceH;
        }
        layoutAttributes.frame = CGRectMake(x, y, itemWidth, itemHeight);
    }else{
        itemHeight = [self.delegate collectionView:self.collectionView layout:self itemWidth:itemWidth BottomHeightForItemAtIndexPath:indexPath];
        
        NSInteger rowInter = [self numberOfItemsInSection:indexPath.section];
        itemWidth = (self.collectionView.frame.size.width-inset.left-inset.right-spaceW*(rowInter-1)) / rowInter;
        long row = (indexPath.item -sectionTop*rowTop-1) % rowInter;
        layoutAttributes.frame = CGRectMake(row * itemWidth+spaceW*(row+1), y, itemWidth, itemHeight);
        if (row == (rowInter-1) || indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
            self.totalHeight += itemHeight+spaceH;
        }
        if (indexPath.item == [self.collectionView numberOfItemsInSection:indexPath.section] - 1) {
            self.totalHeight += spaceH;
        }
    }
}



- (NSInteger)numberOfItemsInSection:(NSInteger)section
{
    NSInteger inter = 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionIrregularView:numberOfItemsInSectionBottom:)]) {
        inter = [self.delegate collectionIrregularView:self.collectionView numberOfItemsInSectionBottom:section];
        if (inter==0) {
            inter = 1;
        }
    }
    return inter;
}

- (NSInteger)numberOfItemsInSectionTop:(NSInteger)section
{
    NSInteger inter = 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionIrregularView:numberOfItemsInSectionTop:)]) {
        inter = [self.delegate collectionIrregularView:self.collectionView numberOfItemsInSectionTop:section];
        if (inter==0) {
            inter = 1;
        }
    }
    return inter;
}
- (NSInteger)numberOfItemsInRowTop:(NSInteger)section
{
    NSInteger inter = 1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionIrregularView:numberOfItemsInRowTop:)]) {
        inter = [self.delegate collectionIrregularView:self.collectionView numberOfItemsInRowTop:section];
        if (inter==0) {
            inter = 1;
        }
    }
    return inter;
}

//ios oc 判断输入的数是否是另一个的整数倍
-(BOOL)judgeStr:(NSInteger)str1Int with:(NSInteger)str2Int
{
    double str2Double = [[NSString stringWithFormat:@"%ld",str2Int] doubleValue];
    if (str2Int==0) {
        return NO;
    }
    if (str2Double/str1Int-str2Int/str1Int  > 0) {
        return NO;
    }
    return YES;
}

@end

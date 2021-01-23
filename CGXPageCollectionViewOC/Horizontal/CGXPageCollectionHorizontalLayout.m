//
//  CGXPageCollectionHorizontalLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionHorizontalLayout.h"

NSString *const CGXPageCollectionHorizontalLayoutSectionBackground = @"CGXPageCollectionHorizontalLayoutSectionBackground";

@interface CGXPageCollectionHorizontalLayout ()

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewArr;

@end
@implementation CGXPageCollectionHorizontalLayout

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)decorationViewArr
{
    if (!_decorationViewArr) {
        _decorationViewArr = [NSMutableArray array];
    }
    return _decorationViewArr;
}

- (void)initializeData
{
    [super initializeData];
    self.isRoundEnabled = NO;
    [self registerClass:[CGXPageCollectionRoundReusableView class] forDecorationViewOfKind:CGXPageCollectionHorizontalLayoutSectionBackground];
}
//1
- (void)prepareLayout  //invalidateLayout
{
    [super prepareLayout];
    
    [self.decorationViewArr removeAllObjects];
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    id delegate = self.collectionView.delegate;
    if (![delegate respondsToSelector:@selector(collectionView:layout:configModelForSectionAtIndex:)]) {
        return;
    }
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems <= 0) {
            continue;
        }
        UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems - 1 inSection:section]];
        if (!firstItem || !lastItem) {
            continue;
        }
        UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:section];
        CGRect sectionFrame = CGRectUnion(firstItem.frame, lastItem.frame);
        sectionFrame.origin.x -= sectionInset.left;
        sectionFrame.origin.y -= sectionInset.top;
        sectionFrame.size.width += sectionInset.left + sectionInset.right;
        sectionFrame.size.height = sectionFrame.size.height+sectionInset.top+sectionInset.bottom;
        
        // 2、定义
        CGXPageCollectionRoundLayoutAttributes *attr = [CGXPageCollectionRoundLayoutAttributes layoutAttributesForDecorationViewOfKind:CGXPageCollectionHorizontalLayoutSectionBackground withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        attr.frame = sectionFrame;
        attr.zIndex = -1;
        id <CGXPageCollectionUpdateRoundDelegate> delegate  = (id <CGXPageCollectionUpdateRoundDelegate>)self.collectionView.delegate;
        if ([delegate respondsToSelector:@selector(collectionView:layout:configModelForSectionAtIndex:)]) {
            attr.myConfigModel = [delegate collectionView:self.collectionView layout:self configModelForSectionAtIndex:section];
        }
        [self.decorationViewArr addObject:attr];
    }
    
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:CGXPageCollectionHorizontalLayoutSectionBackground]) {
        return [self.decorationViewArr objectAtIndex:indexPath.section];
    }
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
}

//2
- (CGSize)collectionViewContentSize
{
    if (!self.collectionView.superview) {
        return CGSizeZero;
    }
    NSUInteger  numOfSection=[self.collectionView numberOfSections];
    CGSize size = [super collectionViewContentSize];
    CGFloat width=0;
    for (NSInteger i=0;i<numOfSection ;i++) {
        width+=  [self sectionWidthIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
        UIEdgeInsets userCustomSectionInset = [self userCustomSectionInset:i];
        UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:i];
        if (i==0) {
            width+=userCustomSectionInset.left+sectionInset.left;
        }
        width+=userCustomSectionInset.right;
    }
    size.width= ceil(width);
    return size;
}
//3  返回目标区域对应的Attributes 数组
- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    NSLog(@"___________%@",NSStringFromCGRect(rect));
    //获取对应rect中的展示indexpath ，生成attribu，笔者这里的需求不会存在大量数据，就偷懒了。
    NSMutableArray *attributeArray = [NSMutableArray new];
    
    for (int section=0; section<[self.collectionView numberOfSections]; section++) {
        UICollectionViewLayoutAttributes* attHeader = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        [attributeArray addObject:attHeader];
    }
    
    for (int section=0; section<self.collectionView.numberOfSections; section++) {
        for (NSInteger item=0; item<[self.collectionView numberOfItemsInSection:section]; item++) {
            UICollectionViewLayoutAttributes *att= [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:item inSection:section]];
            [attributeArray addObject:att];
        }
    }
    
    for (int section=0; section<[self.collectionView numberOfSections]; section++) {
        UICollectionViewLayoutAttributes* attHeader = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter atIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        [attributeArray addObject:attHeader];
    }
    
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewArr) {
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attributeArray addObject:attr];
        }
    }
    return attributeArray;
}

//生成对应的item Attributes
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath].copy;
    NSInteger totoalColumn=[self numColumnOfIndexPath:indexPath];
    if (totoalColumn==0) {
        totoalColumn = 1;
    }
    NSInteger line=(indexPath.item)/(CGFloat)totoalColumn;
    NSInteger column= indexPath.item%totoalColumn;  //
    CGRect tempFrame=attributes.frame;
    
    
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:indexPath];
    CGFloat minimumInteritemSpacing = [self gx_minimumInteritemSpacingForSectionAtIndex:indexPath.section];
    CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
    CGFloat headerHeight = [self gx_referenceSizeForHeaderInSection:indexPath.section].height;

    UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:indexPath.section];
    UIEdgeInsets userCustomSectionInset = [self userCustomSectionInset:indexPath.section];
    
    tempFrame.origin.x=sectionInset.left+column*(itemSize.width+minimumInteritemSpacing) +[self sectionItemStarX:indexPath.section];
    
    tempFrame.origin.y=line*itemSize.height  + headerHeight + minimumLineSpacing *(line+1);;
    
    tempFrame.origin.y += userCustomSectionInset.top;
    
    attributes.frame=tempFrame;
    return attributes;
}
//生成对应的SupplementaryView Attributes
- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *orgAttributes=  [super layoutAttributesForSupplementaryViewOfKind:elementKind atIndexPath:indexPath];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CGFloat headerHeight = [self gx_referenceSizeForHeaderInSection:indexPath.section].height;
        CGRect tempFrame=orgAttributes.frame;
        NSInteger section=orgAttributes.indexPath.section;
        CGFloat perx= [self sectionItemStarX:section];
        tempFrame.origin.x=perx;
        tempFrame.origin.y=0;
        tempFrame.size= CGSizeMake(tempFrame.size.width, headerHeight);
        orgAttributes.frame=tempFrame;
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        CGFloat footerHeight = [self gx_referenceSizeForFooterInSection:indexPath.section].height;
        CGRect tempFrame=orgAttributes.frame;
        NSInteger section=orgAttributes.indexPath.section;
        CGFloat perx= [self sectionItemStarX:section];
        tempFrame.origin.x=perx;
        tempFrame.origin.y=self.collectionView.frame.size.height-footerHeight;
        tempFrame.size=CGSizeMake(tempFrame.size.width, footerHeight);;
        orgAttributes.frame=tempFrame;
    }
    return orgAttributes;
}




#pragma mrak tool method
//每个section宽
-(CGFloat)sectionWidthIndexPath:(NSIndexPath *)indexPath
{
    
    CGSize itemSize = [self gx_sizeForItemAtIndexPath:indexPath];
    UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:indexPath.section];
    CGFloat minimumLineSpacing = [self gx_minimumLineSpacingForSectionAtIndex:indexPath.section];
    NSInteger column=  [self numColumnOfIndexPath:indexPath];
    CGFloat re=sectionInset.left+sectionInset.right+column*(itemSize.width+minimumLineSpacing);
    return re;
}
//根据视图的高度，计算section的 行列数
-(NSInteger)numColumnOfIndexPath:(NSIndexPath *)indexPath
{
    NSInteger numOfItmes =  1;
    if (self.delegate && [self.delegate respondsToSelector:@selector(collectionHorizontalView:layout:numberOfSection:)]) {
        numOfItmes = [self.delegate collectionHorizontalView:self.collectionView layout:self numberOfSection:indexPath.section];
    }
    return numOfItmes;
}
-(CGFloat)sectionItemStarX:(NSUInteger)section
{
    UIEdgeInsets sectionInset = [self gx_insetForSectionAtIndex:section];
    CGFloat x=sectionInset.left;//计算每个head.x
    UIEdgeInsets userCustomSectionInset = [self userCustomSectionInset:section];
    x+=userCustomSectionInset.left*(section+1);
    for (NSInteger i=1;i<=section ;i++) {
        x+=  [self sectionWidthIndexPath:[NSIndexPath indexPathForRow:0 inSection:i]];
    }
    return x;
}

-(UIEdgeInsets)userCustomSectionInset:(NSUInteger)section
{
    UIEdgeInsets userCustomSectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    id delegate = self.collectionView.delegate;
    if ([delegate respondsToSelector:@selector(collectionView:layout:borderEdgeInsertsForSectionAtIndex:)]) {
        //检测是否实现了该方法，进行赋值
        userCustomSectionInset = [delegate collectionView:self.collectionView layout:self borderEdgeInsertsForSectionAtIndex:section];
    }
    return userCustomSectionInset;
}
/**
 * 当collectionView的显示范围发生改变的时候，是否需要重新刷新布局
 * 一旦重新刷新布局，就会重新调用下面的方法：
 * 1.prepareLayout
 * 2.layoutAttributesForElementsInRect:方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end

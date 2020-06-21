//
//  CGXPageCollectionIrregularView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionIrregularView.h"
#import "CGXPageCollectionIrregularLayout.h"

@interface CGXPageCollectionIrregularView ()<CGXPageCollectionIrregularLayoutDelegate>


@end

@implementation CGXPageCollectionIrregularView
- (void)initializeData
{
    [super initializeData];
}

- (void)initializeViews
{
    [super initializeViews];
}
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
     CGXPageCollectionIrregularLayout *layout = [[CGXPageCollectionIrregularLayout alloc]init];
           layout.delegate = self;
    return layout;
}
- (void)updateDataArray:(NSMutableArray<CGXPageCollectionBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page
{
    [super updateDataArray:array IsDownRefresh:isDownRefresh Page:page];
    
    if (array.count>0) {
        NSAssert([[array firstObject] isKindOfClass:[CGXPageCollectionIrreguarSectionModel class]], @"数据源类型不对，必须是CGXPageCollectionIrreguarSectionModel");
    }
    [self.collectionView reloadData];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionIrregularLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionIrreguarSectionModel *sectionModel = (CGXPageCollectionIrreguarSectionModel *)self.dataArray[indexPath.section];
        CGXPageCollectionIrreguarRowModel *item =  (CGXPageCollectionIrreguarRowModel *)sectionModel.rowArray[indexPath.row];
    return item.cellHeight;
}
/// Return per item's height
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionIrregularLayout*)layout itemWidth:(CGFloat)width TopHeightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionIrreguarSectionModel *sectionModel = (CGXPageCollectionIrreguarSectionModel *)self.dataArray[indexPath.section];
    return sectionModel.topHeight;
}
/// Return per item's height
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionIrregularLayout*)layout itemWidth:(CGFloat)width BottomHeightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionIrreguarSectionModel *sectionModel = (CGXPageCollectionIrreguarSectionModel *)self.dataArray[indexPath.section];
    return sectionModel.bottomHeight;
}
- (CGXPageCollectionIrregularLayoutShowType)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionIrregularLayout *)layout layoutAttributesTypeArrayForInSection:(NSInteger)section
{
    CGXPageCollectionIrreguarSectionModel *sectionModel = (CGXPageCollectionIrreguarSectionModel *)self.dataArray[section];
    return sectionModel.showType;
}
- (NSInteger)collectionIrregularView:(UICollectionView *)collectionView numberOfItemsInSectionBottom:(NSInteger)section
{
    CGXPageCollectionIrreguarSectionModel *sectionModel = (CGXPageCollectionIrreguarSectionModel *)self.dataArray[section];
    return sectionModel.bottomRow;
}
- (NSInteger)collectionIrregularView:(UICollectionView *)collectionView numberOfItemsInSectionTop:(NSInteger)section
{
    CGXPageCollectionIrreguarSectionModel *sectionModel = (CGXPageCollectionIrreguarSectionModel *)self.dataArray[section];
    return sectionModel.topSection;
}
- (NSInteger)collectionIrregularView:(UICollectionView *)collectionView numberOfItemsInRowTop:(NSInteger)section
{
    CGXPageCollectionIrreguarSectionModel *sectionModel = (CGXPageCollectionIrreguarSectionModel *)self.dataArray[section];
    return sectionModel.topRow;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

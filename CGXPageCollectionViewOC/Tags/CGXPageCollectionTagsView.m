//
//  CGXPageCollectionTagsView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionTagsView.h"
static NSString *const kCellReuseIdentifier = @"kCellReuseIdentifier";
static NSString *const kHeaderReuseIdentifier = @"kHeaderReuseIdentifier";
static NSString *const kFooterReuseIdentifier = @"kFooterReuseIdentifier";
@interface CGXPageCollectionTagsView ()<CGXPageCollectionUpdateRoundDelegate>


@end

@implementation CGXPageCollectionTagsView

- (void)initializeData
{
    [super initializeData];
    self.isRoundEnabled = YES;
}

- (void)initializeViews
{
    [super initializeViews];
}

- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXPageCollectionTagsFlowLayout *layout = [[CGXPageCollectionTagsFlowLayout alloc] init];
    layout.itemsHorizontalAlignment = CGXPageCollectionTagsHorizontalAlignmentLeft;
    layout.itemsVerticalAlignment = CGXPageCollectionTagsVerticalAlignmentCenter;
    layout.itemsDirection = CGXPageCollectionTagsDirectionLTR;
    return layout;
}
- (void)updateDataArray:(NSMutableArray<CGXPageCollectionBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page
{
    [super updateDataArray:array IsDownRefresh:isDownRefresh Page:page];
    
    if (array.count>0) {
        NSAssert([[array firstObject] isKindOfClass:[CGXPageCollectionTagsSectionModel class]], @"数据源类型不对，必须是CGXPageCollectionTagsSectionModel");
    }
    [self.collectionView reloadData];
}

- (CGXPageCollectionTagsHorizontalAlignment)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionTagsFlowLayout *)layout itemsHorizontalAlignmentInSection:(NSInteger)section
{
     CGXPageCollectionTagsSectionModel *sectionModel = (CGXPageCollectionTagsSectionModel *)self.dataArray[section];
    return sectionModel.horizontalAlignment;
}

- (CGXPageCollectionTagsVerticalAlignment)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionTagsFlowLayout *)layout itemsVerticalAlignmentInSection:(NSInteger)section {
     CGXPageCollectionTagsSectionModel *sectionModel = (CGXPageCollectionTagsSectionModel *)self.dataArray[section];
    return sectionModel.verticalAlignment;
}

- (CGXPageCollectionTagsDirection)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionTagsFlowLayout *)layout itemsDirectionInSection:(NSInteger)section {
     CGXPageCollectionTagsSectionModel *sectionModel = (CGXPageCollectionTagsSectionModel *)self.dataArray[section];
    return sectionModel.direction;
}

- (UICollectionReusableView *)refreshHeaderSection:(NSInteger)section Header:(UICollectionReusableView *)headerView
{
    [super refreshHeaderSection:section Header:headerView];
    CGXPageCollectionTagsSectionModel *sectionModel = (CGXPageCollectionTagsSectionModel *)self.dataArray[section];
        headerView.backgroundColor = sectionModel.headerModel.headerBgColor;
    return headerView;
}
- (UICollectionReusableView *)refreshFooterSection:(NSInteger)section Footer:(UICollectionReusableView *)footerView
{
    [super refreshFooterSection:section Footer:footerView];
    CGXPageCollectionTagsSectionModel *sectionModel = (CGXPageCollectionTagsSectionModel *)self.dataArray[section];
        footerView.backgroundColor = sectionModel.footerModel.footerBgColor;;
    return footerView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionTagsSectionModel *sectionModel = (CGXPageCollectionTagsSectionModel *)self.dataArray[indexPath.section];
    CGXPageCollectionTagsRowModel *item =  (CGXPageCollectionTagsRowModel *)sectionModel.rowArray[indexPath.row];
    
    UIEdgeInsets  insets  = sectionModel.insets;
    CGFloat minimumInteritemSpacing = sectionModel.minimumInteritemSpacing;
    CGFloat space = insets.left+insets.right;
    float cellWidth = (collectionView.bounds.size.width-space-(sectionModel.row -1)*minimumInteritemSpacing)/sectionModel.row;
    NSAssert(sectionModel.row > 0, @"每行至少一个item");
    CGSize sizeFor = CGSizeMake(floor(cellWidth), item.cellHeight);;
    
    if (self.titleDelegate && [self.titleDelegate respondsToSelector:@selector(tagsView:sizeForItemHeightAtIndexPath:ItemSize:)]) {
        return [self.titleDelegate tagsView:self sizeForItemHeightAtIndexPath:indexPath ItemSize:sizeFor];
    }
    return CGSizeMake(sizeFor.width, sizeFor.height);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

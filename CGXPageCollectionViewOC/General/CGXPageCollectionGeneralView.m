//
//  CGXPageCollectionGeneralView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionGeneralView.h"
#import "CGXPageCollectionGeneralFlowLayout.h"

@interface CGXPageCollectionGeneralView ()<CGXPageCollectionUpdateRoundDelegate,CGXPageCollectionGeneralFlowLayoutDataDelegate>


@end

@implementation CGXPageCollectionGeneralView

- (void)initializeData
{
    [super initializeData];
}

- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = YES;
}
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXPageCollectionGeneralFlowLayout *layout = [[CGXPageCollectionGeneralFlowLayout alloc] init];
    if (@available(iOS 9.0, *)) {
        layout.sectionFootersPinToVisibleBounds =NO;
        layout.sectionHeadersPinToVisibleBounds =NO;
    } else {
        // Fallback on earlier versions
    }
    layout.dataSource = self;
    return layout;
}

- (void)refreshSectionModel:(CGXPageCollectionBaseSectionModel *)baseSectionModel
{
    [super refreshSectionModel:baseSectionModel];
    if (baseSectionModel) {
        NSAssert([baseSectionModel isKindOfClass:[CGXPageCollectionGeneralSectionModel class]], @"数据源类型不对，必须是CGXPageCollectionGeneralSectionModel");
        
        if (baseSectionModel.rowArray.count>0) {
            NSAssert([[baseSectionModel.rowArray firstObject] isKindOfClass:[CGXPageCollectionGeneralRowModel class]], @"数据源类型不对，必须是CGXPageCollectionGeneralRowModel");
        }
    }
}
- (void)refreshHeaderSection:(NSInteger)section Header:(UICollectionReusableView *)headerView
{
    [super refreshHeaderSection:section Header:headerView];
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    if (sectionModel.isRoundWithHeaderView) {
        headerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }else{
        headerView.backgroundColor = sectionModel.headerModel.headerBgColor;
    }
}
- (void)refreshFooterSection:(NSInteger)section Footer:(UICollectionReusableView *)footerView
{
    [super refreshFooterSection:section Footer:footerView];
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    if (sectionModel.isRoundWithFooterView) {
        footerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    }else{
        footerView.backgroundColor = sectionModel.footerModel.footerBgColor;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[indexPath.section];
    UIEdgeInsets  insets  = sectionModel.insets;
    UIEdgeInsets borderEdgeInserts = sectionModel.borderEdgeInserts;
    CGFloat minimumInteritemSpacing = sectionModel.minimumInteritemSpacing;
    CGFloat space = insets.left+insets.right + borderEdgeInserts.left + borderEdgeInserts.right ;
    float cellWidth = (collectionView.bounds.size.width-space-(sectionModel.row -1)*minimumInteritemSpacing)/sectionModel.row;
    NSAssert(sectionModel.row > 0, @"每行至少一个item");
    CGSize sizeFor = CGSizeMake(floor(cellWidth), sectionModel.cellHeight);
    if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(gx_PageCollectionGeneralView:sizeForItemHeightAtIndexPath:ItemSize:)]) {
        sizeFor = [self.dataDelegate gx_PageCollectionGeneralView:self sizeForItemHeightAtIndexPath:indexPath ItemSize:sizeFor];
        sectionModel.cellHeight = sizeFor.height;
    }
    return sizeFor;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    UIEdgeInsets insets = sectionModel.insets;
    UIEdgeInsets borderEdgeInserts = sectionModel.borderEdgeInserts;
    return UIEdgeInsetsMake(insets.top+borderEdgeInserts.top, insets.left+borderEdgeInserts.left, insets.bottom+borderEdgeInserts.bottom, insets.right+borderEdgeInserts.right);
}
#pragma mark - CGXPageCollectionGeneralFlowLayoutRoundDelegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout borderEdgeInsertsForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    return sectionModel.borderEdgeInserts;
}
- (CGXPageCollectionRoundModel *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout configModelForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    return sectionModel.roundModel;;
}

/// 根据section设置是否包含headerview（实现该方法后，isCalculateHeader将不会生效）
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout isCalculateHeaderViewIndex:(NSInteger)section{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    return sectionModel.isRoundWithHeaderView;
}

/// 根据section设置是否包含footerview（实现该方法后，isCalculateFooter将不会生效）
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout isCalculateFooterViewIndex:(NSInteger)section{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    return sectionModel.isRoundWithFooterView;
}
/// 背景图点击事件
/// @param collectionView collectionView description
/// @param indexPath 点击背景图的indexPath
- (void)collectionView:(UICollectionView *)collectionView didSelectDecorationViewAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:didSelectDecorationViewAtIndexPath:)]) {
        [self.viewDelegate gx_PageCollectionBaseView:self didSelectDecorationViewAtIndexPath:indexPath];
    }
}

/*
 是否头悬停
 @param collectionView collectionView description
 @param collectionView collectionView description
 @param layout layout description
 @param section section description
 */
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout headersPinAtSection:(NSInteger)section
{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    return sectionModel.sectionHeadersHovering;
}
/*
 头悬停上部距离
 @param collectionView collectionView description
 @param collectionView collectionView description
 @param layout layout description
 @param section section description
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout headersPinSpaceAtSection:(NSInteger)section
{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    return sectionModel.sectionHeadersHoveringTopEdging;
}
/*
 是否悬停
 */
- (BOOL)generalCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sectionHeadersPinAtSection:(NSInteger)section
{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    return sectionModel.sectionHeadersHovering;
}
/*
 悬停上部距离
 */
- (CGFloat)generalCollectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sectionHeadersPinTopSpaceAtSection:(NSInteger)section
{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    return sectionModel.sectionHeadersHoveringTopEdging;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

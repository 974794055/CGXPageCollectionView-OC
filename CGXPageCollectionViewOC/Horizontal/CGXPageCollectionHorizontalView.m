//
//  CGXPageCollectionHorizontalView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionHorizontalView.h"
#import "CGXPageCollectionHorizontalLayout.h"

@interface CGXPageCollectionHorizontalView ()<CGXPageCollectionUpdateRoundDelegate,CGXPageCollectionHorizontalLayouttDelegate>


@end
@implementation CGXPageCollectionHorizontalView

- (void)initializeData
{
    [super initializeData];
    self.isShowDifferentColor = NO;
}

- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.pagingEnabled = NO;
}

- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXPageCollectionHorizontalLayout *layout = [[CGXPageCollectionHorizontalLayout alloc] init];
    layout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    layout.isRoundEnabled = YES;
    layout.delegate = self;
    if (@available(iOS 9.0, *)) {
        layout.sectionFootersPinToVisibleBounds =NO;
        layout.sectionHeadersPinToVisibleBounds =NO;
    } else {
        // Fallback on earlier versions
    }
    return layout;
}

- (void)refreshSectionModel:(CGXPageCollectionBaseSectionModel *)baseSectionModel
{
    [super refreshSectionModel:baseSectionModel];
    if (baseSectionModel) {
        NSAssert([baseSectionModel isKindOfClass:[CGXPageCollectionHorizontalSectionModel class]], @"数据源类型不对，必须是CGXPageCollectionHorizontalSectionModel");
        if (baseSectionModel.rowArray.count>0) {
            NSAssert([[baseSectionModel.rowArray firstObject] isKindOfClass:[CGXPageCollectionHorizontalRowModel class]], @"数据源类型不对，必须是CGXPageCollectionHorizontalRowModel");
        }
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGXPageCollectionHorizontalSectionModel *sectionModel = (CGXPageCollectionHorizontalSectionModel *)self.dataArray[section];
    UIEdgeInsets borderEdgeInserts = sectionModel.borderEdgeInserts;
    CGFloat space = borderEdgeInserts.left + borderEdgeInserts.right ;
    if (!sectionModel.footerModel.isHaveFooter) {
        return CGSizeMake(ceil(sectionModel.sectionWidth-space), 0);
    }
    return CGSizeMake(ceil(sectionModel.sectionWidth-space), sectionModel.footerModel.footerHeight);;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGXPageCollectionHorizontalSectionModel *sectionModel = (CGXPageCollectionHorizontalSectionModel *)self.dataArray[section];
    UIEdgeInsets borderEdgeInserts = sectionModel.borderEdgeInserts;;
    CGFloat space = borderEdgeInserts.left + borderEdgeInserts.right ;
    if (!sectionModel.headerModel.isHaveHeader) {
         return CGSizeMake(ceil(sectionModel.sectionWidth-space), 0);
    }
    return CGSizeMake(ceil(sectionModel.sectionWidth-space), sectionModel.headerModel.headerHeight);
}
- (UICollectionReusableView *)refreshHeaderSection:(NSInteger)section Header:(UICollectionReusableView *)headerView
{
    [super refreshHeaderSection:section Header:headerView];
    CGXPageCollectionHorizontalSectionModel *sectionModel = (CGXPageCollectionHorizontalSectionModel *)self.dataArray[section];
    headerView.backgroundColor = sectionModel.headerModel.headerBgColor;
    return headerView;
}
- (UICollectionReusableView *)refreshFooterSection:(NSInteger)section Footer:(UICollectionReusableView *)footerView
{
    [super refreshFooterSection:section Footer:footerView];
    CGXPageCollectionHorizontalSectionModel *sectionModel = (CGXPageCollectionHorizontalSectionModel *)self.dataArray[section];
    footerView.backgroundColor = sectionModel.footerModel.footerBgColor;;
    return footerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionHorizontalSectionModel *sectionModel = (CGXPageCollectionHorizontalSectionModel *)self.dataArray[indexPath.section];
    UIEdgeInsets  insets  = sectionModel.insets;
    UIEdgeInsets borderEdgeInserts =sectionModel.borderEdgeInserts;;
    CGFloat minimumInteritemSpacing = sectionModel.minimumInteritemSpacing;
    CGFloat minimumLineSpacing = sectionModel.minimumLineSpacing;
    CGFloat space = insets.left+insets.right + borderEdgeInserts.left + borderEdgeInserts.right ;
    CGFloat spaceT = insets.top+insets.bottom+borderEdgeInserts.top + borderEdgeInserts.bottom;
    float cellWidth = (ceil(sectionModel.sectionWidth)-space-(sectionModel.row -1)*minimumInteritemSpacing)/sectionModel.row;
    NSAssert(sectionModel.row > 0, @"每行至少一个item");
    
    float cellHeight1 = 0;
    if (!sectionModel.footerModel.isHaveFooter) {
        cellHeight1 = 0;
    }else{
        cellHeight1 = sectionModel.footerModel.footerHeight;
    }
    float cellHeight2 = 0;
    if (!sectionModel.headerModel.isHaveHeader) {
        cellHeight2 = 0;
    }else{
        cellHeight2 = sectionModel.headerModel.headerHeight;
    }
    
    float cellHeight = (CGRectGetHeight(self.frame)-cellHeight1-cellHeight2-spaceT-(sectionModel.section-1)*minimumLineSpacing)/sectionModel.section;
    CGSize sizeFor = CGSizeMake(floor(cellWidth), cellHeight);;
    return sizeFor;
}
- (NSInteger)collectionHorizontalView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout numberOfSection:(NSInteger)section
{
    CGXPageCollectionHorizontalSectionModel *sectionModel = (CGXPageCollectionHorizontalSectionModel *)self.dataArray[section];
    return sectionModel.row;
}
#pragma mark - JHCollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout borderEdgeInsertsForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionHorizontalSectionModel *sectionModel = (CGXPageCollectionHorizontalSectionModel *)self.dataArray[section];
    return sectionModel.borderEdgeInserts;;
}
- (CGXPageCollectionRoundModel *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout configModelForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionHorizontalSectionModel *sectionModel = (CGXPageCollectionHorizontalSectionModel *)self.dataArray[section];
    CGXPageCollectionRoundModel *roundModel = [[CGXPageCollectionRoundModel alloc]init];
    roundModel = sectionModel.roundModel;
    if (self.isShowDifferentColor) {
        roundModel = sectionModel.roundModel;
    } else{
        if (@available(iOS 13.0, *)) {
            UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                    return [UIColor whiteColor];;
                }else {
                    return [UIColor whiteColor];;
                }
            }];
            roundModel.backgroundColor = dyColor;
        }else{
            roundModel.backgroundColor = [UIColor whiteColor];;
        }
    }
    return roundModel;
}
/// 根据section设置是否包含headerview（实现该方法后，isCalculateHeader将不会生效）
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout isCalculateHeaderViewIndex:(NSInteger)section{
        return NO;
}

/// 根据section设置是否包含footerview（实现该方法后，isCalculateFooter将不会生效）
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout isCalculateFooterViewIndex:(NSInteger)section{
        return NO;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

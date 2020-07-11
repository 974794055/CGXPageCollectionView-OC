//
//  CGXPageCollectionGeneralView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionGeneralView.h"
#import "CGXPageCollectionGeneralFlowLayout.h"

@interface CGXPageCollectionGeneralView ()<CGXPageCollectionUpdateRoundDelegate>


@end

@implementation CGXPageCollectionGeneralView

- (void)initializeData
{
    [super initializeData];
    self.isRoundEnabled = YES;
        self.isShowDifferentColor = NO;;
}

- (void)initializeViews
{
    [super initializeViews];
}
- (void)setIsRoundEnabled:(BOOL)isRoundEnabled
{
    _isRoundEnabled = isRoundEnabled;
    [self.collectionView reloadData];
}
- (void)setIsShowDifferentColor:(BOOL)isShowDifferentColor
{
    _isShowDifferentColor = isShowDifferentColor;
    [self.collectionView reloadData];
}
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXPageCollectionGeneralFlowLayout *layout = [[CGXPageCollectionGeneralFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.isRoundEnabled = self.isRoundEnabled;
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
        NSAssert([baseSectionModel isKindOfClass:[CGXPageCollectionGeneralSectionModel class]], @"数据源类型不对，必须是CGXPageCollectionGeneralSectionModel");
        
        if (baseSectionModel.rowArray.count>0) {
            NSAssert([[baseSectionModel.rowArray firstObject] isKindOfClass:[CGXPageCollectionGeneralRowModel class]], @"数据源类型不对，必须是CGXPageCollectionGeneralRowModel");
        }
    }
}
- (UICollectionReusableView *)refreshHeaderSection:(NSInteger)section Header:(UICollectionReusableView *)headerView
{
    [super refreshHeaderSection:section Header:headerView];
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    if (self.isShowDifferentColor) {
        if (sectionModel.isRoundWithHeaerView) {
            headerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        }else{
            headerView.backgroundColor = sectionModel.headerModel.headerBgColor;
        }
    } else{
        headerView.backgroundColor = sectionModel.headerModel.headerBgColor;
    }
    if (sectionModel.isRoundWithHeaerView) {
        UIEdgeInsets borderEdgeInserts = sectionModel.borderEdgeInserts;
        headerView.frame = CGRectMake(borderEdgeInserts.left, borderEdgeInserts.top, headerView.frame.size.width-borderEdgeInserts.left-borderEdgeInserts.right, headerView.frame.size.height-borderEdgeInserts.top);
    }
    return headerView;
}
- (UICollectionReusableView *)refreshFooterSection:(NSInteger)section Footer:(UICollectionReusableView *)footerView
{
    [super refreshFooterSection:section Footer:footerView];
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
    if (self.isShowDifferentColor) {
        if (sectionModel.isRoundWithFooterView) {
            footerView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        }else{
            footerView.backgroundColor = sectionModel.footerModel.footerBgColor;
        }
    } else{
        footerView.backgroundColor = sectionModel.footerModel.footerBgColor;;
    }
     if (sectionModel.isRoundWithFooterView) {
    UIEdgeInsets borderEdgeInserts = sectionModel.borderEdgeInserts;
    footerView.frame = CGRectMake(borderEdgeInserts.left, 0, footerView.frame.size.width-borderEdgeInserts.left-borderEdgeInserts.right, footerView.frame.size.height-borderEdgeInserts.bottom);
     }
    return footerView;
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
    CGSize sizeFor = CGSizeMake(floor(cellWidth), sectionModel.cellHeight);;
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
    if (self.isRoundEnabled) {
        CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
        return sectionModel.isRoundWithHeaerView;
    }else{
        return NO;
    }
}

/// 根据section设置是否包含footerview（实现该方法后，isCalculateFooter将不会生效）
/// @param collectionView collectionView description
/// @param collectionViewLayout collectionViewLayout description
/// @param section section description
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout isCalculateFooterViewIndex:(NSInteger)section{
    if (self.isRoundEnabled) {
        CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.dataArray[section];
        return sectionModel.isRoundWithFooterView;
    }else{
        return NO;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

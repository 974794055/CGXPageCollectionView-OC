//
//  CGXPageCollectionWaterView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionWaterView.h"
#import "CGXPageCollectionWaterLayout.h"


@interface CGXPageCollectionWaterView()<CGXPageCollectionWaterLayoutDataSource,CGXPageCollectionUpdateRoundDelegate>

@end

@implementation CGXPageCollectionWaterView

- (void)initializeData
{
    [super initializeData];
    self.isShowDifferentColor = YES;
}
- (void)initializeViews
{
    [super initializeViews];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = YES;
}
- (void)setIsShowDifferentColor:(BOOL)isShowDifferentColor
{
    _isShowDifferentColor = isShowDifferentColor;
    [self.collectionView reloadData];
}
- (UICollectionViewLayout *)preferredFlowLayout
{
    [super preferredFlowLayout];
    CGXPageCollectionWaterLayout *layout = [[CGXPageCollectionWaterLayout alloc] init];
    layout.dataSource = self;
    layout.isRoundEnabled = YES;
    layout.sectionFootersPinTVisibleBounds = NO;
    return layout;
}
- (void)refreshSectionModel:(CGXPageCollectionBaseSectionModel *)baseSectionModel
{
    [super refreshSectionModel:baseSectionModel];
    if (baseSectionModel) {
        NSAssert([baseSectionModel isKindOfClass:[CGXPageCollectionWaterSectionModel class]], @"数据源类型不对，必须是CGXPageCollectionWaterSectionModel");
        
        if (baseSectionModel.rowArray.count>0) {
            NSAssert([[baseSectionModel.rowArray firstObject] isKindOfClass:[CGXPageCollectionWaterRowModel class]], @"数据源类型不对，必须是CGXPageCollectionWaterRowModel");
        }
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[section];
    return sectionModel.rowArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout *)layout numberOfColumnInSection:(NSInteger)section {
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[section];;
    return sectionModel.row;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout *)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat myHeight = width;
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[indexPath.section];;
    CGXPageCollectionWaterRowModel *item =  (CGXPageCollectionWaterRowModel *)sectionModel.rowArray[indexPath.row];;
    if (item.widthWaterRowBlock) {
        item.widthWaterRowBlock(item, width);
    }
    myHeight = item.cellHeight;
    if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(gx_PageCollectionWaterView:sizeForItemHeightAtIndexPath:ItemSize:)]) {
        myHeight = [self.dataDelegate gx_PageCollectionWaterView:self sizeForItemHeightAtIndexPath:indexPath ItemSize:CGSizeMake(width, myHeight)];
    }
    return CGSizeMake(width, myHeight);
}
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout *)layout IsParityAItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[indexPath.section];;
    if (sectionModel.isParityAItem) {
        if (indexPath.row % 2 == 0) {
            return NO;
        } else{
            return YES;
        }
    }
    return NO;
}
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout*)layout IsParityFlowAtInSection:(NSInteger)section
{
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[section];;
    return sectionModel.isParityFlow;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[section];
    UIEdgeInsets insets = sectionModel.insets;
    UIEdgeInsets borderEdgeInserts = sectionModel.borderEdgeInserts;
    return UIEdgeInsetsMake(insets.top+borderEdgeInserts.top, insets.left+borderEdgeInserts.left, insets.bottom+borderEdgeInserts.bottom, insets.right+borderEdgeInserts.right);
}
#pragma mark - CGXPageCollectionGeneralFlowLayoutRoundDelegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout borderEdgeInsertsForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[section];
    return sectionModel.borderEdgeInserts;
}
- (CGXPageCollectionRoundModel *)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout configModelForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[section];
    CGXPageCollectionRoundModel *roundModel = [[CGXPageCollectionRoundModel alloc]init];
    roundModel = sectionModel.roundModel;
    if (self.isShowDifferentColor) {
        roundModel = sectionModel.roundModel;
    } else{
        if (@available(iOS 13.0, *)) {
            UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
                if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                    return self.backgroundColor;
                }else {
                    return self.backgroundColor;
                }
            }];
            roundModel.backgroundColor = dyColor;
        }else{
            roundModel.backgroundColor = self.backgroundColor;
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
 */
- (BOOL)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout *)collectionViewLayout sectionHeadersPinAtSection:(NSInteger)section
{
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[section];
    return sectionModel.sectionHeadersHovering;
}
/*
 头悬停上部距离
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(CGXPageCollectionWaterLayout *)collectionViewLayout sectionHeadersPinTopSpaceAtSection:(NSInteger)section
{
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[section];
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

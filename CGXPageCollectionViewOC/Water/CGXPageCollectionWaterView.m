//
//  CGXPageCollectionWaterView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionWaterView.h"
#import "CGXPageCollectionWaterLayout.h"
#import "CGXPageCollectionUpdateRoundDelegate.h"
@interface CGXPageCollectionWaterView()<CGXPageCollectionWaterLayoutDataSource,CGXPageCollectionUpdateRoundDelegate>



@end

@implementation CGXPageCollectionWaterView

- (void)initializeData
{
    [super initializeData];
    self.isRoundEnabled = YES;
      self.isShowDifferentColor = YES;;
    self.sectionHeadersPinTVisibleBounds = NO;;
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
    CGXPageCollectionWaterLayout *layout = [[CGXPageCollectionWaterLayout alloc] init];
    layout.dataSource = self;
    layout.isRoundEnabled = self.isRoundEnabled;
    layout.sectionFootersPinTVisibleBounds = NO;
    layout.sectionHeadersPinTVisibleBounds = self.sectionHeadersPinTVisibleBounds;
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
    NSAssert(myHeight > 0, @"myHeight高度必须大于0");
    
    CGXPageCollectionWaterSectionModel *sectionModel = (CGXPageCollectionWaterSectionModel *)self.dataArray[indexPath.section];;
    CGXPageCollectionWaterRowModel *item =  (CGXPageCollectionWaterRowModel *)sectionModel.rowArray[indexPath.row];;
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

//
//  CGXPageCollectionUpdateViewDelegate.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CGXPageCollectionBaseView;

@protocol CGXPageCollectionUpdateViewDelegate <NSObject>

@required

@optional

/* 展示cell 处理数据 */
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView Cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath;
/*点击cell*/
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView DidSelectItemAtIndexPath:(NSIndexPath *)indexPath;
/*显示头分区*/
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView AtIndexPath:(NSIndexPath *)indexPath SectionHeaderView:(UICollectionReusableView *)headerView;
/*显示脚分区 */
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView AtIndexPath:(NSIndexPath *)indexPath SectionFooterView:(UICollectionReusableView *)footerView;
/* 返回封装view的自适应高度。自适应高度时使用*/
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView WithViewHeight:(CGFloat)height;
/*点击头分区*/
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView TapHeaderViewAtIndex:(NSInteger)section;;
/*点击脚分区*/
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView TapFooterViewAtIndex:(NSInteger)section;;
/*滚动*/
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView scrollViewDidScroll:(UIScrollView *)scrollView;

- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView DropUpDownDidChanged:(CGPoint)contentOffset;


@end

NS_ASSUME_NONNULL_END

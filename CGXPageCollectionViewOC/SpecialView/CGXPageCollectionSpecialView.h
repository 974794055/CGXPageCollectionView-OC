//
//  CGXPageCollectionSpecialView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionSpecialFlowLayout.h"
#import "CGXPageCollectionSpecialModel.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXPageCollectionSpecialView;

@protocol CGXPageCollectionSpecialViewDelegate <NSObject>

@required

@optional

/*
 自定义布局 每个item的布局设置  需要考虑一下几个item
 minimumLineSpacing、minimumInteritemSpacing、edgeInsets、headerHeight、footerHeight
 */
- (UICollectionViewLayoutAttributes*)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
                                               Attributes:(UICollectionViewLayoutAttributes *)attributes
                                                  AtIndex:(NSInteger)index;

- (CGSize)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
           sizeForItemAtIndex:(NSInteger)index;;
/*
 自定义cell
 index 下标
 */
- (UICollectionViewCell *)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
                            cellForItemAtIndex:(NSInteger)index;
/*
 自定义heaerView分区
 index 下标
 */
- (void)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
              WithViewHeight:(CGFloat)ViewHeight;

/*
 自定义heaerView分区
 index 下标
 */
- (UIView *)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
                 HeadViewAtIndex:(NSInteger)index;
/*
 自定义footerView分区
 index 下标
 */
- (UIView *)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
                 FootViewAtIndex:(NSInteger)index;
/*
 点击事件
 index 下标
 */
- (void)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
        didSelectItemAtIndex:(NSInteger)index;;

@end

@interface CGXPageCollectionSpecialView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong,readonly) NSMutableArray<CGXPageCollectionSpecialModel *> *dataArray;

@property (nonatomic, assign) CGXPageCollectionSpecialType showType;

@property (nonatomic, assign) id<CGXPageCollectionSpecialViewDelegate>delegate;

/** 列间距 */
@property (nonatomic, assign) CGFloat minimumLineSpacing;
/** 行间距 */
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;
/** collectionView的内边距 */
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, strong) UIColor *headerColor;

@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, strong) UIColor *footerColor;

/*
 // 比例自己设置体验 默认0.5
 
 宽度比例
 CGXPageCollectionSpecialTypeLR21,  // 左2右1bb
 CGXPageCollectionSpecialTypeLR12,   // 左1右2
 CGXPageCollectionSpecialTypeL1TB12,   // 左1上1下2
 CGXPageCollectionSpecialTypeL1TB21,   // 左1上2下1
 CGXPageCollectionSpecialTypeR1TB12,   // 左1上1下2
 CGXPageCollectionSpecialTypeR1TB21,   // 左1上2下1
 
 高度比例
 CGXPageCollectionSpecialTypeTB21,   // 上2下1  注意上两个相等
 CGXPageCollectionSpecialTypeTB12,   // 上1下2 注意下两个相等
 
 */
@property (nonatomic, assign) CGFloat zoomSpace;


- (void)updateWithDataArray:(NSMutableArray<CGXPageCollectionSpecialModel *> *)dataArray;
- (void)updateWithModel:(CGXPageCollectionSpecialModel  *)model AtIndex:(NSInteger)index;
/*
 注册cell
 */
- (void)registerCell:(Class)classCell IsXib:(BOOL)isXib;
@end

NS_ASSUME_NONNULL_END

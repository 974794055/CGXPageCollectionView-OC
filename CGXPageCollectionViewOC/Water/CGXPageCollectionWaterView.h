//
//  CGXPageCollectionWaterView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseView.h"
#import "CGXPageCollectionWaterSectionModel.h"
#import "CGXPageCollectionWaterRowModel.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXPageCollectionWaterView;

@protocol CGXPageCollectionWaterViewDataDelegate<NSObject>

@required

@optional

// 返回高度
- (CGFloat)gx_PageCollectionWaterView:(CGXPageCollectionWaterView *)waterView sizeForItemHeightAtIndexPath:(NSIndexPath *)indexPath ItemSize:(CGSize)itemSize;

@end

@interface CGXPageCollectionWaterView : CGXPageCollectionBaseView

@property (nonatomic, weak) id<CGXPageCollectionWaterViewDataDelegate> dataDelegate;

/// 是否开始Round计算，（默认YES），当该位置为NO时，计算模块都不开启，包括设置的代理
@property (assign, nonatomic) BOOL isRoundEnabled;
/*
// 是否不同背景色
// */
@property (assign, nonatomic) BOOL isShowDifferentColor;
@end

NS_ASSUME_NONNULL_END

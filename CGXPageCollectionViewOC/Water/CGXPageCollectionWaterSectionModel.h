//
//  CGXPageCollectionWaterSectionModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseSectionModel.h"
#import "CGXPageCollectionWaterRowModel.h"
#import "CGXPageCollectionRoundModel.h"
#import "CGXPageCollectionWaterHeaderModel.h"
#import "CGXPageCollectionWaterFooterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionWaterSectionModel : CGXPageCollectionBaseSectionModel
// 此方法排列方式  偶数下标在左边。奇数下标在右边。 两列情况下使用
@property (nonatomic , assign) BOOL isParityAItem;

 //某个分区是否是奇偶瀑布流排布
@property (nonatomic , assign) BOOL isParityFlow;

/*
 //默认每行一个
 */
@property (nonatomic , assign) NSInteger row;

///*
// 是否包含头分区圆角
// */
//@property (assign, nonatomic) BOOL isRoundWithHeaerView;
/*
 是否包含脚分区圆角
 */
//@property (assign, nonatomic) BOOL isRoundWithFooterView;
/// 是否开始Round计算，（默认YES），当该位置为NO时，计算模块都不开启，包括设置的代理
@property (assign, nonatomic) BOOL isRoundEnabled;

/// 是否使用不规则Cell大小的计算方式(若Cell的大小是相同固定大小，则无需开启该方法)，默认NO
//@property (assign, nonatomic) BOOL isCalculateOpenIrregularCell;
/*
 insets 与borderEdgeInserts 一样是时，边框边界无距离 自己设置体验
 */
@property (nonatomic , strong) CGXPageCollectionRoundModel *roundModel;

@property (nonatomic) UIEdgeInsets borderEdgeInserts;//默认是UIEdgeInsetsMake(10, 10, 10, 10);

@end

NS_ASSUME_NONNULL_END

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
/*
 insets 与borderEdgeInserts 一样是时，边框边界无距离 自己设置体验  不包含分区头、脚
 */
@property (nonatomic , strong) CGXPageCollectionRoundModel *roundModel;

@property (nonatomic) UIEdgeInsets borderEdgeInserts;//默认是UIEdgeInsetsMake(10, 10, 10, 10);

/*
 是否悬停 默认NO
 */
@property (assign, nonatomic) BOOL sectionHeadersHovering;
/*
 悬停距离 默认 0
 */
@property (assign, nonatomic) CGFloat sectionHeadersHoveringTopEdging;

@end

NS_ASSUME_NONNULL_END

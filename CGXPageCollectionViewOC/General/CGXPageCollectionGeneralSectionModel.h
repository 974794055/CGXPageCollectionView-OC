//
//  CGXPageCollectionGeneralSectionModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseSectionModel.h"
#import "CGXPageCollectionGeneralRowModel.h"
#import "CGXPageCollectionGeneralHeaderModel.h"
#import "CGXPageCollectionGeneralFooterModel.h"
#import "CGXPageCollectionRoundModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionGeneralSectionModel : CGXPageCollectionBaseSectionModel

// cell的高 默认100
@property (nonatomic , assign) CGFloat cellHeight;
/*
 //默认每行一个
 */
@property (nonatomic , assign) NSInteger row;

/*
 是否包含头分区圆角
 */
@property (assign, nonatomic) BOOL isRoundWithHeaerView;
/*
 是否包含脚分区圆角
 */
@property (assign, nonatomic) BOOL isRoundWithFooterView;
/// 是否开始Round计算，（默认YES），当该位置为NO时，计算模块都不开启，包括设置的代理
@property (assign, nonatomic) BOOL isRoundEnabled;

/*
 insets 与borderEdgeInserts 一样是时，边框边界无距离 自己设置体验
 */
@property (nonatomic , strong) CGXPageCollectionRoundModel *roundModel;

@property (nonatomic) UIEdgeInsets borderEdgeInserts;//默认是UIEdgeInsetsMake(10, 10, 10, 10);

@end

NS_ASSUME_NONNULL_END

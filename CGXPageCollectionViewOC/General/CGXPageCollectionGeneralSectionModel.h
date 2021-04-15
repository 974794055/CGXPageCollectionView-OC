//
//  CGXPageCollectionGeneralSectionModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseSectionModel.h"
#import "CGXPageCollectionGeneralRowModel.h"
#import "CGXPageCollectionRoundModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionGeneralSectionModel : CGXPageCollectionBaseSectionModel

// cell的高 默认100
@property (nonatomic , assign) CGFloat cellHeight;
/*
 默认每行一个
 */
@property (nonatomic , assign) NSInteger row;
/*
 是否包含头分区圆角
 */
@property (assign, nonatomic) BOOL isRoundWithHeaderView;
/*
 是否包含脚分区圆角
 */
@property (assign, nonatomic) BOOL isRoundWithFooterView;

/*
 是否悬停 默认NO
 */
@property (assign, nonatomic) BOOL sectionHeadersHovering;
/*
 悬停距离 默认 0
 */
@property (assign, nonatomic) CGFloat sectionHeadersHoveringTopEdging;
/*
 insets 与borderEdgeInserts 一样是时，边框边界无距离 自己设置体验
 */
@property (nonatomic , strong) CGXPageCollectionRoundModel *roundModel;

@property (nonatomic) UIEdgeInsets borderEdgeInserts;//默认是UIEdgeInsetsMake(10, 10, 10, 10);


@end

NS_ASSUME_NONNULL_END

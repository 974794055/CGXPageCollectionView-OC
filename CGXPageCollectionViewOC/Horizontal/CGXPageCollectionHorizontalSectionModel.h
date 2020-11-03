//
//  CGXPageCollectionHorizontalSectionModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseSectionModel.h"
#import "CGXPageCollectionHorizontalRowModel.h"
#import "CGXPageCollectionRoundModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionHorizontalSectionModel : CGXPageCollectionBaseSectionModel

/* 每个cell的大小会自动计算 设置CGXPageCollectionHorizontalRowModel中的cellHeight无效  */
/*
 //默认每行一个
 */
@property (nonatomic , assign) NSInteger row;
/*
 //默认一行
 */
@property (nonatomic , assign) NSInteger section;
/*
 每个分区的宽
 */
@property (nonatomic , assign) CGFloat sectionWidth;
/*
 insets 与borderEdgeInserts 一样是时，边框边界无距离 自己设置体验
 */
@property (nonatomic , strong) CGXPageCollectionRoundModel *roundModel;

@property (nonatomic) UIEdgeInsets borderEdgeInserts;//默认是UIEdgeInsetsMake(10, 10, 10, 10);

@end

NS_ASSUME_NONNULL_END

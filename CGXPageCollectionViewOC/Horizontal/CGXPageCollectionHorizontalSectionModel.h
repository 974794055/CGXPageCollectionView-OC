//
//  CGXPageCollectionHorizontalSectionModel.h
//  CGXPageCollectionViewOC
//
//  Created by MacMini-1 on 2020/7/8.
//

#import "CGXPageCollectionBaseSectionModel.h"
#import "CGXPageCollectionHorizontalRowModel.h"
#import "CGXPageCollectionRoundModel.h"
#import "CGXPageCollectionHorizontalHeaderModel.h"
#import "CGXPageCollectionHorizontalFooterModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionHorizontalSectionModel : CGXPageCollectionBaseSectionModel

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

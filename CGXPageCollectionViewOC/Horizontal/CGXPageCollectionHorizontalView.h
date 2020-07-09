//
//  CGXPageCollectionHorizontalView.h
//  CGXPageCollectionViewOC
//
//  Created by MacMini-1 on 2020/7/8.
//

#import "CGXPageCollectionBaseView.h"
#import "CGXPageCollectionHorizontalSectionModel.h"
#import "CGXPageCollectionHorizontalRowModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionHorizontalView : CGXPageCollectionBaseView


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
 是否不同背景色
 */
@property (assign, nonatomic) BOOL isShowDifferentColor;
@end

NS_ASSUME_NONNULL_END

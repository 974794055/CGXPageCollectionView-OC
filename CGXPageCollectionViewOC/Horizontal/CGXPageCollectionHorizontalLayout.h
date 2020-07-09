//
//  CGXPageCollectionHorizontalLayout.h
//  CGXPageCollectionViewOC
//
//  Created by MacMini-1 on 2020/7/8.
//

#import "CGXPageCollectionBaseLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionHorizontalLayout : CGXPageCollectionBaseLayout
/*
 //默认每行一个
 */
@property (nonatomic , assign) NSInteger row;
/*
 //默认一行
 */
@property (nonatomic , assign) NSInteger section;


@end

NS_ASSUME_NONNULL_END

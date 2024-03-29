//
//  CGXPageCollectionHorizontalView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseView.h"
#import "CGXPageCollectionHorizontalSectionModel.h"
#import "CGXPageCollectionHorizontalRowModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionHorizontalView : CGXPageCollectionBaseView

/*
 是否分页停留 默认NO
 */
@property (assign, nonatomic) BOOL isScrollPage;


@end

NS_ASSUME_NONNULL_END

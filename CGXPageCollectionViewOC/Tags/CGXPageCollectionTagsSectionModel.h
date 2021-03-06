//
//  CGXPageCollectionTagsSectionModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseSectionModel.h"
#import "CGXPageCollectionTagsRowModel.h"
#import "CGXPageCollectionTagsFlowLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionTagsSectionModel : CGXPageCollectionBaseSectionModel

@property (nonatomic, assign) CGXPageCollectionTagsHorizontalAlignment horizontalAlignment;
@property (nonatomic, assign) CGXPageCollectionTagsVerticalAlignment verticalAlignment;
@property (nonatomic, assign) CGXPageCollectionTagsDirection direction;

/*
 //默认每行一个
 */
@property (nonatomic , assign) NSInteger row;

/*
是否自适应标签 YES时 row无效
*/
@property (nonatomic,assign) BOOL isAdaptive;

@end

NS_ASSUME_NONNULL_END

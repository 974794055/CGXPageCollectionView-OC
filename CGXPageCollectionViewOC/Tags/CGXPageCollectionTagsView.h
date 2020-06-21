//
//  CGXPageCollectionTagsView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseView.h"
#import "CGXPageCollectionTagsFlowLayout.h"
#import "CGXPageCollectionTagsSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXPageCollectionTagsView;

@protocol CGXPageCollectionTagsViewTitleDelegate<NSObject>

@required

@optional

- (CGSize)tagsView:(CGXPageCollectionTagsView *)tagsView sizeForItemHeightAtIndexPath:(NSIndexPath *)indexPath ItemSize:(CGSize)itemSize;

@end

@interface CGXPageCollectionTagsView : CGXPageCollectionBaseView<CGXPageCollectionTagsFlowLayoutDelegate>

@property (nonatomic, weak) id<CGXPageCollectionTagsViewTitleDelegate> titleDelegate;
/// 是否开始Round计算，（默认YES），当该位置为NO时，计算模块都不开启，包括设置的代理
@property (assign, nonatomic) BOOL isRoundEnabled;


@end

NS_ASSUME_NONNULL_END

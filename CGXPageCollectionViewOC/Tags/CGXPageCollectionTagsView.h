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

- (CGSize)gx_PageCollectionTagsView:(CGXPageCollectionTagsView *)tagsView sizeForItemHeightAtIndexPath:(NSIndexPath *)indexPath ItemSize:(CGSize)itemSize;

@end

@interface CGXPageCollectionTagsView : CGXPageCollectionBaseView<CGXPageCollectionTagsFlowLayoutDelegate>

@property (nonatomic, weak) id<CGXPageCollectionTagsViewTitleDelegate> titleDelegate;

@end

NS_ASSUME_NONNULL_END

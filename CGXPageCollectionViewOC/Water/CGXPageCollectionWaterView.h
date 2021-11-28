//
//  CGXPageCollectionWaterView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseView.h"
#import "CGXPageCollectionWaterSectionModel.h"
#import "CGXPageCollectionWaterRowModel.h"
NS_ASSUME_NONNULL_BEGIN

@class CGXPageCollectionWaterView;

@protocol CGXPageCollectionWaterViewDataDelegate<NSObject>

@required

@optional

// 返回高度
- (CGFloat)gx_PageCollectionWaterView:(CGXPageCollectionWaterView *)waterView
         sizeForItemHeightAtIndexPath:(NSIndexPath *)indexPath
                             ItemSize:(CGSize)itemSize;

@end

@interface CGXPageCollectionWaterView : CGXPageCollectionBaseView

@property (nonatomic, weak) id<CGXPageCollectionWaterViewDataDelegate> dataDelegate;

@end

NS_ASSUME_NONNULL_END

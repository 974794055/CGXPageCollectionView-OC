//
//  CGXPageCollectionGeneralView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseView.h"

#import "CGXPageCollectionGeneralSectionModel.h"
#import "CGXPageCollectionGeneralRowModel.h"

@class CGXPageCollectionGeneralFlowLayout;

NS_ASSUME_NONNULL_BEGIN

@class CGXPageCollectionGeneralView;

@protocol CGXPageCollectionGeneralViewDataDelegate<NSObject>

@required

@optional

- (CGSize)gx_PageCollectionGeneralView:(CGXPageCollectionGeneralView *)tagsView
          sizeForItemHeightAtIndexPath:(NSIndexPath *)indexPath
                              ItemSize:(CGSize)itemSize;

@end

@interface CGXPageCollectionGeneralView : CGXPageCollectionBaseView

@property (nonatomic, weak) id<CGXPageCollectionGeneralViewDataDelegate> dataDelegate;

/*
 是否不同背景色
 */
@property (assign, nonatomic) BOOL isShowDifferentColor;

@end

NS_ASSUME_NONNULL_END

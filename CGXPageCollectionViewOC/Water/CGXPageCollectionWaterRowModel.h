//
//  CGXPageCollectionWaterRowModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseRowModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionWaterRowModel : CGXPageCollectionBaseRowModel

// cell的高 默认100
@property (nonatomic , assign) CGFloat cellHeight;
// 宽度回掉
@property (copy, nonatomic) void(^widthWaterRowBlock)(CGXPageCollectionWaterRowModel *waterRowM,CGFloat itemWaterWidth);

@end

NS_ASSUME_NONNULL_END

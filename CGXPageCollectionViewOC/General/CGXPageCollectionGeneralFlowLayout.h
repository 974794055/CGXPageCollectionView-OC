//
//  CGXPageCollectionGeneralFlowLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseLayout.h"
#import <UIKit/UIKit.h>
#import "CGXPageCollectionRoundModel.h"

#import "CGXPageCollectionUpdateRoundDelegate.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    CGXPageCollectionGeneralFlowLayoutAlignmentSystem = 0,
    CGXPageCollectionGeneralFlowLayoutAlignmentLeft,
    CGXPageCollectionGeneralFlowLayoutAlignmentCenter,
    CGXPageCollectionGeneralFlowLayoutAlignmentRight,
    CGXPageCollectionGeneralFlowLayoutAlignmentRightStart,
} CGXPageCollectionGeneralFlowLayoutAlignment;


@interface CGXPageCollectionGeneralFlowLayout : CGXPageCollectionBaseLayout
/// 设置cell对齐方式，不设置为使用系统默认，支持Left
@property (assign, nonatomic) CGXPageCollectionGeneralFlowLayoutAlignment alignmentType;



@end

NS_ASSUME_NONNULL_END

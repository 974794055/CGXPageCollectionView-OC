//
//  CGXPageCollectionIrreguarSectionModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseSectionModel.h"
#import "CGXPageCollectionIrreguarRowModel.h"


NS_ASSUME_NONNULL_BEGIN

/**
 @p1aram1 showStyle 初始化选择类型
 */
typedef NS_ENUM(NSInteger, CGXPageCollectionIrregularLayoutShowType) {
    CGXPageCollectionIrregularLayoutDefault,       // 正常排布 每行个数相等
    CGXPageCollectionIrregularLayoutLeftRight2T1,  // 左2右1
    CGXPageCollectionIrregularLayoutLeftRight1T2,   // 左1右2
    CGXPageCollectionIrregularLayoutTopBottom2T1,   // 上2下1  注意上两个相等
    CGXPageCollectionIrregularLayoutTopBottom1T2,   // 上1下2 注意下两个相等
    CGXPageCollectionIrregularLayoutFirstBigTN,     // 第一个大 右侧几行几个
};

@interface CGXPageCollectionIrreguarSectionModel : CGXPageCollectionBaseSectionModel

/*
    默认每个分区分为两部分 上部分 和 下部分 item大小相等 注意给的item宽高
 */

@property (nonatomic , assign) NSInteger topHeight;// 默认100
@property (nonatomic , assign) NSInteger bottomHeight;// 默认100


@property (nonatomic , assign) NSInteger topSection;//默认每行一个。上部分
@property (nonatomic , assign) NSInteger topRow;//默认每行一个。上部分

@property (nonatomic , assign) NSInteger bottomRow;//默认每行一个。下部分

@property (nonatomic ,assign) CGXPageCollectionIrregularLayoutShowType showType;

@end

NS_ASSUME_NONNULL_END

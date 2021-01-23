//
//  CGXPageCollectionSpecialFlowLayout.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionSpecialModel.h"

NS_ASSUME_NONNULL_BEGIN

/**
 @p1aram1 showStyle 初始化选择类型
 */
typedef NS_ENUM(NSInteger, CGXPageCollectionSpecialType) {
    CGXPageCollectionSpecialTypeDefault,       // 正常排布 垂直 大小相等
    CGXPageCollectionSpecialTypeDefaultH,       // 正常排布 水平 大小相等
    CGXPageCollectionSpecialTypeLR21,  // 左2右1bb
    CGXPageCollectionSpecialTypeLR12,   // 左1右2
    CGXPageCollectionSpecialTypeTB21,   // 上2下1  注意上两个相等
    CGXPageCollectionSpecialTypeTB12,   // 上1下2 注意下两个相等
    CGXPageCollectionSpecialTypeL1TB12,   // 左1上1下2
    CGXPageCollectionSpecialTypeL1TB21,   // 左1上2下1
    CGXPageCollectionSpecialTypeR1TB12,   // 左1上1下2
    CGXPageCollectionSpecialTypeR1TB21,   // 左1上2下1
    CGXPageCollectionSpecialTypeBig,   // 左1上2下1
    CGXPageCollectionSpecialTypeCustom,   // 自定义
    
};

@class CGXPageCollectionSpecialFlowLayout;

@protocol CGXPageCollectionSpecialFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@required

//存放每个分区的布局属性
- (CGXPageCollectionSpecialType)collectionView:(UICollectionView *)collectionView TypeForInSection:(NSInteger)section;

@optional

- (UICollectionViewLayoutAttributes*)collectionView:(UICollectionView *)collectionView
                                         Attributes:(UICollectionViewLayoutAttributes *)attributes
                                            AtIndex:(NSInteger)index;


@end

@interface CGXPageCollectionSpecialFlowLayout : UICollectionViewFlowLayout
@property (nonatomic, strong,readonly) NSMutableArray *attrsArr;
@property (nonatomic, assign) id<CGXPageCollectionSpecialFlowLayoutDelegate>delegate;
/*
 // 比例自己设置体验
 
 宽度比例
 CGXPageCollectionSpecialTypeLR21,  // 左2右1bb
 CGXPageCollectionSpecialTypeLR12,   // 左1右2
 CGXPageCollectionSpecialTypeL1TB12,   // 左1上1下2
 CGXPageCollectionSpecialTypeL1TB21,   // 左1上2下1
 CGXPageCollectionSpecialTypeR1TB12,   // 左1上1下2
 CGXPageCollectionSpecialTypeR1TB21,   // 左1上2下1
 
 高度比例
 CGXPageCollectionSpecialTypeTB21,   // 上2下1  注意上两个相等
 CGXPageCollectionSpecialTypeTB12,   // 上1下2 注意下两个相等
 */
@property (nonatomic, assign) CGFloat zoomSpace;

@end

NS_ASSUME_NONNULL_END

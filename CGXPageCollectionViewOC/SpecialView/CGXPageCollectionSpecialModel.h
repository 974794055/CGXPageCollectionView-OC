//
//  CGXPageCollectionSpecialModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "CGXPageCollectionBaseRowModel.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@interface CGXPageCollectionSpecialModel : NSObject

//cell的原始数据
@property (nonatomic , strong) id dataModel;
// 背景颜色
@property (nonatomic, strong) UIColor *itemColor;
// 图片
@property (nonatomic, strong) NSString *itemImageStr;
/** --cell边框--- */
/** 下标对应文字背景颜  [UIColor redColor]; */
@property (nonatomic, strong) UIColor *itemBorderColor;
@property (nonatomic, assign) CGFloat itemBorderWidth;
@property (nonatomic, assign) CGFloat itemBorderRadius;

/** 图片加载 */
@property (nonatomic, copy) void(^loadImageCallback)(UIImageView *imageView, NSURL *imageURL);


@end

NS_ASSUME_NONNULL_END

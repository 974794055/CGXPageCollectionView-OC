//
//  CGXPageCollectionRoundModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionRoundModel : NSObject
/// 外圈line边显示宽度
@property (assign, nonatomic) CGFloat borderWidth;
/// 外圈line边显示颜色
@property (strong, nonatomic) UIColor *borderColor;
/// 背景颜色
@property (strong, nonatomic) UIColor *backgroundColor;
/// 投影相关参数
@property (strong, nonatomic) UIColor *shadowColor;
@property (assign, nonatomic) CGSize shadowOffset;
@property (assign, nonatomic) CGFloat shadowOpacity;
@property (assign, nonatomic) CGFloat shadowRadius;
/// 圆角
@property (assign, nonatomic) CGFloat cornerRadius;

@property (nonatomic , strong) UIImage *bgImage; //默认无

@end

NS_ASSUME_NONNULL_END

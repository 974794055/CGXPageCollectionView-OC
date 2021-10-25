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
@property (assign, nonatomic) CGSize  shadowOffset;
@property (assign, nonatomic) CGFloat shadowOpacity;
@property (assign, nonatomic) CGFloat shadowRadius;
/// 圆角
@property (assign, nonatomic) CGFloat cornerRadius;

/* UIImage名称、网络连接  */
@property (strong, nonatomic) NSString *hotStr;// 背景图片名称
/** 图片加载 */
@property (nonatomic, copy) void(^page_ImageCallback)(UIImageView *hotImageView,NSURL *hotURL);

@end

NS_ASSUME_NONNULL_END

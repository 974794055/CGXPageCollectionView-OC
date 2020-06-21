//
//  CGXPageCollectionTools.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionTools : NSObject

+ (UIViewController*)viewController:(UIView *)view;

/** 绘画圆角 解决卡顿*/
+(UIView *)drawConnerView:(CGFloat)cornerRadius rect:(CGRect)frame backgroudColor:(UIColor *)backgroud_color borderColor:(UIColor *)borderColor;

+ (id)createForClass:(NSString *)name;
/**
 计算整体尺寸
 */
+ (CGSize)calculateStringViewSizeWithShowSize:(CGSize)showSize fontSize:(UIFont *)fontSize string:(NSString *)string;
@end

NS_ASSUME_NONNULL_END

//
//  UIImage+CGXPageCollection.h
//  CGXPageCollectionViewOC
//
//  Created by CGX on 2020/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (CGXPageCollection)
/**
 *  @brief  根据颜色生成纯色图片
 *
 *  @param color 颜色
 *
 *  @return 纯色图片
 */
+ (UIImage *)gx_pageImageWithColor:(UIColor *)color;

/**
 带有阴影的图片

 @param color 颜色
 @param offset offset
 @param blur 模糊度，可以先设置个20试试
 @return 带有阴影的图片
 */
- (UIImage *)imageWithShadowColor:(UIColor *)color offset:(CGSize)offset blur:(CGFloat)blur;
@end

NS_ASSUME_NONNULL_END

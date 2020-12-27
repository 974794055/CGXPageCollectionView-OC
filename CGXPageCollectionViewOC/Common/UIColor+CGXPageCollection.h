//
//  UIColor+CGXPageCollection.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CGXPageCollection)
// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor *)gx_pageColorWithHexVal:(long)hexVal;
// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *)gx_pageColorWithHexTxt:(NSString *)color;
// 0-255的rgb数据
+ (UIColor *)gx_pageColorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b;
// 随机颜色
+ (UIColor *)gx_pageRandomColor;
@end


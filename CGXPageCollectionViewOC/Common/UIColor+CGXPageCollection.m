//
//  UIColor+CGXPageCollection.m
//  LayerTest
//
//  Created by Lonelyflow on 19/04/2019.
//  Copyright © 2019 Lonely traveller. All rights reserved.
//

#import "UIColor+CGXPageCollection.h"

@implementation UIColor (CGXPageCollection)
// 透明度固定为1，以0x开头的十六进制转换成的颜色
+ (UIColor *)colorWithHexVal:(long)hexVal
{
    NSInteger r = (((hexVal & 0xFF0000) >> 16));
    NSInteger g = (((hexVal & 0xFF00) >> 8));
    NSInteger b = ((hexVal & 0xFF));
    CGFloat a = 1;
    return [self colorWithR:r g:g b:b a:a];
}
// 颜色转换三：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *) colorWithHexTxt: (NSString *)hexTxt
{
    NSString *colorTxt = [hexTxt uppercaseString];
    // 去掉#
    if ([colorTxt hasPrefix:@"#"]){
        colorTxt = [colorTxt stringByReplacingOccurrencesOfString:@"#" withString:@""];
    }
    // 判断前缀并剪切掉
    if ([colorTxt hasPrefix:@"0X"]){
        colorTxt = [colorTxt substringFromIndex:2];
    }
    NSString *rTxt,*gTxt,*bTxt,*aTxt;
    if(colorTxt.length == 8){
        rTxt = [colorTxt substringWithRange:NSMakeRange(0, 2)];
        gTxt = [colorTxt substringWithRange:NSMakeRange(2, 2)];
        bTxt = [colorTxt substringWithRange:NSMakeRange(4, 2)];
        aTxt = [colorTxt substringWithRange:NSMakeRange(6, 2)];
    }else if(colorTxt.length == 6){
        rTxt = [colorTxt substringWithRange:NSMakeRange(0, 2)];
        gTxt = [colorTxt substringWithRange:NSMakeRange(2, 2)];
        bTxt = [colorTxt substringWithRange:NSMakeRange(4, 2)];
        aTxt = @"ff";
    }else if (colorTxt.length == 4){
        rTxt = [colorTxt substringWithRange:NSMakeRange(0, 1)];
        rTxt = [NSString stringWithFormat:@"%@%@",rTxt,rTxt];
        gTxt = [colorTxt substringWithRange:NSMakeRange(1, 1)];
        gTxt = [NSString stringWithFormat:@"%@%@",gTxt,gTxt];
        bTxt = [colorTxt substringWithRange:NSMakeRange(2, 1)];
        bTxt = [NSString stringWithFormat:@"%@%@",bTxt,bTxt];
        aTxt = [colorTxt substringWithRange:NSMakeRange(3, 1)];
        aTxt = [NSString stringWithFormat:@"%@%@",aTxt,aTxt];
    }else if (colorTxt.length == 3){
        rTxt = [colorTxt substringWithRange:NSMakeRange(0, 1)];
        rTxt = [NSString stringWithFormat:@"%@%@",rTxt,rTxt];
        gTxt = [colorTxt substringWithRange:NSMakeRange(1, 1)];
        gTxt = [NSString stringWithFormat:@"%@%@",gTxt,gTxt];
        bTxt = [colorTxt substringWithRange:NSMakeRange(2, 1)];
        bTxt = [NSString stringWithFormat:@"%@%@",bTxt,bTxt];
        aTxt = @"ff";
    }else{
        return nil;
    }
    // Scan values
    unsigned int r, g, b,a;
    [[NSScanner scannerWithString:rTxt] scanHexInt:&r];
    [[NSScanner scannerWithString:gTxt] scanHexInt:&g];
    [[NSScanner scannerWithString:bTxt] scanHexInt:&b];
    [[NSScanner scannerWithString:aTxt] scanHexInt:&a];
    return [self colorWithR:r g:g b:b a:a/255.0];
}
// 0-255的rgb数据
+ (UIColor *) colorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b
{
    return [self colorWithR:r g:g b:b a:1];
}
+ (UIColor *)colorWithR:(NSInteger)r g:(NSInteger)g b:(NSInteger)b a:(CGFloat)a
{
    float red = r/255.0;
    float green = g/255.0;
    float blue = b/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:a];
}
// 随机颜色
+ (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256);
    CGFloat g = arc4random_uniform(256);
    CGFloat b = arc4random_uniform(256);
    return [UIColor colorWithR:r g:g b:b a:1];
}
@end

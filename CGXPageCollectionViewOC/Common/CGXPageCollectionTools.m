//
//  CGXPageCollectionTools.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionTools.h"
#import <objc/runtime.h>
@implementation CGXPageCollectionTools

+ (UIViewController*)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}
+ (id)createForClass:(NSString *)name
{
    const char *className = [name cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    
    return instance;
}
/**
 计算整体尺寸
 */
+ (CGSize)gx_pageStringSizeWithShowSize:(CGSize)showSize fontSize:(UIFont *)fontSize string:(NSString *)string{
    //---- 计算高度 ---- //
    CGSize size = showSize;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fontSize,NSFontAttributeName, nil];
    CGSize cur = [string boundingRectWithSize:size
                                      options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                   attributes:dic
                                      context:nil].size;
    return cur;
}
@end

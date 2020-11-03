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


/** 绘画圆角 解决卡顿*/
+(UIView *)drawConnerView:(CGFloat)cornerRadius rect:(CGRect)frame backgroudColor:(UIColor *)backgroud_color borderColor:(UIColor *)borderColor{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGRect bounds = CGRectInset(frame, 0, 0);
    CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMinY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMinX(bounds), CGRectGetMinY(bounds), cornerRadius);
    CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMinX(bounds), CGRectGetMaxY(bounds), cornerRadius);
    layer.path = pathRef;
    CFRelease(pathRef);
    layer.strokeColor = [borderColor CGColor];
    layer.fillColor = backgroud_color.CGColor;
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    return roundView;
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
//- (void)push:(NSDictionary *)params
//{
//     // 类名
//     NSString *class =[NSString stringWithFormat:@"%@", params[@"class"]];
//     const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
//     // 从一个字串返回一个类
//     Class newClass = objc_getClass(className);
//     if (!newClass)
//         {
//              // 创建一个类
//              Class superClass = [NSObject class];
//              newClass = objc_allocateClassPair(superClass, className, 0);
//              // 注册你创建的这个类
//              objc_registerClassPair(newClass);
//             }
//     // 创建对象
//     id instance = [[newClass alloc] init];
//     // 对该对象赋值属性
//     NSDictionary * propertys = params[@"property"];
//     [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//          // 检测这个对象是否存在该属性
//          if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
//               // 利用kvc赋值
//               [instance setValue:obj forKey:key];
//              }
//         }];
//     // 获取导航控制器
//     UITabBarController *tabVC = (UITabBarController *)self.window.rootViewController;
//     UINavigationController *pushClassStance = (UINavigationController *)tabVC.viewControllers[tabVC.selectedIndex];
//     // 跳转到对应的控制器
//     [pushClassStance pushViewController:instance animated:YES];
//}
/**
 计算整体尺寸
 */
+ (CGSize)calculateStringViewSizeWithShowSize:(CGSize)showSize fontSize:(UIFont *)fontSize string:(NSString *)string{
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

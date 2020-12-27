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

+ (id)createForClass:(NSString *)name;
/**
 计算整体尺寸
 */
+ (CGSize)gx_pageStringSizeWithShowSize:(CGSize)showSize fontSize:(UIFont *)fontSize string:(NSString *)string;
@end

NS_ASSUME_NONNULL_END

//
//  UIView+CGXPageCollectionTap.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CGXPageGestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (CGXPageCollectionTap)

/*
*  @param block 代码块
*/
- (void)gx_addPageTapActionWithBlock:(CGXPageGestureActionBlock)block;

@end

NS_ASSUME_NONNULL_END

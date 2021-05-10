//
//  UIView+CGXPageCollectionTap.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CGXPageCollectionTapBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (CGXPageCollectionTap)

- (void)gx_pageTapGestureRecognizerWithBlock:(CGXPageCollectionTapBlock)block;

@end

NS_ASSUME_NONNULL_END

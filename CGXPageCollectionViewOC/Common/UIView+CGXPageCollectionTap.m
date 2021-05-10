//
//  UIView+CGXPageCollectionTap.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIView+CGXPageCollectionTap.h"
#import <objc/runtime.h>
static char kActionCGXPageCollectionBlockKey;
static char kActionCGXPageCollectionGestureKey;

@implementation UIView (CGXPageCollectionTap)
- (void)gx_pageTapGestureRecognizerWithBlock:(CGXPageCollectionTapBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionCGXPageCollectionGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionCGXPageCollectionGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionCGXPageCollectionBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        CGXPageCollectionTapBlock block = objc_getAssociatedObject(self, &kActionCGXPageCollectionBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}
@end

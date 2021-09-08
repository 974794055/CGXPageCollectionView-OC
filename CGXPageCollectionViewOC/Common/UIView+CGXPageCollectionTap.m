//
//  UIView+CGXPageCollectionTap.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIView+CGXPageCollectionTap.h"
#import <objc/runtime.h>

static char kPageActionHandlerTapBlockKey;
static char kPageActionHandlerTapGestureKey;

@implementation UIView (CGXPageCollectionTap)

- (void)gx_addPageTapActionWithBlock:(CGXPageGestureActionBlock)block
{
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kPageActionHandlerTapGestureKey);
    if (!gesture)
    {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageHandleActionForTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kPageActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kPageActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)pageHandleActionForTapGesture:(UITapGestureRecognizer*)gesture
{
    if (gesture.state == UIGestureRecognizerStateRecognized)
    {
        CGXPageGestureActionBlock block = objc_getAssociatedObject(self, &kPageActionHandlerTapBlockKey);
        if (block)
        {
            block(gesture);
        }
    }
}

@end

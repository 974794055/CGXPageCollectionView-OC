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
        gesture.delegate = self;
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
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    NSLog(@"\n%@\n%@\n%@" , NSStringFromClass([touch.view class]),NSStringFromClass([touch.view.superview class]),NSStringFromClass([touch.view.superview.superview class]));
    if([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]){
        return NO;
    }
    if([NSStringFromClass([touch.view class]) isEqualToString:@"_UITableViewHeaderFooterContentView"]){
        return NO;
    }

    if([touch.view.superview isKindOfClass:[UICollectionViewCell class]]){
        return NO;
    }
    if([touch.view.superview isKindOfClass:[UICollectionReusableView class]]){
        return NO;
    }
    return YES;
}
@end

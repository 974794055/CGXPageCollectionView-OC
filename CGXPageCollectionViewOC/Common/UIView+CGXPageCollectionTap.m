//
//  UIView+CGXPageCollectionTap.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIView+CGXPageCollectionTap.h"
#import <objc/runtime.h>
@implementation UIView (CGXPageCollectionTap)

- (void)gx_pageTapGestureRecognizerWithDelegate:(id)tapGestureDelegate Block:(void (^)(NSInteger))block
{
    self.block = block;
    UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagClick)];
    [self addGestureRecognizer:tag];
    if (tapGestureDelegate) {
        tag.delegate = tapGestureDelegate;
    }
    self.userInteractionEnabled = YES;
}
- (void)tagClick
{
    if (self.block) {
        self.block(self.tag);
    }
}
- (void)setBlock:(void (^)(NSInteger tag))block
{
    objc_setAssociatedObject(self, @selector(block), block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void(^)(NSInteger tag))block
{
    return objc_getAssociatedObject(self, @selector(block));
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
//    if (![NSStringFromClass([touch.view class]) isEqual:@"_UITableViewHeaderFooterContentView"]) {
//         return NO;
//    }
//    if ([touch.view isKindOfClass:[UITableViewHeaderFooterView class]])
//    {
//        return NO;
//    }
    return YES;
}

@end

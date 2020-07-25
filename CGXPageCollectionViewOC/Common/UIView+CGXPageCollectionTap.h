//
//  UIView+CGXPageCollectionTap.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CGXPageCollectionTap)<UIGestureRecognizerDelegate>

@property (nonatomic,assign) void(^block)(NSInteger tag);

- (void)addCGXPageCollectionTapGestureRecognizerWithDelegate:(id)tapGestureDelegate Block:(void(^)(NSInteger tag))block;
@end

NS_ASSUME_NONNULL_END

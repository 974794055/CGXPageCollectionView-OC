//
//  UIButton+CGXTableViewGeneralBtnBlock.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIButton (CGXPageCollectionBaseViewBlock)

@property(nonatomic ,copy)void(^block)(UIButton*);

-(void)addCGXPageCollectionTapBlock:(void(^)(UIButton*btn))block;

@end

NS_ASSUME_NONNULL_END

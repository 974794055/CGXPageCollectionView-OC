//
//  UIButton+CGXPageCollectionTapBlock.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "UIButton+CGXPageCollectionTapBlock.h"
#import <objc/runtime.h>

@implementation UIButton (CGXPageCollectionTapBlock)

-(void)setBlock:(void(^)(UIButton*))block{
    objc_setAssociatedObject(self,@selector(block), block,OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
}
-(void(^)(UIButton*))block{
    return objc_getAssociatedObject(self,@selector(block));
    
}
-(void)addCGXPageCollectionTapBlock:(void(^)(UIButton*))block{
    self.block= block;
    [self addTarget:self action:@selector(click:)forControlEvents:UIControlEventTouchUpInside];
    
}
-(void)click:(UIButton*)btn{
    if(self.block){
        self.block(btn);
    }
}



@end

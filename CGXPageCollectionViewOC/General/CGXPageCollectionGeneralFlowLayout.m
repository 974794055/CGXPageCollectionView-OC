//
//  CGXPageCollectionGeneralFlowLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionGeneralFlowLayout.h"
#import "CGXPageCollectionFlowLayoutUtils.h"
#import "CGXPageCollectionRoundLayoutAttributes.h"
#import "CGXPageCollectionRoundReusableView.h"

@interface CGXPageCollectionGeneralFlowLayout ()


@end


@implementation CGXPageCollectionGeneralFlowLayout

- (instancetype)init{
    self = [super init];
    if (self) {
        self.isRoundEnabled = YES;
    }
    return self;
}
- (void)prepareLayout{
    [super prepareLayout];
    [self initializeRoundView];
}
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray * attrsArr = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        [attrsArr addObject:attr];
    }
    return attrsArr;
}
@end





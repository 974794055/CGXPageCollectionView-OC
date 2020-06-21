//
//  CGXPageCollectionGeneralFlowLayout.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionGeneralFlowLayout.h"
#import "CGXPageCollectionFlowLayoutUtils.h"
#import "CGXPageCollectionGeneralFlowLayout+Alignment.h"
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

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    NSMutableArray * attrs = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    if (self.alignmentType != CGXPageCollectionGeneralFlowLayoutAlignmentSystem
        && self.scrollDirection == UICollectionViewScrollDirectionVertical) {
        //竖向,Cell对齐方式暂不支持横向
        NSArray *formatGroudAttr = [self groupLayoutAttributesForElementsByYLineWithLayoutAttributesAttrs:attrs];
        [self evaluatedAllCellSettingFrameWithLayoutAttributesAttrs:formatGroudAttr
                                        toChangeAttributesAttrsList:&attrs
                                                  cellAlignmentType:self.alignmentType];
    }
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        [attrs addObject:attr];
    }
    return attrs;
}
@end




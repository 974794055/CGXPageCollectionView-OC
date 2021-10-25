//
//  CGXPageCollectionHeaderModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionHeaderModel.h"
@interface CGXPageCollectionHeaderModel()

@property (nonatomic , assign,readwrite) BOOL headerXib;
@property (nonatomic, strong,readwrite) Class headerClass;
@end
@implementation CGXPageCollectionHeaderModel
- (instancetype)initWithHeaderClass:(Class)headerClass IsXib:(BOOL)isXib
{
    self = [super init];
    if (self) {
        NSAssert(![headerClass isKindOfClass:[UICollectionReusableView class]], @"分区头view必须是UICollectionReusableViewk类型");
        self.headerClass = headerClass;
        self.headerXib = isXib;
        self.headerHeight = 0;
        self.headerTag = 0;
        self.headerBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        self.isHaveHeader = YES;
        self.isHaveTap = NO;
    }
    return self;
}
- (NSString *)headerIdentifier
{
    return [NSString stringWithFormat:@"%@", self.headerClass];
}
@end

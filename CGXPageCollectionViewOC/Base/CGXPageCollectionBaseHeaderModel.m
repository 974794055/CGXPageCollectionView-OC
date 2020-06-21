//
//  CGXPageCollectionBaseHeaderModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseHeaderModel.h"
@interface CGXPageCollectionBaseHeaderModel()

@property (nonatomic , assign,readwrite) BOOL headerXib;
@property (nonatomic, strong,readwrite) Class headerClass;
@end
@implementation CGXPageCollectionBaseHeaderModel
- (instancetype)initWithHeaderClass:(Class)headerClass IsXib:(BOOL)isXib
{
    self = [super init];
    if (self) {
        NSAssert(![headerClass isKindOfClass:[UICollectionReusableView class]], @"分区头view必须是UICollectionReusableViewk类型");
        self.headerClass = headerClass;
        self.headerXib = isXib;
        self.headerHeight = 0.01;
        self.headerTag = 0;
        self.headerBgColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];;
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

//
//  CGXPageCollectionBaseFooterModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseFooterModel.h"
@interface CGXPageCollectionBaseFooterModel()

@property (nonatomic , assign,readwrite) BOOL footerXib;
@property (nonatomic, strong,readwrite) Class footerClass;
@end
@implementation CGXPageCollectionBaseFooterModel

- (instancetype)initWithFooterClass:(Class)footerClass IsXib:(BOOL)isXib
{
    self = [super init];
    if (self) {
        NSAssert(![footerClass isKindOfClass:[UICollectionReusableView class]], @"分区脚view必须是UICollectionReusableViewk类型");
        self.footerClass = footerClass;
        self.footerXib = isXib;
        self.footerHeight = 10;
        self.footerTag = 0;
        self.footerBgColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
        self.isHaveFooter = YES;
         self.isHaveTap = NO;
    }
    return self;
}
- (NSString *)footerIdentifier
{

    return [NSString stringWithFormat:@"%@", self.footerClass];
}
@end

//
//  CGXPageCollectionBaseSectionModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseSectionModel.h"

@interface CGXPageCollectionBaseSectionModel()

//默认不适用xib
@property (nonatomic , assign,readwrite) BOOL isXib;
@property(nonatomic, strong,readwrite) Class cellClass;

@end

@implementation CGXPageCollectionBaseSectionModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initializeData];
    }
    return self;
}
- (void)initializeData
{
    self.rowArray = [NSMutableArray array];
    self.insets =UIEdgeInsetsMake(10, 10, 10, 10);
    self.minimumLineSpacing = 10;
    self.minimumInteritemSpacing = 10;
    self.headerModel = [[CGXPageCollectionHeaderModel alloc] initWithHeaderClass:[UICollectionReusableView class] IsXib:NO];
    self.footerModel = [[CGXPageCollectionFooterModel alloc] initWithFooterClass:[UICollectionReusableView class] IsXib:NO];
}

@end

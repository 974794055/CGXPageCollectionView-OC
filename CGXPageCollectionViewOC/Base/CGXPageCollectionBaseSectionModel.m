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


/*
 头分区
 */
@property (nonatomic , strong ,readwrite) CGXPageCollectionBaseHeaderModel *headerModel;
/*
 脚分区
 */
@property (nonatomic , strong ,readwrite) CGXPageCollectionBaseFooterModel *footerModel;

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
    self.headerModel = [[CGXPageCollectionBaseHeaderModel alloc] initWithHeaderClass:[UICollectionReusableView class] IsXib:NO];
    self.footerModel = [[CGXPageCollectionBaseFooterModel alloc] initWithFooterClass:[UICollectionReusableView class] IsXib:NO];
}
/*
 初始化方法  Class类型 [UICollectionReusableView class]
 */
- (void)initWithHeaderClass:(Class)headerClass IsXib:(BOOL)isXib
{
    self.headerModel = [[CGXPageCollectionBaseHeaderModel alloc] initWithHeaderClass:headerClass IsXib:isXib];
}
/*
 初始化方法  Class类型 [UICollectionReusableView class]
 */
- (void)initWithFooterClass:(Class)footerClass IsXib:(BOOL)isXib
{
    self.footerModel = [[CGXPageCollectionBaseFooterModel alloc] initWithFooterClass:footerClass IsXib:isXib];
}
@end

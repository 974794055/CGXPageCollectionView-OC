//
//  CGXPageCollectionTagsSectionModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionTagsSectionModel.h"

@implementation CGXPageCollectionTagsSectionModel
- (void)initializeData
{
    [super initializeData];
    self.row = 4;

}

- (void)initWithFooterClass:(Class)footerClass IsXib:(BOOL)isXib
{
    [super initWithFooterClass:footerClass IsXib:isXib];
}
- (void)initWithHeaderClass:(Class)headerClass IsXib:(BOOL)isXib
{
    [super initWithHeaderClass:headerClass IsXib:isXib];
}
@end

//
//  CGXPageCollectionGeneralSectionModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionGeneralSectionModel.h"

@implementation CGXPageCollectionGeneralSectionModel

- (void)initializeData
{
    [super initializeData];
    self.row = 1;

    self.isRoundWithFooterView = NO;;
    self.isRoundWithHeaerView = NO;;
    self.isRoundEnabled = NO;
    self.isCalculateOpenIrregularCell = NO;
//    self.alignment = CGXPageCollectionGeneralAlignmentSystem;
     self.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
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

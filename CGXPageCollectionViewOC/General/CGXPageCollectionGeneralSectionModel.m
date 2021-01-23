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
    self.cellHeight = 100;
    self.row = 1;
    self.isRoundWithFooterView = NO;;
    self.isRoundWithHeaerView = NO;;
    self.isRoundEnabled = NO;
     self.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
    self.sectionHeadersHovering = NO;
    self.sectionHeadersHoveringTopEdging = 0;
}

@end

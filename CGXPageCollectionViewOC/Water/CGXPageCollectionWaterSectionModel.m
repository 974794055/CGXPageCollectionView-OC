//
//  CGXPageCollectionWaterSectionModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionWaterSectionModel.h"

@implementation CGXPageCollectionWaterSectionModel


- (void)initializeData
{
    [super initializeData];
    self.row = 1;
    self.isParityFlow = NO;
    self.isParityAItem = NO;
    self.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
    self.sectionHeadersHovering = NO;
    self.sectionHeadersHoveringTopEdging = 0;
    self.isRoundWithFooterView = NO;
    self.isRoundWithHeaderView = NO;
    self.roundModel = [[CGXPageCollectionRoundModel alloc] init];
}
@end

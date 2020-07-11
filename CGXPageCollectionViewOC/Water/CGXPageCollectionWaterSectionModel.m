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
    
    self.isRoundEnabled = NO;
//    self.isCalculateOpenIrregularCell = NO;
    self.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
}
@end

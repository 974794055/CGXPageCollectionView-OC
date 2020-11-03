//
//  CGXPageCollectionHorizontalSectionModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionHorizontalSectionModel.h"

@implementation CGXPageCollectionHorizontalSectionModel
- (void)initializeData
{
    [super initializeData];
   self.row = 1;
   self.section = 1;
    self.sectionWidth = 0;
       self.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
}
@end

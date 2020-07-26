//
//  CGXPageCollectionHorizontalSectionModel.m
//  CGXPageCollectionViewOC
//
//  Created by MacMini-1 on 2020/7/8.
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

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
   
    self.sectionWidth = 0;
        self.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
}

//- (void)initWithFooterClass:(Class)footerClass IsXib:(BOOL)isXib
//{
//    [super initWithFooterClass:footerClass IsXib:isXib];
//}
//- (void)initWithHeaderClass:(Class)headerClass IsXib:(BOOL)isXib
//{
//    [super initWithHeaderClass:headerClass IsXib:isXib];
//}
@end

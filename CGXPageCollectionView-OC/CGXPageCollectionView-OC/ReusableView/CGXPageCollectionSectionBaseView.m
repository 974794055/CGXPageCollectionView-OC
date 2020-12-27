//
//  CGXPageCollectionSectionBaseView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionSectionBaseView.h"

@implementation CGXPageCollectionSectionBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self initializeViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
         [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    
}
- (void)updateWithCGXCollectionViewFooterViewModel:(CGXPageCollectionBaseSectionModel *)sectionModel InSection:(NSInteger)section
{
    self.sectionModel=(CGXPageCollectionGeneralSectionModel *)sectionModel;
}
- (void)updateWithCGXCollectionViewHeaderViewModel:(CGXPageCollectionBaseSectionModel *)sectionModel InSection:(NSInteger)section
{
    self.sectionModel=(CGXPageCollectionGeneralSectionModel *)sectionModel;
}
@end

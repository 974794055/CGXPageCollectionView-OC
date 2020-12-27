//
//  CGXPageCollectionBaseCell.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseCell.h"


@interface CGXPageCollectionBaseCell ()


@end

@implementation CGXPageCollectionBaseCell

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
//    self.contentView.layer.masksToBounds = YES;
//    self.contentView.layer.borderColor = [[UIColor redColor] CGColor];
//    self.contentView.layer.borderWidth = 1;
//    self.contentView.layer.cornerRadius = 4;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];

}
- (void)updateWithCGXPageCollectionCellModel:(CGXPageCollectionBaseRowModel *)cellModel AtIndex:(NSInteger)index
{
    self.cellModel = cellModel;
    self.index = index;
    self.contentView.backgroundColor = cellModel.cellColor;
}
@end

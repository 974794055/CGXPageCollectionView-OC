//
//  CGXPageCollectionTextCell.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionTextCell.h"

@interface CGXPageCollectionTextCell ()

@property (nonatomic , strong) NSLayoutConstraint *top;
@property (nonatomic , strong) NSLayoutConstraint *bottom;
@property (nonatomic , strong) NSLayoutConstraint *left;
@property (nonatomic , strong) NSLayoutConstraint *right;

@end

@implementation CGXPageCollectionTextCell

- (void)initializeViews
{
    [super initializeViews];
    
    self.titleLabel  =[[UILabel alloc] init];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.layer.masksToBounds = YES;
    self.titleLabel.layer.borderWidth = 0;
    self.titleLabel.layer.borderColor = [UIColor colorWithWhite:0.93 alpha:1].CGColor;
    self.titleLabel.layer.cornerRadius = 4;
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.top = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:0];
    self.left = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.contentView
                                             attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    self.right = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    self.bottom = [NSLayoutConstraint constraintWithItem:self.titleLabel
                                               attribute:NSLayoutAttributeBottom
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:self.contentView
                                               attribute:NSLayoutAttributeBottom
                                              multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.top];
    [self.contentView addConstraint:self.left];
    [self.contentView addConstraint:self.right];
    [self.contentView addConstraint:self.bottom];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.top.constant = 0;
    self.right.constant = 0;
    self.left.constant = 0;
    self.bottom.constant = 0;
}

- (void)updateWithCGXPageCollectionCellModel:(CGXPageCollectionBaseRowModel *)cellModel AtIndex:(NSInteger)index
{
    self.titleLabel.text = [NSString stringWithFormat:@"%ld",index];
    self.top.constant = 0;
    self.right.constant = 0;
    self.left.constant = 0;
    self.bottom.constant = 0;
}
@end

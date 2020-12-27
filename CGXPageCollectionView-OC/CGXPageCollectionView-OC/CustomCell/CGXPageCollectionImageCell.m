//
//  CGXPageCollectionImageCell.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionImageCell.h"

@interface CGXPageCollectionImageCell ()

@property (nonatomic , strong) NSLayoutConstraint *top;
@property (nonatomic , strong) NSLayoutConstraint *bottom;
@property (nonatomic , strong) NSLayoutConstraint *left;
@property (nonatomic , strong) NSLayoutConstraint *right;

@end

@implementation CGXPageCollectionImageCell

- (void)initializeViews
{
    [super initializeViews];
    self.picImageView = [[UIImageView alloc]init];
    self.picImageView.layer.masksToBounds = YES;
    self.picImageView.clipsToBounds = YES;
    self.picImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.picImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.picImageView];
    
    self.top = [NSLayoutConstraint constraintWithItem:self.picImageView
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:0];
    self.left = [NSLayoutConstraint constraintWithItem:self.picImageView
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.contentView
                                             attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    self.right = [NSLayoutConstraint constraintWithItem:self.picImageView
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    self.bottom = [NSLayoutConstraint constraintWithItem:self.picImageView
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
    [super updateWithCGXPageCollectionCellModel:cellModel AtIndex:index];
    self.top.constant = 0;
    self.right.constant = 0;
    self.left.constant = 0;
    self.bottom.constant = 0;
}
@end

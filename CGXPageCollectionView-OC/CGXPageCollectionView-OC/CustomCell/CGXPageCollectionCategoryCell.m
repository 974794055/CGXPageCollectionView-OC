//
//  CGXPageCollectionCategoryCell.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionCategoryCell.h"

@interface CGXPageCollectionCategoryCell ()

@property (nonatomic , strong) NSLayoutConstraint *bottom;
@property (nonatomic , strong) NSLayoutConstraint *left;
@property (nonatomic , strong) NSLayoutConstraint *right;
@property (nonatomic , strong) NSLayoutConstraint *titleHeight;


@property (nonatomic , strong) NSLayoutConstraint *imagetop;
@property (nonatomic , strong) NSLayoutConstraint *imagebottom;
@property (nonatomic , strong) NSLayoutConstraint *imageleft;
@property (nonatomic , strong) NSLayoutConstraint *imageright;

@end

@implementation CGXPageCollectionCategoryCell

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
    
    self.picImageView = [[UIImageView alloc]init];
    self.picImageView.layer.masksToBounds = YES;
    self.picImageView.clipsToBounds = YES;
    self.picImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.picImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.picImageView];
    
    
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

    [self.contentView addConstraint:self.left];
    [self.contentView addConstraint:self.right];
    [self.contentView addConstraint:self.bottom];
    
    self.titleHeight = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:30];
    [self.titleLabel addConstraint:self.titleHeight];
    
    
    self.imagetop = [NSLayoutConstraint constraintWithItem:self.picImageView
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:0];
    self.imageleft = [NSLayoutConstraint constraintWithItem:self.picImageView
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.contentView
                                             attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    self.imageright = [NSLayoutConstraint constraintWithItem:self.picImageView
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    self.imagebottom = [NSLayoutConstraint constraintWithItem:self.picImageView
                                               attribute:NSLayoutAttributeBottom
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:self.titleLabel
                                               attribute:NSLayoutAttributeTop
                                              multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.imagetop];
    [self.contentView addConstraint:self.imageleft];
    [self.contentView addConstraint:self.imageright];
    [self.contentView addConstraint:self.imagebottom];
    
    
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}

- (void)updateWithCGXPageCollectionCellModel:(CGXPageCollectionBaseRowModel *)cellModel AtIndex:(NSInteger)index
{
    self.titleLabel.text = [NSString stringWithFormat:@"%ld",index];
    self.picImageView.backgroundColor = [UIColor blackColor];
    
    self.titleHeight.constant = 30;
    self.right.constant = 0;
    self.left.constant = 0;
    self.bottom.constant = 0;
    
    self.imageright.constant = 0;
    self.imageleft.constant = 0;
    self.imagetop.constant = 0;
    self.imagebottom.constant = 0;
}

@end

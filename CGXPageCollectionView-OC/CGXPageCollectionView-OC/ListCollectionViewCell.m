//
//  ListCollectionViewCell.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/12/26.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "ListCollectionViewCell.h"
@interface ListCollectionViewCell()
@property (nonatomic , strong) NSLayoutConstraint *top;
@property (nonatomic , strong) NSLayoutConstraint *bottom;
@property (nonatomic , strong) NSLayoutConstraint *left;
@property (nonatomic , strong) NSLayoutConstraint *right;
@end
@implementation ListCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = RandomColor;
        

        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.adjustsFontSizeToFitWidth=YES;
        [self.contentView addSubview:self.titleLabel];
        self.top =  [NSLayoutConstraint constraintWithItem:_titleLabel
                                      attribute:NSLayoutAttributeTop
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeTop
                                     multiplier:1.0
                                                  constant:0];

         self.left = [NSLayoutConstraint constraintWithItem:_titleLabel
                                      attribute:NSLayoutAttributeLeft
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeLeft
                                     multiplier:1.0
                                                  constant:0];

         self.bottom = [NSLayoutConstraint constraintWithItem:_titleLabel
                                      attribute:NSLayoutAttributeBottom
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeBottom
                                     multiplier:1.0
                                       constant:0];

         self.right = [NSLayoutConstraint constraintWithItem:_titleLabel
                                      attribute:NSLayoutAttributeRight
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:self
                                      attribute:NSLayoutAttributeRight
                                     multiplier:1
                                       constant:0];
         [self addConstraint:self.top];
         [self addConstraint:self.bottom];
         [self addConstraint:self.left];
         [self addConstraint:self.right];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.right.constant = 0;
    self.left.constant = 0;
    self.top.constant = 0;
    self.bottom.constant = 0;
}
@end

//
//  CGXPageCollectionSectionImageView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionSectionImageView.h"
@interface CGXPageCollectionSectionImageView()
@property (nonatomic , strong) NSLayoutConstraint *top;
@property (nonatomic , strong) NSLayoutConstraint *bottom;
@property (nonatomic , strong) NSLayoutConstraint *left;
@property (nonatomic , strong) NSLayoutConstraint *right;
@end
@implementation CGXPageCollectionSectionImageView
- (void)initializeViews
{
    [super initializeViews];
    _picImageView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        imageView;
    });

   self.top =  [NSLayoutConstraint constraintWithItem:_picImageView
                                 attribute:NSLayoutAttributeTop
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeTop
                                multiplier:1.0
                                             constant:0];

    self.left = [NSLayoutConstraint constraintWithItem:_picImageView
                                 attribute:NSLayoutAttributeLeft
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1.0
                                             constant:0];

    self.bottom = [NSLayoutConstraint constraintWithItem:_picImageView
                                 attribute:NSLayoutAttributeBottom
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self
                                 attribute:NSLayoutAttributeBottom
                                multiplier:1.0
                                  constant:0];

    self.right = [NSLayoutConstraint constraintWithItem:_picImageView
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
- (void)layoutSubviews
{
    [super layoutSubviews];

    self.right.constant = 0;
    self.left.constant = 0;
    self.top.constant = 0;
    self.bottom.constant = 0;
}

- (void)updateWithCGXCollectionViewFooterViewModel:(CGXPageCollectionBaseSectionModel *)sectionModel InSection:(NSInteger)section
{
    [super updateWithCGXCollectionViewFooterViewModel:sectionModel InSection:section];
    
    self.right.constant = 0;
    self.left.constant = 0;
    self.top.constant = 0;
    self.bottom.constant = 0;
}
- (void)updateWithCGXCollectionViewHeaderViewModel:(CGXPageCollectionBaseSectionModel *)sectionModel InSection:(NSInteger)section
{
    [super updateWithCGXCollectionViewHeaderViewModel:sectionModel InSection:section];
    
    self.right.constant = 0;
    self.left.constant = 0;
    self.top.constant = 0;
    self.bottom.constant = 0;
}
@end

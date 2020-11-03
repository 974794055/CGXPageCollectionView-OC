//
//  CGXPageCollectionReusableImageView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionReusableImageView.h"

@implementation CGXPageCollectionReusableImageView
- (void)initializeViews
{
    [super initializeViews];
    _picImageView = ({
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:imageView];
        imageView;
    });
    [self initLayout];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self initLayout];
}
- (void)initLayout{
    
    [self addConstraints:@[
       //tableview constraints
       [NSLayoutConstraint constraintWithItem:_picImageView
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeTop
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:_picImageView
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeLeft
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:_picImageView
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeBottom
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:_picImageView
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeRight
                                   multiplier:1
                                     constant:0],

    ]];
}
@end

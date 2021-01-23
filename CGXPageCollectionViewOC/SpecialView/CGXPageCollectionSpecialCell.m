//
//  CGXPageCollectionSpecialCell.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionSpecialCell.h"

@interface CGXPageCollectionSpecialCell ()

@property (nonatomic , strong) NSLayoutConstraint *hotPicTop;
@property (nonatomic , strong) NSLayoutConstraint *hotPicleft;
@property (nonatomic , strong) NSLayoutConstraint *hotPicRight;
@property (nonatomic , strong) NSLayoutConstraint *hotPicBottom;

@end
@implementation CGXPageCollectionSpecialCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
    }
    return self;
}
- (void)initializeViews
{
    
    self.hotImageView = [[UIImageView alloc] init];
    self.hotImageView.layer.masksToBounds = YES;
    self.hotImageView.clipsToBounds = YES;
    self.hotImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.hotImageView];
    [self.contentView sendSubviewToBack:self.hotImageView];
    self.hotImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    self.hotPicTop = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    self.hotPicleft = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    self.hotPicRight = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    self.hotPicBottom = [NSLayoutConstraint constraintWithItem:self.hotImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.hotPicTop];
    [self.contentView addConstraint:self.hotPicleft];
    [self.contentView addConstraint:self.hotPicRight];
    [self.contentView addConstraint:self.hotPicBottom];
    
    self.contentView.layer.masksToBounds = YES;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];

}

- (void)updateWithModel:(CGXPageCollectionSpecialModel*)model AtIndex:(NSInteger)index
{
    self.contentView.backgroundColor = model.itemColor;
    self.hotPicTop.constant = 0;
    self.hotPicleft.constant = 0;
    self.hotPicRight.constant = 0;
    self.hotPicBottom.constant = 0;
    if ([model.itemImageStr hasPrefix:@"http:"] || [model.itemImageStr hasPrefix:@"https:"]) {
        __weak typeof(self) weakSelf = self;
        if (model.loadImageCallback) {
            model.loadImageCallback(weakSelf.hotImageView, [NSURL URLWithString:model.itemImageStr]);
        }
    } else{
        UIImage *image = [UIImage imageNamed:model.itemImageStr];
        if (!image) {
            image = [UIImage imageWithContentsOfFile:model.itemImageStr];
        }
        self.hotImageView.image = image;
    }
    self.contentView.layer.borderColor = [model.itemBorderColor CGColor];
    self.contentView.layer.borderWidth = model.itemBorderWidth;
    self.contentView.layer.cornerRadius = model.itemBorderRadius;
}
@end

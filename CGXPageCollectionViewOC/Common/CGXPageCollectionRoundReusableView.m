//
//  CGXPageCollectionRoundReusableView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionRoundReusableView.h"
@interface CGXPageCollectionRoundReusableView()

@property (nonatomic,strong) UIImageView *bgImageView;

@end

@implementation CGXPageCollectionRoundReusableView

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
    self.bgImageView = [[UIImageView alloc] init];
    [self addSubview:self.bgImageView];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.bgImageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    CGXPageCollectionRoundLayoutAttributes *attr = (CGXPageCollectionRoundLayoutAttributes *)layoutAttributes;
    _myCacheAttr = attr;
    [self toChangeCollectionReusableViewRoundInfoWithLayoutAttributes:attr];
}
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    [self toChangeCollectionReusableViewRoundInfoWithLayoutAttributes:_myCacheAttr];
}

-(void)toChangeCollectionReusableViewRoundInfoWithLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes
{
    NSLog(@"self.bgImageView:%@" , self.bgImageView);
    CGXPageCollectionRoundLayoutAttributes *attr = (CGXPageCollectionRoundLayoutAttributes *)layoutAttributes;
    if (attr.myConfigModel) {
        CGXPageCollectionRoundModel *model = attr.myConfigModel;
        UIView *view = self;
        
        if (@available(iOS 13.0, *)) {
            view.layer.backgroundColor = [model.backgroundColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
        } else {
            view.layer.backgroundColor = model.backgroundColor.CGColor;
        }

        if (@available(iOS 13.0, *)) {
            view.layer.shadowColor = [model.shadowColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
        } else {
            view.layer.shadowColor = model.shadowColor.CGColor;
        }
        view.layer.shadowOffset = model.shadowOffset;
        view.layer.shadowOpacity = model.shadowOpacity;
        view.layer.shadowRadius = model.shadowRadius;
        view.layer.cornerRadius = model.cornerRadius;
        view.layer.borderWidth = model.borderWidth;
        
        if (@available(iOS 13.0, *)) {
            view.layer.borderColor = [model.borderColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
        } else {
            view.layer.borderColor = model.borderColor.CGColor;
        }
       
       self.backgroundColor = model.backgroundColor;
        
    }
}


@end

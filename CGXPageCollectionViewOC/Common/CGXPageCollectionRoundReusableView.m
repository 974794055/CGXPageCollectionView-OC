//
//  CGXPageCollectionRoundReusableView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionRoundReusableView.h"
#import "UIImage+CGXPageCollection.h"

@interface CGXPageCollectionRoundReusableView()

@property (nonatomic , strong) UIImageView *bgImageView;

@end

@implementation CGXPageCollectionRoundReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bgImageView = [[UIImageView alloc]init];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.bgImageView.clipsToBounds = YES;
        self.bgImageView.layer.masksToBounds = YES; // 裁剪
        self.bgImageView.layer.shouldRasterize = YES; // 缓存
        [self addSubview:self.bgImageView];
        
    }
    return self;
}
- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    
    self.bgImageView.frame = self.bounds;

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
    CGXPageCollectionRoundLayoutAttributes *attr = (CGXPageCollectionRoundLayoutAttributes *)layoutAttributes;
    if (attr.myConfigModel) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
      
        CGXPageCollectionRoundModel *model = attr.myConfigModel;
        UIImage *bgImage = [UIImage gx_pageImageWithColor:model.backgroundColor];
        if (model.bgImage) {
            bgImage = model.bgImage;
        }
        UIColor *bgCOlor = model.backgroundColor;
        if (@available(iOS 13.0, *)) {
            self.bgImageView.layer.backgroundColor = [bgCOlor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
        } else {
            self.bgImageView.layer.backgroundColor = bgCOlor.CGColor;
        }
        self.bgImageView.backgroundColor = bgCOlor;
        self.bgImageView.image = bgImage;

        if (@available(iOS 13.0, *)) {
            self.bgImageView.layer.borderColor = [model.borderColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
            self.layer.shadowColor = [model.shadowColor resolvedColorWithTraitCollection:self.traitCollection].CGColor;
        } else {
            self.bgImageView.layer.borderColor = model.borderColor.CGColor;
            self.layer.shadowColor = model.shadowColor.CGColor;
        }
        self.layer.shadowOffset = model.shadowOffset;
        self.layer.shadowOpacity = model.shadowOpacity;
        self.layer.shadowRadius = model.shadowRadius;
        self.bgImageView.layer.cornerRadius = model.cornerRadius;
        self.bgImageView.layer.borderWidth = model.borderWidth;

        [CATransaction commit];
        
    }
}




@end

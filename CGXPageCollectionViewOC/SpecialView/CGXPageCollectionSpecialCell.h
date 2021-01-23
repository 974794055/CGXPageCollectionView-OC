//
//  CGXPageCollectionSpecialCell.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionSpecialModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionSpecialCell : UICollectionViewCell

@property (nonatomic , strong) UIImageView *hotImageView;

- (void)updateWithModel:(CGXPageCollectionSpecialModel*)model AtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

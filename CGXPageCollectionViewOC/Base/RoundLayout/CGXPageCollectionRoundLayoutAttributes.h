//
//  CGXPageCollectionRoundLayoutAttributes.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionRoundModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionRoundLayoutAttributes : UICollectionViewLayoutAttributes

//间距
@property (nonatomic, assign) UIEdgeInsets borderEdgeInsets;
@property (nonatomic, strong) CGXPageCollectionRoundModel *myConfigModel;
@end

NS_ASSUME_NONNULL_END

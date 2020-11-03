//
//  CGXPageCollectionRoundReusableView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionRoundLayoutAttributes.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionRoundReusableView : UICollectionReusableView
@property (weak, nonatomic) CGXPageCollectionRoundLayoutAttributes *myCacheAttr;
@end

NS_ASSUME_NONNULL_END

//
//  HeaderReusableView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionUpdateHeaderDelegate.h"
#import "CGXPageCollectionGeneralSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface HeaderReusableView : UICollectionReusableView<CGXPageCollectionUpdateHeaderDelegate>
@property (strong, nonatomic) UILabel *myLabel;
@end

NS_ASSUME_NONNULL_END

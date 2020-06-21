//
//  FooterRoundReusableView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionUpdateFooterDelegate.h"
#import "CGXPageCollectionGeneralSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FooterRoundReusableView : UICollectionReusableView<CGXPageCollectionUpdateFooterDelegate>
@property (strong, nonatomic) UILabel *myLabel;

@end

NS_ASSUME_NONNULL_END

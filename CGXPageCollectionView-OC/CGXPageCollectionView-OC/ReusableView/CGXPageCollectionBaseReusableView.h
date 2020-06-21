//
//  CGXPageCollectionBaseReusableView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionBaseSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionBaseReusableView : UICollectionReusableView

@property (nonatomic , strong) CGXPageCollectionBaseSectionModel *sectionModel;

@property (nonatomic , assign) NSInteger index;

- (void)initializeViews NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END

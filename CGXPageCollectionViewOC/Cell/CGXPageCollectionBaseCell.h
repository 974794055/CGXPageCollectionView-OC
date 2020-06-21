//
//  CGXPageCollectionBaseCell.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionBaseRowModel.h"
#import "CGXPageCollectionUpdateCellDelegate.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionBaseCell : UICollectionViewCell<CGXPageCollectionUpdateCellDelegate>

@property (nonatomic , strong) CGXPageCollectionBaseRowModel *cellModel;

@property (nonatomic , assign) NSInteger index;


- (void)initializeViews NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END

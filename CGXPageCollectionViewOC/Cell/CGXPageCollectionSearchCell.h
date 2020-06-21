//
//  CGXPageCollectionSearchCell.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionSearchCell : CGXPageCollectionBaseCell<UISearchBarDelegate>

@property (nonatomic , strong) UISearchBar *searchBar;

@end

NS_ASSUME_NONNULL_END

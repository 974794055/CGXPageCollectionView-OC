//
//  CGXPageCollectionUpdateHeaderDelegate.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CGXPageCollectionBaseSectionModel;
NS_ASSUME_NONNULL_BEGIN

@protocol CGXPageCollectionUpdateHeaderDelegate <NSObject>
@required

@optional

- (void)updateWithCGXCollectionViewHeaderViewModel:(CGXPageCollectionBaseSectionModel *)sectionModel InSection:(NSInteger)section;

@end

NS_ASSUME_NONNULL_END

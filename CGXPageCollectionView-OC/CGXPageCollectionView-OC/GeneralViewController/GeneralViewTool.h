//
//  GeneralViewTool.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/7/25.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GeneralViewTool : NSObject

+ (CGXPageCollectionGeneralSectionModel *)sectionModel;

+ (CGXPageCollectionRoundModel *)roundModel;

+ (CGXPageCollectionHeaderModel *)headerModel;

+ (CGXPageCollectionFooterModel *)footerModel;

//插入一个分区
+ (CGXPageCollectionGeneralSectionModel *)insertSectionModel;
@end

NS_ASSUME_NONNULL_END

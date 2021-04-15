//
//  CGXPageCollectionBaseSectionModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CGXPageCollectionBaseRowModel.h"
#import "CGXPageCollectionHeaderModel.h"
#import "CGXPageCollectionFooterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionBaseSectionModel : NSObject

- (void)initializeData NS_REQUIRES_SUPER;

/*头分区*/
@property (nonatomic , strong) CGXPageCollectionHeaderModel *headerModel;
/*脚分区*/
@property (nonatomic , strong) CGXPageCollectionFooterModel *footerModel;

@property (nonatomic,strong) NSMutableArray<CGXPageCollectionBaseRowModel *> *rowArray;
@property (nonatomic , assign) NSInteger minimumLineSpacing;//默认是10
@property (nonatomic , assign) NSInteger minimumInteritemSpacing;//默认是10
@property (nonatomic) UIEdgeInsets insets;//默认是10
@property (nonatomic , strong) id dataModel;//原始数据


@end

NS_ASSUME_NONNULL_END

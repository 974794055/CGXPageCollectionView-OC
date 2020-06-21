//
//  CGXPageCollectionBaseRowModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseRowModel.h"

@interface CGXPageCollectionBaseRowModel()

//默认不适用xib
@property (nonatomic , assign,readwrite) BOOL isXib;
@property(nonatomic, strong,readwrite) Class cellClass;

@end

@implementation CGXPageCollectionBaseRowModel

- (NSString *)cellIdentifier {
    return [NSString stringWithFormat:@"%@", self.cellClass];
}

/*
 初始化方法
 */
- (instancetype)initWithCelllass:(Class)cellClass IsXib:(BOOL)isXib
{
    self = [super init];
    if (self) {
        self.isXib = NO;
        self.cellColor = [UIColor whiteColor];
        self.cellHeight = 100;
        self.isSelectCell = NO;
        self.cellClass = cellClass;
        self.isLine = NO;
    }
    return self;
}
@end


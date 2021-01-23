//
//  CGXPageCollectionSpecialModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionSpecialModel.h"

@implementation CGXPageCollectionSpecialModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemColor = [UIColor whiteColor];
        self.itemBorderColor = [UIColor whiteColor];
        self.itemBorderWidth = 0;
        self.itemBorderRadius = 0;
    }
    return self;
}
@end

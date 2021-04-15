//
//  CGXPageCollectionRoundLayoutAttributes.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionRoundLayoutAttributes.h"

@implementation CGXPageCollectionRoundLayoutAttributes

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.borderEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.myConfigModel = [[CGXPageCollectionRoundModel alloc] init];
    }
    return self;
}
@end

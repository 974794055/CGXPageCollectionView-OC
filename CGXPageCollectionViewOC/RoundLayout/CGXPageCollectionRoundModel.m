//
//  CGXPageCollectionRoundModel.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionRoundModel.h"

@implementation CGXPageCollectionRoundModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cornerRadius = 10;
        self.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
        self.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        self.shadowOffset = CGSizeMake(0,0);
        self.shadowOpacity = 0;
        self.shadowRadius = 0;
        self.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
        self.borderWidth = 1.0;
    }
    return self;
}
@end

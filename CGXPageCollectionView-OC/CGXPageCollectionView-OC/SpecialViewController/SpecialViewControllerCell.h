//
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CGXPageCollectionSpecialView.h"
NS_ASSUME_NONNULL_BEGIN

@interface SpecialViewControllerCell : UICollectionViewCell
@property (nonatomic , strong) CGXPageCollectionSpecialView *specialView;
- (void)updateWith:(NSIndexPath *)indexPath;

@property (nonatomic , assign)CGFloat viewHeight;
@end

NS_ASSUME_NONNULL_END

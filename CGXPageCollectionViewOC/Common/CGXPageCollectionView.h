//
//  CGXPageCollectionView.h
//  CGXPageCollectionViewOC
//
//  Created by CGX on 2020/7/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CGXPageCollectionView;

@protocol CGXPageCollectionViewGestureDelegate <NSObject>
@optional
- (BOOL)gx_PageCollectionView:(CGXPageCollectionView *)collectionView gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer;
- (BOOL)gx_PageCollectionView:(CGXPageCollectionView *)collectionView gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end
@interface CGXPageCollectionView : UICollectionView
@property (nonatomic, weak) id<CGXPageCollectionViewGestureDelegate> gestureDelegate;
@end

NS_ASSUME_NONNULL_END

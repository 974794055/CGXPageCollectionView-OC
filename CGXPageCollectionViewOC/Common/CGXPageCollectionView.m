//
//  CGXPageCollectionView.m
//  CGXPageCollectionViewOC
//
//  Created by CGX on 2020/7/26.
//

#import "CGXPageCollectionView.h"
@interface CGXPageCollectionView ()<UIGestureRecognizerDelegate>

@end

@implementation CGXPageCollectionView

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.gestureDelegate && [self.gestureDelegate respondsToSelector:@selector(gx_PageCollectionView:gestureRecognizerShouldBegin:)]) {
        return [self.gestureDelegate gx_PageCollectionView:self gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.gestureDelegate && [self.gestureDelegate respondsToSelector:@selector(gx_PageCollectionView:gestureRecognizer:shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) {
        return [self.gestureDelegate gx_PageCollectionView:self gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return NO;
}
@end

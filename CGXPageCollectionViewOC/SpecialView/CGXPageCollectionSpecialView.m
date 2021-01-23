//
//  CGXPageCollectionSpecialView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionSpecialView.h"
#import "CGXPageCollectionSpecialCell.h"

@interface CGXPageCollectionSpecialView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CGXPageCollectionSpecialFlowLayoutDelegate>


@property (nonatomic, strong) CGXPageCollectionSpecialFlowLayout *flowLayout;
@property (nonatomic, strong,readwrite) NSMutableArray<CGXPageCollectionSpecialModel *> *dataArray;
@end

@implementation CGXPageCollectionSpecialView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.zoomSpace = 0.5;
        self.headerHeight = 0;
        self.headerColor = [UIColor whiteColor];
        self.footerHeight = 0;
        self.footerColor = [UIColor whiteColor];
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
        self.flowLayout = [[CGXPageCollectionSpecialFlowLayout alloc] init];
        self.flowLayout.delegate = self;
        self.flowLayout.zoomSpace = self.zoomSpace;
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        [_collectionView registerClass:[CGXPageCollectionSpecialCell class] forCellWithReuseIdentifier:NSStringFromClass([CGXPageCollectionSpecialCell class])];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.scrollEnabled = NO;
        _collectionView.bounces = NO;
        [self addSubview:_collectionView];
        [self.collectionView reloadData];
    }
    return self;
}


- (void)setZoomSpace:(CGFloat)zoomSpace
{
    _zoomSpace = zoomSpace;
    self.flowLayout.zoomSpace = zoomSpace;
    self.collectionView.collectionViewLayout = self.flowLayout;
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    UIResponder *next = newSuperview;
    while (next != nil) {
        if ([next isKindOfClass:[UIViewController class]]) {
            ((UIViewController *)next).automaticallyAdjustsScrollViewInsets = NO;
            break;
        }
        next = next.nextResponder;
    }
}
- (NSMutableArray<CGXPageCollectionSpecialModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    [self.collectionView reloadData];
    

//    CGXPageCollectionSpecialFlowLayout *layout = (CGXPageCollectionSpecialFlowLayout *)self.collectionView.collectionViewLayout;
//    [self.flowLayout invalidateLayout];
//    self.collectionView.frame = self.bounds;
//    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) {
//        [self invalidateIntrinsicContentSize];
//    }
//    CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
//    if (height != 0 && height != self.bounds.size.height) {
//        CGRect frame = self.frame;
//        frame.size.height = height;
//        self.frame = frame;
//        self.collectionView.frame = self.bounds;
//        if (self.delegate && [self.delegate respondsToSelector:@selector(hotBranndSpecialView:WithViewHeight:)]) {
//            [self.delegate hotBranndSpecialView:self WithViewHeight:height];
//        }
//    }
//   
//    NSArray *neeeArrf = [self.flowLayout.attrsArr sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        UICollectionViewLayoutAttributes *att1 = (UICollectionViewLayoutAttributes *)obj1;
//        UICollectionViewLayoutAttributes *att2 = (UICollectionViewLayoutAttributes *)obj2;
//        if (CGRectGetMaxY(att1.frame) > CGRectGetMaxY(att2.frame)) {
//            return NSOrderedDescending;//降序
//        }else if (CGRectGetMaxY(att1.frame) < CGRectGetMaxY(att2.frame))
//        {
//            return NSOrderedAscending;//升序
//        }else
//        {
//            return NSOrderedSame;//相等
//        }
//    }];
//    NSMutableArray *heightArr = [NSMutableArray array];
//    for (UICollectionViewLayoutAttributes *att1 in neeeArrf) {
////        NSLog(@"%f" ,CGRectGetMaxY(att1.frame));
//        [heightArr addObject:@(CGRectGetMaxY(att1.frame))];
//    }
//    
//    CGFloat maxValue = [[heightArr valueForKeyPath:@"@max.floatValue"] floatValue];
////    CGFloat minValue = [[heightArr valueForKeyPath:@"@min.floatValue"] floatValue];
////    NSLog(@"maxValue:%f" ,maxValue);
////    NSLog(@"minValue:%f" ,minValue);
//    
//    CGFloat height = maxValue;
//    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), height);
//    if (self.delegate && [self.delegate respondsToSelector:@selector(hotBranndSpecialView:WithViewHeight:)]) {
//        [self.delegate hotBranndSpecialView:self WithViewHeight:height];
//    }
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return self.edgeInsets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return self.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), self.headerHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(CGRectGetWidth(collectionView.frame), self.footerHeight);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotBranndSpecialView:sizeForItemAtIndex:)]) {
        return [self.delegate hotBranndSpecialView:self sizeForItemAtIndex:indexPath.row];
    }
    return CGSizeMake(0, 0);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(hotBranndSpecialView:HeadViewAtIndex:)]) {
            UIView *headView = [self.delegate hotBranndSpecialView:self HeadViewAtIndex:indexPath.section];
            headView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            [view addSubview:headView];
        }
        view.backgroundColor = self.headerColor;
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        if (self.delegate && [self.delegate respondsToSelector:@selector(hotBranndSpecialView:FootViewAtIndex:)]) {
            UIView *footView = [self.delegate hotBranndSpecialView:self FootViewAtIndex:indexPath.section];
            footView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
            [view addSubview:footView];
        }
        view.backgroundColor = self.footerColor;
        return view;
    }
}
- (CGXPageCollectionSpecialType)collectionView:(UICollectionView *)collectionView TypeForInSection:(NSInteger)section
{
    return self.showType;
}
- (UICollectionViewLayoutAttributes*)collectionView:(UICollectionView *)collectionView
                                         Attributes:(UICollectionViewLayoutAttributes *)Attributes
                                            AtIndex:(NSInteger)index
{
    UICollectionViewLayoutAttributes *layoutAttributes = Attributes;
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotBranndSpecialView:Attributes:AtIndex:)]) {
        layoutAttributes = [self.delegate hotBranndSpecialView:self Attributes:Attributes AtIndex:index];
    }
    return layoutAttributes;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotBranndSpecialView:cellForItemAtIndex:)]) {
        return [self.delegate hotBranndSpecialView:self cellForItemAtIndex:indexPath.row];
    }
    CGXPageCollectionSpecialCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CGXPageCollectionSpecialCell class]) forIndexPath:indexPath];
    CGXPageCollectionSpecialModel *model = self.dataArray[indexPath.row];
    [cell updateWithModel:model AtIndex:indexPath.row];
    return cell;
}
#pragma mark - cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hotBranndSpecialView:didSelectItemAtIndex:)]) {
        [self.delegate hotBranndSpecialView:self didSelectItemAtIndex:indexPath.row];
    }
}
- (void)updateWithDataArray:(NSMutableArray<CGXPageCollectionSpecialModel *> *)dataArray
{
    [self.dataArray removeAllObjects];
    [self.dataArray addObjectsFromArray:dataArray];
    [self.collectionView reloadData];
}
- (void)updateWithModel:(CGXPageCollectionSpecialModel  *)model AtIndex:(NSInteger)index
{
    if (self.dataArray.count==0) {
        return;
    }
    if (index > self.dataArray.count) {
        return;
    }
    [self.dataArray replaceObjectAtIndex:index withObject:model];
    [self.collectionView reloadData];
}


- (void)registerCell:(Class)classCell IsXib:(BOOL)isXib
{
    if (![classCell isKindOfClass:[UICollectionViewCell class]]) {
        NSAssert(![classCell isKindOfClass:[UICollectionViewCell class]], @"注册cell的registerCellAry数组必须是UICollectionViewCell类型");
    }
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", classCell] bundle:nil] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@", classCell]];
        
    } else{
        [self.collectionView registerClass:classCell forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@", classCell]];
    }
}
@end

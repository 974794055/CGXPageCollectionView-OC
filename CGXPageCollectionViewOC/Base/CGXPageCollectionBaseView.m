//
//  CGXPageCollectionBaseView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseView.h"
#import <objc/runtime.h>
#import "UIView+CGXPageCollectionBaseViewTap.h"
#import "CGXPageCollectionBaseLayout.h"
#import "CGXPageCollectionTools.h"
@interface CGXPageCollectionBaseView()
@property (nonatomic,strong,readwrite) NSMutableArray<CGXPageCollectionBaseSectionModel *> *dataArray;//数据源数组

@property (nonatomic , assign) BOOL isDownRefresh;
@property (nonatomic , assign) NSInteger page;
@property (nonatomic , assign) BOOL isHaveNo;//是否有空
@property (nonatomic, assign, getter=isFirstLayoutSubviews) BOOL firstLayoutSubviews;
@end

@implementation CGXPageCollectionBaseView
- (void)dealloc
{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initializeData];
        [self initializeViews];
    }
    return self;
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
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //部分使用者为了适配不同的手机屏幕尺寸，JXCategoryView的宽高比要求保持一样，所以它的高度就会因为不同宽度的屏幕而不一样。计算出来的高度，有时候会是位数很长的浮点数，如果把这个高度设置给UICollectionView就会触发内部的一个错误。所以，为了规避这个问题，在这里对高度统一向下取整。
    //如果向下取整导致了你的页面异常，请自己重新设置JXCategoryView的高度，保证为整数即可。
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, floor(self.bounds.size.height));
    [self initLayoutFrame];
    self.collectionView.collectionViewLayout = [self preferredFlowLayout];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
    if (self.isFirstLayoutSubviews) {
        self.firstLayoutSubviews = NO;
        [self reloadData];
    }else {
        [self reloadData];
    }
    
    if (self.isAdaptive) {
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
        [layout invalidateLayout];
        self.collectionView.frame = self.bounds;
        if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) {
            [self invalidateIntrinsicContentSize];
        }
        CGFloat height = self.collectionView.collectionViewLayout.collectionViewContentSize.height;
        if (height != 0 && height != self.bounds.size.height) {
            CGRect frame = self.frame;
            frame.size.height = height;
            self.frame = frame;
            self.collectionView.frame = self.bounds;
            __weak typeof(self) weakSlef = self;
            if (self.heightBlock) {
                self.heightBlock(weakSlef,height);
            }
            if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:WithViewHeight:)]) {
                [self.viewDelegate gx_PageCollectionBaseView:self WithViewHeight:height];
            }
        }
    }
}
- (void)initLayoutFrame
{
    [self addConstraints:@[
       [NSLayoutConstraint constraintWithItem:self.collectionView
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeTop
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:self.collectionView
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeLeft
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:self.collectionView
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeBottom
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:self.collectionView
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeRight
                                   multiplier:1
                                     constant:0],

    ]];
}
- (NSMutableArray<CGXPageCollectionBaseSectionModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
}
- (void)reloadData
{
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];
}
- (void)initializeData
{
    self.firstLayoutSubviews = YES;
}

- (void)initializeViews
{
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:[self preferredFlowLayout]];
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //给collectionView注册头分区的Id
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    //给collection注册脚分区的id
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.collectionView];
}

- (UICollectionViewLayout *)preferredFlowLayout
{
    CGXPageCollectionBaseLayout *layout = [[CGXPageCollectionBaseLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}
- (UICollectionReusableView *)refreshHeaderSection:(NSInteger)section Header:(UICollectionReusableView *)headerView
{
    return headerView;
}
- (UICollectionReusableView *)refreshFooterSection:(NSInteger)section Footer:(UICollectionReusableView *)footerView
{
    return footerView;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.rowArray.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.insets;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.minimumLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
       CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[section];
    return sectionModel.minimumInteritemSpacing;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[section];
    if (!sectionModel.footerModel.isHaveFooter) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(collectionView.bounds.size.width, sectionModel.footerModel.footerHeight);;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[section];
    if (!sectionModel.headerModel.isHaveHeader) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(collectionView.bounds.size.width, sectionModel.headerModel.headerHeight);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[indexPath.section];
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.headerModel.headerIdentifier forIndexPath:indexPath];
        if(view == nil) {
            view = [[NSClassFromString(sectionModel.headerModel.headerIdentifier) alloc] init];
        }
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        UICollectionReusableView *headview = (UICollectionReusableView *)[CGXPageCollectionTools createForClass:sectionModel.headerModel.headerIdentifier];
        headview.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        headview.backgroundColor = sectionModel.headerModel.headerBgColor;
        headview.tag = sectionModel.headerModel.headerTag;
        UICollectionReusableView *headerview = [self refreshHeaderSection:indexPath.section Header:headview];
        BOOL isHave = [headerview respondsToSelector:@selector(updateWithCGXCollectionViewHeaderViewModel:InSection:)];
        if (isHave == YES && [headerview conformsToProtocol:@protocol(CGXPageCollectionUpdateHeaderDelegate)]) {
            [(UICollectionReusableView<CGXPageCollectionUpdateHeaderDelegate> *)headerview updateWithCGXCollectionViewHeaderViewModel:sectionModel  InSection:indexPath.section];
        }
        if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:AtIndexPath:SectionHeaderView:)]) {
            [self.viewDelegate gx_PageCollectionBaseView:self AtIndexPath:indexPath SectionHeaderView:headerview];
        }
        if (sectionModel.headerModel.isHaveTap) {
            __weak typeof(self) headerviewSelf = self;
            [headerview addCGXPageCollectionTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
                if (headerviewSelf.viewDelegate && [headerviewSelf.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:TapHeaderViewAtIndex:)]) {
                    [headerviewSelf.viewDelegate gx_PageCollectionBaseView:headerviewSelf TapHeaderViewAtIndex:indexPath.section];
                }
            }];
        }
        [view addSubview:headerview];
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.footerModel.footerIdentifier forIndexPath:indexPath];
        if(view == nil) {
            view = [[NSClassFromString(sectionModel.footerModel.footerIdentifier) alloc] init];
        }
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        UICollectionReusableView *footview = (UICollectionReusableView *)[CGXPageCollectionTools createForClass:sectionModel.footerModel.footerIdentifier];
        footview.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        footview.backgroundColor = sectionModel.footerModel.footerBgColor;
        footview.tag = sectionModel.footerModel.footerTag;
        UICollectionReusableView *footerview = [self refreshFooterSection:indexPath.section Footer:footview];

        BOOL isHave = [footerview respondsToSelector:@selector(updateWithCGXCollectionViewFooterViewModel:InSection:)];
        if (isHave == YES && [footerview conformsToProtocol:@protocol(CGXPageCollectionUpdateFooterDelegate)]) {
            [(UICollectionReusableView<CGXPageCollectionUpdateFooterDelegate> *)footerview updateWithCGXCollectionViewFooterViewModel:sectionModel  InSection:indexPath.section];
        }
        if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:AtIndexPath:SectionFooterView:)]) {
            [self.viewDelegate gx_PageCollectionBaseView:self AtIndexPath:indexPath SectionFooterView:footerview];
        }
        if (sectionModel.footerModel.isHaveTap) {
            __weak typeof(self) footerviewSelf = self;
            [footerview addCGXPageCollectionTapGestureRecognizerWithDelegate:self Block:^(NSInteger tag) {
                if (footerviewSelf.viewDelegate && [footerviewSelf.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:TapFooterViewAtIndex:)]) {
                    [footerviewSelf.viewDelegate gx_PageCollectionBaseView:footerviewSelf TapFooterViewAtIndex:indexPath.section];
                }
            }];
        }
        [view addSubview:footerview];
        return view;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[indexPath.section];
    CGXPageCollectionBaseRowModel *itemModel = sectionModel.rowArray[indexPath.row];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:itemModel.cellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = itemModel.cellColor;
    BOOL isHave = [cell respondsToSelector:@selector(updateWithCGXPageCollectionCellModel:AtIndex:)];
    if (isHave == YES && [cell conformsToProtocol:@protocol(CGXPageCollectionUpdateCellDelegate)]) {
        [(UICollectionViewCell<CGXPageCollectionUpdateCellDelegate> *)cell updateWithCGXPageCollectionCellModel:itemModel  AtIndex:indexPath.row];
    }
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:Cell:cellForItemAtIndexPath:)]) {
        [self.viewDelegate gx_PageCollectionBaseView:self Cell:cell cellForItemAtIndexPath:indexPath];
    };
    return cell;
}
#pragma mark - cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:DidSelectItemAtIndexPath:)]) {
        [self.viewDelegate gx_PageCollectionBaseView:self DidSelectItemAtIndexPath:indexPath];
    };
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
- (void)registerFooter:(Class)footer IsXib:(BOOL)isXib
{
    if (![footer isKindOfClass:[UICollectionReusableView class]]) {
        NSAssert(![footer isKindOfClass:[UICollectionReusableView class]], @"注册cell的registerCellAry数组必须是UICollectionReusableView类型");
    }
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", footer] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[NSString stringWithFormat:@"%@", footer]];
    } else{
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[NSString stringWithFormat:@"%@", footer]];
    }
}
- (void)registerHeader:(Class)header IsXib:(BOOL)isXib
{
    if (![header isKindOfClass:[UICollectionReusableView class]]) {
        NSAssert(![header isKindOfClass:[UICollectionReusableView class]], @"注册cell的registerCellAry数组必须是UICollectionReusableView类型");
    }
    if (isXib) {
        [self.collectionView registerNib:[UINib nibWithNibName:[NSString stringWithFormat:@"%@", header] bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"%@", header]];
    } else{
        [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"%@", header]];
    }
}
/*
 加载数据 下拉调用
 */
- (void)loadData
{
    self.isDownRefresh = YES;
    self.page = 1;
    if (self.refresBlock) {
        self.refresBlock(self.isDownRefresh, self.page);
    }
}
/*
 加载更多数据 上拉调用
 */
- (void)loadMoreData
{
    self.isDownRefresh = NO;
    self.page++;
    if (self.refresBlock) {
        self.refresBlock(self.isDownRefresh, self.page);
    }
}
- (void)refreshSectionModel:(CGXPageCollectionBaseSectionModel *)baseSectionModel
{
    
}
/*
 array：数据源
 pageCount:每次加载的个数
 pageSize：每页个数。默认10个
 */
- (void)updateDataArray:(NSMutableArray<CGXPageCollectionBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page
{
    [self updateDataArray:array IsDownRefresh:isDownRefresh Page:page MaxPage:10];
}
/*
 array：数据源
 page:页数
 maxPage:每页返回最大值 默认20
 */
- (void)updateDataArray:(NSMutableArray<CGXPageCollectionBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page MaxPage:(NSInteger)maxPage
{
    self.page = page;
    self.isDownRefresh = isDownRefresh;
    if (isDownRefresh) {
        [self.dataArray removeAllObjects];
    }
    for (CGXPageCollectionBaseSectionModel *sectionModel in array) {
        [self refreshSectionModel:sectionModel];
        [self.dataArray addObject:sectionModel];
    }
    [self.collectionView reloadData];
    if (self.refresBlock) {
        self.refresBlock(array.count, maxPage);
    }
    [self setNeedsLayout];
    [self layoutIfNeeded];
}


/*
获取分区数据源
*/
- (CGXPageCollectionBaseSectionModel *)pullSection:(NSInteger)section
{
    if (section>self.dataArray.count || self.dataArray.count == 0) {
        return nil;
    }
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[section];
    return sectionModel;
}
/*
获取每个cell数据源
*/
- (CGXPageCollectionBaseRowModel *)pullSectionModel:(CGXPageCollectionBaseSectionModel *)sectionModel Row:(NSInteger)row
{
    if (row>sectionModel.rowArray.count || sectionModel.rowArray.count == 0) {
        return nil;
    }
    CGXPageCollectionBaseRowModel *itemModel = sectionModel.rowArray[row];
    return itemModel;
}

/*
 替换一个分区的数据源
 */
- (void)replaceObjectAtSection:(NSInteger)section withObject:(CGXPageCollectionBaseSectionModel *)sectionModel
{
    if (self.dataArray.count == 0) {
        return;
    }
    if (section>self.dataArray.count-1) {
        return;
    }
    if (!sectionModel) {
        return;
    }

    __weak typeof(self) viewSelf = self;
        [UIView animateWithDuration:0 animations:^{
            [viewSelf.collectionView performBatchUpdates:^{
                [self.dataArray replaceObjectAtIndex:section withObject:sectionModel];
                [viewSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
            } completion:^(BOOL finished) {
                [self.collectionView reloadData];
            }];
        }];
}
/*
 替换一个cell数据源
 */
- (void)replaceObjectAtSection:(NSInteger)section RowIndex:(NSInteger)row withObject:(CGXPageCollectionBaseRowModel *)rowModel;
{
    if (section>self.dataArray.count-1) {
        return;
    }
    CGXPageCollectionBaseSectionModel *sectionModel = [self pullSection:section];
    if (!sectionModel) {
        return;
    }
    if (row>sectionModel.rowArray.count-1) {
        return;
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    __weak typeof(self) viewSelf = self;
    [UIView animateWithDuration:0 animations:^{
        [viewSelf.collectionView performBatchUpdates:^{
            [sectionModel.rowArray replaceObjectAtIndex:row withObject:rowModel];
            [viewSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        } completion:^(BOOL finished) {
            [self.collectionView reloadData];
        }];
    }];
}
/*
 插入一个分区
 */
- (void)insertSections:(NSInteger)section withObject:(CGXPageCollectionBaseSectionModel *)sectionModel
{
    [self insertSections:section withObject:sectionModel Animation:NO];
}
- (void)insertSections:(NSInteger)section withObject:(CGXPageCollectionBaseSectionModel *)sectionModel Animation:(BOOL)animation
{
    if (!sectionModel) {
        return;
    }
    if (section>self.dataArray.count) {
        section = self.dataArray.count;
    }
    if (self.dataArray.count == 0) {
        section = 0;
    }
    
    __weak typeof(self) viewSelf = self;
    if (animation) {
        [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:section]];
        [self.dataArray insertObject:sectionModel atIndex:section];
        [self.collectionView reloadData];
    } else{
        [self.collectionView performBatchUpdates:^{
            [viewSelf.collectionView insertSections:[NSIndexSet indexSetWithIndex:section]];
            [self.dataArray insertObject:sectionModel atIndex:section];
        } completion:^(BOOL finished) {
            [self.collectionView reloadData];
        }];
    }
}

/*
 插入单行
 */
- (void)insertSections:(NSInteger)section RowIndex:(NSInteger)row withObject:(CGXPageCollectionBaseRowModel *)rowModel
{
    [self insertSections:section RowIndex:row withObject:rowModel Animation:NO];
}
- (void)insertSections:(NSInteger)section RowIndex:(NSInteger)row withObject:(CGXPageCollectionBaseRowModel *)rowModel Animation:(BOOL)animation
{
    if (self.dataArray.count == 0) {
        return;
    }
    if (section>self.dataArray.count) {
        return;
    }
    CGXPageCollectionBaseSectionModel *sectionModel = [self pullSection:section];
    if (row>sectionModel.rowArray.count) {
        row = sectionModel.rowArray.count;
    }
    
    NSIndexPath *indexPathNew = [NSIndexPath indexPathForRow:row inSection:section];
    __weak typeof(self) viewSelf = self;
    if (animation) {
        [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:indexPathNew, nil]];
        [sectionModel.rowArray insertObject:rowModel atIndex:row];
        [self.collectionView reloadData];
    } else{
        [self.collectionView performBatchUpdates:^{
            [viewSelf.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:indexPathNew, nil]];
            [sectionModel.rowArray insertObject:rowModel atIndex:row];
        } completion:^(BOOL finished) {
            [self.collectionView reloadData];
        }];
    }
    
}
////删除一个分区
- (void)deleteSections:(NSInteger)section
{
    [self deleteSections:section Animation:NO];
}
- (void)deleteSections:(NSInteger)section Animation:(BOOL)animation
{
    if (self.dataArray.count==0) {
        return;
    }
    if (section>self.dataArray.count-1) {
        return;
    }
    CGXPageCollectionBaseSectionModel *sectionModel  = self.dataArray[section];
    __weak typeof(self) viewSelf = self;
    
    if (animation) {
        [self.collectionView performBatchUpdates:^{
            [viewSelf.dataArray removeObject:sectionModel];
            [viewSelf.collectionView deleteSections:[NSIndexSet indexSetWithIndex:section]];
        } completion:^(BOOL finished) {
            [self.collectionView reloadData];
        }];
    } else{
        [viewSelf.dataArray removeObject:sectionModel];
        [self.collectionView reloadData];
    }
}
//删除单行
- (void)deleteItemsAtSection:(NSInteger)section RowIndex:(NSInteger)row
{
    [self deleteItemsAtSection:section RowIndex:row Animation:NO];
}
- (void)deleteItemsAtSection:(NSInteger)section RowIndex:(NSInteger)row Animation:(BOOL)animation
{
    if (self.dataArray.count==0) {
        return;
    }
    if (section>self.dataArray.count-1) {
        return;
    }
    NSIndexPath *indexPathNew = [NSIndexPath indexPathForRow:row inSection:section];
    CGXPageCollectionBaseSectionModel *sectionModel  = self.dataArray[indexPathNew.section];
    if (sectionModel.rowArray.count==0) {
        return;
    }
    if (row>sectionModel.rowArray.count-1) {
        return;
    }
    CGXPageCollectionBaseRowModel *itemModel  = sectionModel.rowArray[row];
    __weak typeof(self) viewSelf = self;
    
    if (animation) {
        [self.collectionView performBatchUpdates:^{
            if (sectionModel.rowArray.count==1) {
                [viewSelf.dataArray removeObject:sectionModel];
                [viewSelf.collectionView deleteSections:[NSIndexSet indexSetWithIndex:section]];
            } else{
                [sectionModel.rowArray removeObject:itemModel];
                [viewSelf.dataArray replaceObjectAtIndex:indexPathNew.section withObject:sectionModel];
                [viewSelf.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObjects:indexPathNew, nil]];
            }
        } completion:^(BOOL finished) {
            [self.collectionView reloadData];
        }];
    } else{
        if (sectionModel.rowArray.count==1) {
            [viewSelf.dataArray removeObject:sectionModel];
        } else{
            [sectionModel.rowArray removeObject:itemModel];
            [viewSelf.dataArray replaceObjectAtIndex:indexPathNew.section withObject:sectionModel];
        }
        [self.collectionView reloadData];
    }
}
//删除所有数据源
- (void)deleteAll
{
    [self.dataArray removeAllObjects];
    [self.collectionView reloadData];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end

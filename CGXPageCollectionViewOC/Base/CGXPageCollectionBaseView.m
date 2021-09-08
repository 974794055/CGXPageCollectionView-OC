//
//  CGXPageCollectionBaseView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionBaseView.h"
#import <objc/runtime.h>
#import "UIView+CGXPageCollectionTap.h"
#import "CGXPageCollectionBaseLayout.h"

@interface CGXPageCollectionBaseView()
@property (nonatomic,strong,readwrite) NSMutableArray<CGXPageCollectionBaseSectionModel *> *dataArray;//数据源数组
@property (nonatomic , strong,readwrite) CGXPageCollectionView *collectionView;
@property (nonatomic , assign,readwrite) BOOL isDownRefresh;
@property (nonatomic , assign,readwrite) NSInteger page;
@property (nonatomic , assign,readwrite) NSInteger maxPage;
@end

@implementation CGXPageCollectionBaseView

- (void)dealloc
{
    if (self.collectionView) {
        [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
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
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);

    self.collectionView.collectionViewLayout = [self preferredFlowLayout];
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView reloadData];

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

- (NSMutableArray<CGXPageCollectionBaseSectionModel *> *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;;
}
- (void)reloadData
{
    [self.collectionView reloadData];
}
- (void)initializeData
{
    
}

- (void)initializeViews
{
    self.isDownRefresh =  YES;
    self.page = 1;
    self.maxPage = 10;
    self.collectionView = [[CGXPageCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) collectionViewLayout:[self preferredFlowLayout]];
    self.collectionView.backgroundColor = self.backgroundColor;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    //给collectionView注册头分区的Id
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    //给collection注册脚分区的id
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self addSubview:self.collectionView];
    // 监听滚动
     [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (UICollectionViewLayout *)preferredFlowLayout
{
    CGXPageCollectionBaseLayout *layout = [[CGXPageCollectionBaseLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    return layout;
}
- (void)refreshHeaderSection:(NSInteger)section Header:(UICollectionReusableView *)headerView
{
    
}
- (void)refreshFooterSection:(NSInteger)section Footer:(UICollectionReusableView *)footerView
{
    
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
        UICollectionReusableView *headview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.headerModel.headerIdentifier forIndexPath:indexPath];
        headview.backgroundColor = sectionModel.headerModel.headerBgColor;
        headview.tag = sectionModel.headerModel.headerTag;
        [self refreshHeaderSection:indexPath.section Header:headview];
        BOOL isHave = [headview respondsToSelector:@selector(updateWithCGXCollectionViewHeaderViewModel:InSection:)];
        if (isHave == YES && [headview conformsToProtocol:@protocol(CGXPageCollectionUpdateHeaderDelegate)]) {
            [(UICollectionReusableView<CGXPageCollectionUpdateHeaderDelegate> *)headview updateWithCGXCollectionViewHeaderViewModel:sectionModel  InSection:indexPath.section];
        }
        if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:AtIndexPath:SectionHeaderView:)]) {
            [self.viewDelegate gx_PageCollectionBaseView:self AtIndexPath:indexPath SectionHeaderView:headview];
        }
        if (sectionModel.headerModel.isHaveTap) {
            __weak typeof(self) headerviewSelf = self;
            [headview gx_addPageTapActionWithBlock:^(UIGestureRecognizer * _Nonnull gestureRecoginzer) {
                if (headerviewSelf.viewDelegate && [headerviewSelf.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:TapHeaderViewAtIndex:)]) {
                    [headerviewSelf.viewDelegate gx_PageCollectionBaseView:headerviewSelf TapHeaderViewAtIndex:indexPath.section];
                }
            }];
        }
        return headview;
    } else {
        UICollectionReusableView *footview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:sectionModel.footerModel.footerIdentifier forIndexPath:indexPath];
        footview.backgroundColor = sectionModel.footerModel.footerBgColor;
        footview.tag = sectionModel.footerModel.footerTag;
        [self refreshFooterSection:indexPath.section Footer:footview];

        BOOL isHave = [footview respondsToSelector:@selector(updateWithCGXCollectionViewFooterViewModel:InSection:)];
        if (isHave == YES && [footview conformsToProtocol:@protocol(CGXPageCollectionUpdateFooterDelegate)]) {
            [(UICollectionReusableView<CGXPageCollectionUpdateFooterDelegate> *)footview updateWithCGXCollectionViewFooterViewModel:sectionModel  InSection:indexPath.section];
        }
        if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:AtIndexPath:SectionFooterView:)]) {
            [self.viewDelegate gx_PageCollectionBaseView:self AtIndexPath:indexPath SectionFooterView:footview];
        }
        if (sectionModel.footerModel.isHaveTap) {
            __weak typeof(self) footerviewSelf = self;
            [footview gx_addPageTapActionWithBlock:^(UIGestureRecognizer * _Nonnull gestureRecoginzer) {
                if (footerviewSelf.viewDelegate && [footerviewSelf.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:TapFooterViewAtIndex:)]) {
                    [footerviewSelf.viewDelegate gx_PageCollectionBaseView:footerviewSelf TapFooterViewAtIndex:indexPath.section];
                }
            }];
        }
        return footview;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[indexPath.section];
    CGXPageCollectionBaseRowModel *itemModel = sectionModel.rowArray[indexPath.row];
    return [collectionView dequeueReusableCellWithReuseIdentifier:itemModel.cellIdentifier forIndexPath:indexPath];;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGXPageCollectionBaseSectionModel *sectionModel = self.dataArray[indexPath.section];
    CGXPageCollectionBaseRowModel *itemModel = sectionModel.rowArray[indexPath.row];
    cell.contentView.backgroundColor = itemModel.cellColor;
    BOOL isHave = [cell respondsToSelector:@selector(updateWithCGXPageCollectionCellModel:AtIndex:)];
    if (isHave == YES && [cell conformsToProtocol:@protocol(CGXPageCollectionUpdateCellDelegate)]) {
        [(UICollectionViewCell<CGXPageCollectionUpdateCellDelegate> *)cell updateWithCGXPageCollectionCellModel:itemModel  AtIndex:indexPath.row];
    }
    
    BOOL isHaveee = [cell respondsToSelector:@selector(updateWithCGXPageCollectionSectionModel:CellModel:AtIndexPath:)];
    if (isHaveee == YES && [cell conformsToProtocol:@protocol(CGXPageCollectionUpdateCellDelegate)]) {
        [(UICollectionViewCell<CGXPageCollectionUpdateCellDelegate> *)cell updateWithCGXPageCollectionSectionModel:sectionModel CellModel:itemModel AtIndexPath:indexPath];
    }
    

    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:Cell:cellForItemAtIndexPath:)]) {
        [self.viewDelegate gx_PageCollectionBaseView:self Cell:cell cellForItemAtIndexPath:indexPath];
    };
}
#pragma mark - cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:DidSelectItemAtIndexPath:)]) {
        [self.viewDelegate gx_PageCollectionBaseView:self DidSelectItemAtIndexPath:indexPath];
    };
}
// 滚动就会触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:scrollViewDidScroll:)]) {
         [self.viewDelegate gx_PageCollectionBaseView:self scrollViewDidScroll:scrollView];
     };
}
//开始拖拽时触发
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:scrollViewWillBeginDragging:)]) {
         [self.viewDelegate gx_PageCollectionBaseView:self scrollViewWillBeginDragging:scrollView];
     };
}
// 结束拖拽时触发
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView  willDecelerate:(BOOL)decelerate{
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:scrollViewDidEndDragging:willDecelerate:)]) {
        [self.viewDelegate gx_PageCollectionBaseView:self scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
     };
}
// 开始减速时触发
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:scrollViewWillBeginDecelerating:)]) {
         [self.viewDelegate gx_PageCollectionBaseView:self scrollViewWillBeginDecelerating:scrollView];
     };
}
// 结束减速时触发（停止）
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:scrollViewDidEndDecelerating:)]) {
         [self.viewDelegate gx_PageCollectionBaseView:self scrollViewDidEndDecelerating:scrollView];
     };
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint contentOffset = [change[NSKeyValueChangeNewKey] CGPointValue];
        if ((self.collectionView.isTracking || self.collectionView.isDecelerating)) {
            //只处理用户滚动的情况
            if (self.viewDelegate && [self.viewDelegate respondsToSelector:@selector(gx_PageCollectionBaseView:DropUpDownDidChanged:)]) {
                [self.viewDelegate gx_PageCollectionBaseView:self DropUpDownDidChanged:contentOffset];
            }
        }
    }
}
- (void)hidekeyboard
{
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
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
        [self.collectionView registerClass:footer forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[NSString stringWithFormat:@"%@", footer]];
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
        [self.collectionView registerClass:header forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[NSString stringWithFormat:@"%@", header]];
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
    [self updateDataArray:array IsDownRefresh:isDownRefresh Page:page MaxPage:self.maxPage];
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
    self.maxPage = maxPage;
    if (isDownRefresh) {
        [self.dataArray removeAllObjects];
    }
    for (CGXPageCollectionBaseSectionModel *sectionModel in array) {
        [self refreshSectionModel:sectionModel];
        [self.dataArray addObject:sectionModel];
    }
    [self.collectionView reloadData];
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
    [self.dataArray replaceObjectAtIndex:section withObject:sectionModel];
    [UIView performWithoutAnimation:^{
        [viewSelf.collectionView reloadSections:[NSIndexSet indexSetWithIndex:section]];
    }];
    [UIView performWithoutAnimation:^{
        [viewSelf.collectionView reloadData];
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
    [sectionModel.rowArray replaceObjectAtIndex:row withObject:rowModel];
    [UIView performWithoutAnimation:^{
        [viewSelf.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    }];
    [UIView performWithoutAnimation:^{
        [viewSelf.collectionView reloadData];
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
        [UIView performWithoutAnimation:^{
            [viewSelf.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObjects:indexPathNew, nil]];
            [sectionModel.rowArray insertObject:rowModel atIndex:row];
        }];
        [UIView performWithoutAnimation:^{
            [viewSelf.collectionView reloadData];
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

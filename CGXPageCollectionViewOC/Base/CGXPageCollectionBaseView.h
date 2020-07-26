//
//  CGXPageCollectionBaseView.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGXPageCollectionView.h"
#import "CGXPageCollectionBaseSectionModel.h"

#import "CGXPageCollectionUpdateFooterDelegate.h"
#import "CGXPageCollectionUpdateHeaderDelegate.h"
#import "CGXPageCollectionUpdateCellDelegate.h"
#import "CGXPageCollectionUpdateViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@class CGXPageCollectionBaseView;
/*
  刷 新。
 */
typedef void (^CGXPageCollectionBaseViewRefresBlock)(BOOL isDownRefresh,NSInteger page);
/*
 刷 新 更新界面 停止刷新
 pageInter :每页数量
 pageMax:每页最大数量
 */
typedef void (^CGXPageCollectionBaseViewRefresEndBlock)(NSInteger pageInter,NSInteger pageMax);

/*
 自适应返回的高度
 */
typedef void (^CGXPageCollectionBaseViewHeightBlock)(CGXPageCollectionBaseView *BaseView,CGFloat height);


@interface CGXPageCollectionBaseView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong) CGXPageCollectionView *collectionView;
/*
是否自适应高度
*/
@property (nonatomic,assign) BOOL isAdaptive;
/*
 数据源数组 只给外界提供可读
 */
@property (nonatomic,strong,readonly) NSMutableArray<CGXPageCollectionBaseSectionModel *> *dataArray;
/*
  刷新回调
 */
@property (nonatomic , copy) CGXPageCollectionBaseViewRefresBlock refresBlock;
/*
 刷新状态回调
*/
@property (nonatomic , copy) CGXPageCollectionBaseViewRefresEndBlock refresEndBlock;
/*
 界面设置代理
*/
@property (nonatomic , weak) id<CGXPageCollectionUpdateViewDelegate>viewDelegate;
/*
 自适应高度
*/
@property (nonatomic , copy) CGXPageCollectionBaseViewHeightBlock heightBlock;

/*
 自定义cell 、header、footer 必须实现
 */
- (void)registerCell:(Class)classCell IsXib:(BOOL)isXib;
- (void)registerFooter:(Class)footer IsXib:(BOOL)isXib;
- (void)registerHeader:(Class)header IsXib:(BOOL)isXib;


#pragma mark - 数据处理
/*
 加载数据 下拉调用
 */
- (void)loadData;
/*
 加载更多数据 上拉调用
 */
- (void)loadMoreData;
/*
 array：数据源
 pageCount:每次加载的个数
 pageSize：每页个数。默认10个
 maxPage:每页返回最大值 默认20
 */
- (void)updateDataArray:(NSMutableArray<CGXPageCollectionBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page;
- (void)updateDataArray:(NSMutableArray<CGXPageCollectionBaseSectionModel *> *)array IsDownRefresh:(BOOL)isDownRefresh Page:(NSInteger)page MaxPage:(NSInteger)maxPage;

/*
 获取分区数据源  注意判断是否超出
 */
- (CGXPageCollectionBaseSectionModel *)pullSection:(NSInteger)section;
/*
 获取每个cell数据源。注意判断是否超出
 */
- (CGXPageCollectionBaseRowModel *)pullSectionModel:(CGXPageCollectionBaseSectionModel *)sectionModel Row:(NSInteger)row;
/*
 替换一个分区的数据源
 */
- (void)replaceObjectAtSection:(NSInteger)section withObject:(CGXPageCollectionBaseSectionModel *)sectionModel;
/*
 替换一个cell数据源
 */
- (void)replaceObjectAtSection:(NSInteger)section RowIndex:(NSInteger)row withObject:(CGXPageCollectionBaseRowModel *)rowModel;
/*
 插入一个分区  当数据源数组为0时，默认设置插入到第一个
 */
- (void)insertSections:(NSInteger)section withObject:(CGXPageCollectionBaseSectionModel *)sectionModel;
- (void)insertSections:(NSInteger)section withObject:(CGXPageCollectionBaseSectionModel *)sectionModel Animation:(BOOL)animation;
/*
 插入单行  越界 row越界 插入到末尾处
 */
- (void)insertSections:(NSInteger)section RowIndex:(NSInteger)row withObject:(CGXPageCollectionBaseRowModel *)rowModel;
- (void)insertSections:(NSInteger)section RowIndex:(NSInteger)row withObject:(CGXPageCollectionBaseRowModel *)rowModel Animation:(BOOL)animation;
//删除一个分区
- (void)deleteSections:(NSInteger)section;
- (void)deleteSections:(NSInteger)section Animation:(BOOL)animation;;
//删除单行
- (void)deleteItemsAtSection:(NSInteger)section RowIndex:(NSInteger)row;
- (void)deleteItemsAtSection:(NSInteger)section RowIndex:(NSInteger)row Animation:(BOOL)animation;;
//删除所有数据源
- (void)deleteAll;
//刷新所有数据源
- (void)reloadData;



#pragma mark - Subclass Override 子类调用
- (void)initializeData NS_REQUIRES_SUPER;

- (void)initializeViews NS_REQUIRES_SUPER;
/*
 自定义layout
 */
- (UICollectionViewLayout *)preferredFlowLayout NS_REQUIRES_SUPER;
/*
自定义header设置
*/
- (UICollectionReusableView *)refreshHeaderSection:(NSInteger)section Header:(UICollectionReusableView *)headerView NS_REQUIRES_SUPER;
/*
自定义footer设置
*/
- (UICollectionReusableView *)refreshFooterSection:(NSInteger)section Footer:(UICollectionReusableView *)footerView NS_REQUIRES_SUPER;
/**
 @param baseSectionModel 用于判断子类数据类型
 */
- (void)refreshSectionModel:(CGXPageCollectionBaseSectionModel *)baseSectionModel NS_REQUIRES_SUPER;

@end





NS_ASSUME_NONNULL_END

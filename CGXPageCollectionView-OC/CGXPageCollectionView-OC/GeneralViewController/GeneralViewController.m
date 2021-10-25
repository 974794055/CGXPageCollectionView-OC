//
//  GeneralViewController.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "GeneralViewController.h"
#import "GeneralViewTool.h"

@interface GeneralViewController ()<CGXPageCollectionUpdateViewDelegate,CGXPageCollectionGeneralViewDataDelegate>

@property (nonatomic , strong) CGXPageCollectionGeneralView *generalView;

@property (strong, nonatomic) NSArray *titleArr;

@property (nonatomic,assign) NSInteger VerticalListPinSectionIndex;

@end

@implementation GeneralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.VerticalListPinSectionIndex = 0;
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.generalView = [[CGXPageCollectionGeneralView alloc]  init];
    self.generalView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight);
    self.generalView.viewDelegate = self;
    self.generalView.dataDelegate = self;
    self.generalView.isShowDifferentColor = YES;
    self.generalView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.generalView];
    [self.generalView registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
    [self.generalView registerCell:[CGXPageCollectionCategoryCell class] IsXib:NO];
    [self.generalView registerCell:[CGXPageCollectionImageCell class] IsXib:NO];
    [self.generalView registerCell:[CGXPageCollectionSearchCell class] IsXib:NO];
    [self.generalView registerCell:[CGXPageCollectionBaseCell class] IsXib:NO];

    [self.generalView registerFooter:[CGXPageCollectionSectionTextView class] IsXib:NO];
    [self.generalView registerFooter:[CGXPageCollectionSectionImageView class] IsXib:NO];
    [self.generalView registerHeader:[CGXPageCollectionSectionTextView class] IsXib:NO];
    [self.generalView registerHeader:[CGXPageCollectionSectionImageView class] IsXib:NO];
    
    self.generalView.heightBlock = ^(CGXPageCollectionBaseView * _Nonnull BaseView, CGFloat height) {
        NSLog(@"不能滚动height:%f" , height);
    };
   
    self.titleArr = ({
        NSArray *arr = [NSArray arrayWithObjects:
                        @"有Header&Footer，包Header,包Footer",
                        @"有Header&Footer，包Header,不包Footer",
                        @"有Header&Footer，不包Header,包Footer",
                        @"有Header&Footer，不包Header,不包Footer",
                        @"borderLine 包Section",
                        @"borderLine 包Section（带投影）",
                        nil];
        arr;
    });
    

    
    UIBarButtonItem *rightItem1= [[UIBarButtonItem alloc] initWithTitle:@"插分区" style:UIBarButtonItemStyleDone target:self action:@selector(insertData)];
    UIBarButtonItem *rightItem2= [[UIBarButtonItem alloc] initWithTitle:@"替换" style:UIBarButtonItemStyleDone target:self action:@selector(replaceData)];
    UIBarButtonItem *rightItem3= [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteIData)];
    UIBarButtonItem *rightItem4= [[UIBarButtonItem alloc] initWithTitle:@"插cell" style:UIBarButtonItemStyleDone target:self action:@selector(insertData1)];
    
    self.navigationItem.rightBarButtonItems = @[rightItem1,rightItem4,rightItem2,rightItem3];
    
    NSLog(@"height:%@" , self.generalView);
    
    
    
    __weak typeof(self) weakSelf = self;
    self.generalView.refresBlock = ^(BOOL isDownRefresh, NSInteger page) {
        NSMutableArray *dataArray = [NSMutableArray array];
        for (int i = 0; i<self.titleArr.count; i++) {
            CGXPageCollectionGeneralSectionModel *sectionModel = [GeneralViewTool sectionModel];
//            sectionModel.sectionHeadersHovering = i == 0 ?YES:NO;
//            sectionModel.sectionHeadersHoveringTopEdging = 0;
            CGXPageCollectionRoundModel *roundModel = [GeneralViewTool roundModel];
            if (i<4) {
                sectionModel.row = 2;
            } else if (i==4){
                roundModel.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
                roundModel.borderWidth = 1.0;
            } else if (i==5){
                roundModel.shadowColor = [UIColor blackColor];
                roundModel.shadowOffset = CGSizeMake(2,2);
                roundModel.shadowOpacity = 2;
                roundModel.shadowRadius = 4;
                roundModel.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
                roundModel.borderWidth = 2.0;
            }
            sectionModel.roundModel = roundModel;
            
            if (i==0) {
                roundModel.hotStr = @"bg";
                sectionModel.isRoundWithFooterView = YES;
                sectionModel.isRoundWithHeaderView = YES;
            } else if (i==1){
                roundModel.hotStr = @"bg2";
                sectionModel.isRoundWithFooterView = NO;
                sectionModel.isRoundWithHeaderView = YES;
            } else if (i==2){
                roundModel.hotStr = @"bg";;
                roundModel.page_ImageCallback = ^(UIImageView * _Nonnull hotImageView, NSURL * _Nonnull hotURL) {
                    [hotImageView sd_setImageWithURL:hotURL];
                };
                sectionModel.isRoundWithFooterView = YES;
                sectionModel.isRoundWithHeaderView = NO;
            } else if (i==3){
                sectionModel.isRoundWithFooterView = NO;
                sectionModel.isRoundWithHeaderView = NO;
            } else{
                sectionModel.isRoundWithFooterView = YES;
                sectionModel.isRoundWithHeaderView = YES;
            }
            
            CGXPageCollectionHeaderModel *headerModel = [GeneralViewTool headerModel];
            headerModel.headerModel = weakSelf.titleArr[i];
            headerModel.headerBgColor = [[UIColor yellowColor] colorWithAlphaComponent:0.8];
            CGXPageCollectionFooterModel *footerModel = [GeneralViewTool footerModel];
            footerModel.footerBgColor = [[UIColor orangeColor] colorWithAlphaComponent:0.7];
            sectionModel.headerModel = headerModel;
            sectionModel.footerModel = footerModel;
            
            sectionModel.row = arc4random() % 4 + 2;
            sectionModel.cellHeight = 80;
            UIColor *cellColor = RandomColor;
            for (int j = 0; j<sectionModel.row * 2;j++) {
                CGXPageCollectionGeneralRowModel *rowModel = [[CGXPageCollectionGeneralRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                rowModel.cellColor = cellColor;
                [sectionModel.rowArray addObject:rowModel];
            }
            [dataArray addObject:sectionModel];
        }
        [weakSelf.generalView updateDataArray:dataArray IsDownRefresh:isDownRefresh Page:page];        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.generalView.collectionView.mj_header endRefreshing];
            [weakSelf.generalView.collectionView.mj_footer endRefreshing];
        });
    };
    self.generalView.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.generalView loadData];
    }];
    [self.generalView.collectionView.mj_header beginRefreshing];
    self.generalView.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.generalView loadMoreData];
    }];
    
    
}
- (void)insertData
{
    CGXPageCollectionGeneralSectionModel *sectiomModel = (CGXPageCollectionGeneralSectionModel *)[GeneralViewTool insertSectionModel];
    [self.generalView insertSections:0 withObject:sectiomModel];
}
- (void)insertData1
{
    CGXPageCollectionGeneralRowModel *item = [[CGXPageCollectionGeneralRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
    item.dataModel= @"";
    item.cellColor = RandomColor;
    [self.generalView insertSections:0 RowIndex:0 withObject:item];
}
- (void)replaceData
{
    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)self.generalView.dataArray[0];
    
    CGFloat height = arc4random() % 20+80;
    CGFloat row = arc4random() % 2+2;
    NSMutableArray *itemArr = [NSMutableArray array];
    sectionModel.row = row;
    sectionModel.cellHeight = height;
    for (int i= 0 ; i<row*2; i++) {
        CGXPageCollectionGeneralRowModel *item = [[CGXPageCollectionGeneralRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
        
        item.dataModel= @"";
        
        item.cellColor = RandomColor;
        [itemArr addObject:item];
    }
    sectionModel.rowArray = [NSMutableArray arrayWithArray:itemArr];
    
    [self.generalView replaceObjectAtSection:0 withObject:sectionModel];
}
- (void)deleteIData
{
    BOOL isss = arc4random() % 2;
    if (isss) {
        [self.generalView deleteItemsAtSection:0 RowIndex:0];
    } else{
        [self.generalView deleteSections:0];
    }
    
}
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView Cell:(nonnull UICollectionViewCell *)cell cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[CGXPageCollectionCategoryCell class]]) {
        CGXPageCollectionCategoryCell *newcell = (CGXPageCollectionCategoryCell *)cell;
        newcell.titleLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
        newcell.picImageView.backgroundColor = [UIColor blackColor];
    }
}
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView DidSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击：%ld--%ld",indexPath.section,indexPath.row);
}

- (CGSize)gx_PageCollectionGeneralView:(CGXPageCollectionGeneralView *)tagsView sizeForItemHeightAtIndexPath:(NSIndexPath *)indexPath ItemSize:(CGSize)itemSize
{
    return CGSizeMake(itemSize.width, itemSize.height);
}
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView scrollViewDidScroll:(nonnull UIScrollView *)scrollView
{
//    NSLog(@"只有scrollview是跟滚动状态就会调用此方法");
    if (!(scrollView.isTracking || scrollView.isDecelerating)) {
        //不是用户滚动的，比如setContentOffset等方法，引起的滚动不需要处理。
        return;
    }
    //获取categoryView下面一点的所有布局信息，用于知道，当前最上方是显示的哪个section
    CGRect topRect = CGRectMake(0, scrollView.contentOffset.y, baseView.collectionView.bounds.size.width, 1);
    UICollectionViewLayoutAttributes *topAttributes = [baseView.collectionView.collectionViewLayout layoutAttributesForElementsInRect:topRect].firstObject;
    NSUInteger topSection = topAttributes.indexPath.section;
    if (topAttributes != nil && topSection >= self.VerticalListPinSectionIndex) {
        if (self.VerticalListPinSectionIndex != topSection) {
            //不相同才切换
            self.VerticalListPinSectionIndex = topSection;
            NSLog(@"topSection---:%ld",topSection);
        }
    }
}

//开始拖拽时触发
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
//    NSLog(@"开始拖拽");
}
// 结束拖拽时触发
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView scrollViewDidEndDragging:(UIScrollView *)scrollView  willDecelerate:(BOOL)decelerate
{
//    NSLog(@"结束拖拽");
}
// 开始减速时触发
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"开始减速");
}
// 结束减速时触发（停止）
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
//    NSLog(@"结束减速（停止）");
}
/*点击头分区*/
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView TapHeaderViewAtIndex:(NSInteger)section
{
    NSLog(@"点击2：%ld",section);
}
@end

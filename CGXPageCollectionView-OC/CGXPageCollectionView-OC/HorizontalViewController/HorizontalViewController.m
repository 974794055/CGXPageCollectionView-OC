//
//  HorizontalViewController.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "HorizontalViewController.h"

@interface HorizontalViewController ()<CGXPageCollectionUpdateViewDelegate>

@property (nonatomic , strong) UIScrollView *mainScrollViewH;

@end

@implementation HorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.mainScrollViewH=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight)];
    self.mainScrollViewH.bounces = YES;
    self.mainScrollViewH.scrollEnabled = YES;
    self.mainScrollViewH.backgroundColor=[UIColor colorWithWhite:0.93 alpha:1];;
    self.mainScrollViewH.showsHorizontalScrollIndicator = NO;
    self.mainScrollViewH.showsVerticalScrollIndicator = NO;
    //控制滚动视图遇到垂直方向是否反弹
//    self.mainScrollViewH.alwaysBounceVertical = YES;
    [self.view addSubview:self.mainScrollViewH];
    
    
    CGFloat height = 200;
    CGFloat y = 0;
    for (int i = 0; i<8; i++) {
        CGXPageCollectionHorizontalView *generalView = [[CGXPageCollectionHorizontalView alloc]  init];
        generalView.viewDelegate = self;
        generalView.backgroundColor = [UIColor whiteColor];
        [self.mainScrollViewH addSubview:generalView];
        [generalView registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
        [generalView registerCell:[CGXPageCollectionCategoryCell class] IsXib:NO];
        [generalView registerCell:[CGXPageCollectionImageCell class] IsXib:NO];
        [generalView registerCell:[CGXPageCollectionSearchCell class] IsXib:NO];
        [generalView registerCell:[CGXPageCollectionBaseCell class] IsXib:NO];
        [generalView registerFooter:[CGXPageCollectionSectionTextView class] IsXib:NO];
        [generalView registerHeader:[CGXPageCollectionSectionTextView class] IsXib:NO];
        
        generalView.backgroundColor = [UIColor lightGrayColor];
        generalView.isScrollPage = YES;
        
        generalView.frame = CGRectMake(0, y, [UIScreen mainScreen].bounds.size.width, height);
        y = y + height+10;
        NSMutableArray *dataArray1 = [NSMutableArray array];
        for (int j = 0; j<4; j++) {
            CGXPageCollectionHorizontalSectionModel *sectionModel = [[CGXPageCollectionHorizontalSectionModel alloc] init];
            sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
            sectionModel.minimumLineSpacing = 10;
            sectionModel.minimumInteritemSpacing = 10;
            sectionModel.borderEdgeInserts = UIEdgeInsetsMake(0, 10, 0, 10);
            
            CGFloat sectionWidth = [[UIScreen mainScreen]bounds].size.width*0.9;
            sectionModel.sectionWidth = ceil(sectionWidth);
            sectionModel.roundModel = [self sectionRoundModel];;
            
            CGXPageCollectionHeaderModel *headerModel = [[CGXPageCollectionHeaderModel alloc] initWithHeaderClass:[CGXPageCollectionSectionTextView class] IsXib:NO];
            headerModel.headerBgColor =  [UIColor orangeColor];;
            headerModel.headerHeight = 30;
            headerModel.isHaveTap = YES;
            headerModel.headerModel = [NSString stringWithFormat:@"%d--%d",i,j];
            sectionModel.headerModel = headerModel;
            
            CGXPageCollectionFooterModel *footerModel = [[CGXPageCollectionFooterModel alloc] initWithFooterClass:[CGXPageCollectionSectionTextView class] IsXib:NO];
            footerModel.footerBgColor = [UIColor yellowColor];;
            footerModel.footerHeight = 20;
            footerModel.isHaveTap = YES;
            footerModel.footerModel = @"脚步";
            sectionModel.footerModel = footerModel;
            
            
            
            
            if (i == 0) {
                sectionModel.section = 3;
                sectionModel.row = 3;
            } else if (i==1){
                sectionModel.section = 3;
                sectionModel.row = 2;
            } else if (i==2){
                sectionModel.section = 3;
                sectionModel.row = 1;
            } else if (i==3){
                sectionModel.section = 1;
                sectionModel.row = 1;
            } else if (i==4){
                sectionModel.section = 1;
                sectionModel.row = 2;
            } else if (i==5){
                sectionModel.section = 1;
                sectionModel.row = 3;
            } else {
                sectionModel.section = 1;
                sectionModel.row = 3;
                sectionModel.insets = UIEdgeInsetsMake(0, 0, 0, 0);
                sectionModel.borderEdgeInserts = UIEdgeInsetsMake(0, 0, 0, 0);
                sectionModel.minimumLineSpacing = 10;
                sectionModel.minimumInteritemSpacing = 10;
            }
            
  
            
            for (int k = 0; k< sectionModel.row*sectionModel.section;k++) {
                CGXPageCollectionHorizontalRowModel *rowModel = [[CGXPageCollectionHorizontalRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                rowModel.cellColor = RandomColor;
                [sectionModel.rowArray addObject:rowModel];
            }
            [dataArray1 addObject:sectionModel];
        }
        [generalView updateDataArray:dataArray1 IsDownRefresh:YES Page:1];
    }
    self.mainScrollViewH.contentSize = CGSizeMake(ScreenWidth,y+50);
}

- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView Cell:(nonnull UICollectionViewCell *)cell cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView DidSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击：%ld--%ld",indexPath.section,indexPath.row);
}

- (CGXPageCollectionRoundModel *)sectionRoundModel
{
    CGXPageCollectionRoundModel *roundModel = [[CGXPageCollectionRoundModel alloc] init];
    roundModel.backgroundColor = RandomColor;
    roundModel.cornerRadius = 0;
    roundModel.backgroundColor =[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    roundModel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    
    roundModel.shadowOffset = CGSizeMake(0,0);
    roundModel.shadowOpacity = 0;
    roundModel.shadowRadius = 0;
    roundModel.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    roundModel.borderColor = [UIColor redColor];
    roundModel.borderWidth = 1;
    return roundModel;
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

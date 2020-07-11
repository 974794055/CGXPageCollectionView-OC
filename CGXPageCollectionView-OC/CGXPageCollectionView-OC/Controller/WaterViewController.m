//
//  WaterViewController.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "WaterViewController.h"

@interface WaterViewController ()<CGXPageCollectionUpdateViewDelegate>
@property (nonatomic , strong) CGXPageCollectionWaterView *generalView;
@end

@implementation WaterViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.generalView.collectionView reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.view.backgroundColor = [UIColor whiteColor];
     self.edgesForExtendedLayout = UIRectEdgeNone;
    self.generalView = [[CGXPageCollectionWaterView alloc]  init];
    self.generalView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-88-34);
    self.generalView.viewDelegate = self;
    self.generalView.isShowDifferentColor = YES;
    self.generalView.isRoundEnabled = self.isRoundEnabled;
     [self.generalView registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
    [self.generalView registerFooter:[FooterReusableView class] IsXib:NO];
    [self.generalView registerHeader:[HeaderReusableView class] IsXib:NO];
    [self.view addSubview:self.generalView];
       NSMutableArray *dataArray = [NSMutableArray array];
       
    
    dataArray = [NSMutableArray arrayWithArray:[self loadDealWithList]];
       [self.generalView updateDataArray:dataArray IsDownRefresh:YES Page:1];
}
//处理数据源
- (NSMutableArray<CGXPageCollectionWaterSectionModel *> *)loadDealWithList
{
    NSMutableArray *dateAry = [NSMutableArray array];
    int x = 9;
    for (int i = 0; i<x; i++) {
        CGXPageCollectionWaterSectionModel *sectionModel = [[CGXPageCollectionWaterSectionModel alloc] init];
        
        sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        sectionModel.minimumLineSpacing = 10;
        sectionModel.minimumInteritemSpacing = 10;
        
        CGXPageCollectionHeaderModel *headerModel = [[CGXPageCollectionHeaderModel alloc] initWithHeaderClass:[HeaderReusableView class] IsXib:NO];
        headerModel.headerBgColor =  [UIColor orangeColor];;
        headerModel.headerHeight = 40;
        headerModel.isHaveTap = YES;
       headerModel.headerModel = @"头部";
        sectionModel.headerModel = headerModel;
        
        CGXPageCollectionFooterModel *footerModel = [[CGXPageCollectionFooterModel alloc] initWithFooterClass:[FooterReusableView class] IsXib:NO];
        footerModel.footerBgColor = [UIColor yellowColor];;
        footerModel.footerHeight = 30;
        footerModel.isHaveTap = YES;
        footerModel.footerModel = @"脚步";
        sectionModel.footerModel = footerModel;
        

        sectionModel.row = 1;
        
         sectionModel.borderEdgeInserts = UIEdgeInsetsMake(0, 0, 0, 0);
        if (self.isRoundEnabled) {
             sectionModel.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
   
        CGXPageCollectionRoundModel *roundModel = [[CGXPageCollectionRoundModel alloc] init];
            roundModel.backgroundColor = RandomColor;
        if (i<4) {
                sectionModel.row = 2;
                roundModel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
                
                roundModel.shadowOffset = CGSizeMake(0,0);
                roundModel.shadowOpacity = 0;
                roundModel.shadowRadius = 0;
                roundModel.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
                roundModel.borderWidth = 0;
                
            } else if (i==4 || i==5){
                roundModel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
                
                roundModel.shadowOffset = CGSizeMake(1,1);
                roundModel.shadowOpacity = 1;
                roundModel.shadowRadius = 4;
                
                roundModel.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
                roundModel.borderWidth = 1.0;
                
                if (i==4) {
                    roundModel.shadowOffset = CGSizeMake(0,0);
                    roundModel.shadowOpacity = 0;
                    roundModel.shadowRadius = 0;
                }
            } else{
            }
        sectionModel.roundModel = roundModel;
        }
        
        NSMutableArray *itemArr = [NSMutableArray array];
        
        NSInteger aRedValue =arc4random() %255;
         NSInteger aGreenValue =arc4random() %255;
         NSInteger aBlueValue =arc4random() %255;
         UIColor*randColor = [UIColor colorWithRed:aRedValue /255.0f green:aGreenValue /255.0f blue:aBlueValue /255.0f alpha:1.0f];
        
        if (i == 0) {
            sectionModel.row = 5;
            for (int j = 0; j<10; j++) {
                CGXPageCollectionWaterRowModel *item = [[CGXPageCollectionWaterRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                item.dataModel= @"str";
                item.cellHeight = 100;
                item.cellColor =  randColor;
                [itemArr addObject:item];
            }
        }else if (i == 1){
            sectionModel.row = 2;
            for (int j = 0; j<4; j++) {
                CGXPageCollectionWaterRowModel *item = [[CGXPageCollectionWaterRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                item.dataModel= @"str";
                if (j % 2 == 0) {
                    item.cellHeight = 160;
                } else{
                    item.cellHeight = 80;
                }
                item.cellColor =  randColor;
                [itemArr addObject:item];
            }
        }else if (i == 2){
            sectionModel.row = 3;
            for (int j = 0; j<6; j++) {
                CGXPageCollectionWaterRowModel *item = [[CGXPageCollectionWaterRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                item.dataModel= @"str";
                item.cellHeight = 160;
                item.cellColor =  randColor;
                [itemArr addObject:item];
            }
            
        }else if (i == 3){
            sectionModel.row = 4;
            for (int j = 0; j<23; j++) {
                CGXPageCollectionWaterRowModel *item = [[CGXPageCollectionWaterRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                item.dataModel= @"str";
                if (j == 0) {
                    item.cellHeight = 110;
                } else{
                    item.cellHeight = 50;
                }
                item.cellColor =  randColor;
                [itemArr addObject:item];
            }
            
        }else if (i == 4){
            sectionModel.row = 4;
            for (int j = 0; j<22; j++) {
                CGXPageCollectionWaterRowModel *item =[[CGXPageCollectionWaterRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                item.dataModel= @"str";
                if (j == 0) {
                    item.cellHeight = 110;
                } else{
                    item.cellHeight = 30;
                }
                item.cellColor =  randColor;
                [itemArr addObject:item];
            }
            
        }else if (i == 5){
            sectionModel.row = 2;
            for (int j = 0; j<3; j++) {
                CGXPageCollectionWaterRowModel *item = [[CGXPageCollectionWaterRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                item.dataModel= @"str";
                if (j == 0) {
                    item.cellHeight = 210;
                } else{
                    item.cellHeight = 100;
                }
                item.cellColor =  randColor;
                [itemArr addObject:item];
            }
        }else if (i == 6){
            sectionModel.row = 2;
            for (int j = 0; j<3; j++) {
                CGXPageCollectionWaterRowModel *item = [[CGXPageCollectionWaterRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                item.dataModel= @"str";
                if (j == 0) {
                    item.cellHeight = 100;
                }else if (j==1){
                    item.cellHeight = 210;
                }else{
                    item.cellHeight = 100;
                }
                item.cellColor =  randColor;
                [itemArr addObject:item];
            }
        }else if (i == 7){
            sectionModel.row = 2;
            for (int j = 0; j<8; j++) {
                CGXPageCollectionWaterRowModel *item = [[CGXPageCollectionWaterRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                item.dataModel= @"str";
                if (j == 0) {
                    item.cellHeight = 320;
                }else{
                    item.cellHeight = 100;
                }
                item.cellColor =  randColor;
                [itemArr addObject:item];
            }
        }else{
            sectionModel.row = 3;
            for (int j = 0; j<30; j++) {
                CGXPageCollectionWaterRowModel *item = [[CGXPageCollectionWaterRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
                item.dataModel= @"str";
                item.cellHeight = 120+arc4random() % 30;
                item.cellColor =  randColor;
                [itemArr addObject:item];
            }
        }
        sectionModel.rowArray = [NSMutableArray arrayWithArray:itemArr];
        [dateAry addObject:sectionModel];
    }
    return dateAry;
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

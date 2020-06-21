//
//  GeneralViewController.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "GeneralViewController.h"

@interface GeneralViewController ()<CGXPageCollectionUpdateViewDelegate>

@property (nonatomic , strong) CGXPageCollectionGeneralView *generalView;

@property (strong, nonatomic) NSArray *titleArr;

@end

@implementation GeneralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.generalView = [[CGXPageCollectionGeneralView alloc]  init];
    self.generalView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-88-34);
    self.generalView.viewDelegate = self;
    self.generalView.isShowDifferentColor = YES;
    self.generalView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.generalView];
    [self.generalView registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
    [self.generalView registerFooter:[FooterRoundReusableView class] IsXib:NO];
    [self.generalView registerHeader:[HeaderRoundReusableView class] IsXib:NO];
    [self.generalView registerFooter:[FooterReusableView class] IsXib:NO];
    [self.generalView registerHeader:[HeaderReusableView class] IsXib:NO];
    
    
    self.generalView.isRoundEnabled = YES;
    self.titleArr = ({
        NSArray *arr = [NSArray arrayWithObjects:
                        @"有Header&Footer，包Header,包Footer",
                        @"有Header&Footer，包Header,不包Footer",
                        @"有Header&Footer，不包Header,包Footer",
                        @"有Header&Footer，不包Header,不包Footer",
                        @"borderLine 包Section",
                        @"borderLine 包Section（带投影）",
                        @"有sections底色，cell左对齐",
                        @"有sections底色，cell居中",
                        @"有sections底色，cell右对齐",
                        @"cell右对齐与cell右侧开始",
                        nil];
        arr;
    });
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i<self.titleArr.count; i++) {
        CGXPageCollectionGeneralSectionModel *sectionModel = [[CGXPageCollectionGeneralSectionModel alloc] init];
        sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        sectionModel.minimumLineSpacing = 10;
        sectionModel.minimumInteritemSpacing = 10;
        sectionModel.row = arc4random() % 5 + 1;
        sectionModel.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
        
        [sectionModel initWithHeaderClass:[HeaderRoundReusableView class] IsXib:NO];
        [sectionModel initWithFooterClass:[FooterRoundReusableView class] IsXib:NO];
        
        CGXPageCollectionRoundModel *roundModel = [[CGXPageCollectionRoundModel alloc] init];
        roundModel.backgroundColor = RandomColor;
        roundModel.cornerRadius = 10;
        roundModel.backgroundColor =[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
        if (i<4) {
            sectionModel.row = 2;
            roundModel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
            
            roundModel.shadowOffset = CGSizeMake(0,0);
            roundModel.shadowOpacity = 0;
            roundModel.shadowRadius = 0;
            roundModel.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
            roundModel.borderWidth = 0;
            
            if (i==0) {
                sectionModel.isRoundWithFooterView = YES;
                sectionModel.isRoundWithHeaerView = YES;
                
                [sectionModel initWithHeaderClass:[HeaderRoundReusableView class] IsXib:NO];
                [sectionModel initWithFooterClass:[FooterRoundReusableView class] IsXib:NO];
                
            } else if (i==1){
                sectionModel.isRoundWithFooterView = NO;
                sectionModel.isRoundWithHeaerView = YES;
                
                [sectionModel initWithHeaderClass:[HeaderRoundReusableView class] IsXib:NO];
                [sectionModel initWithFooterClass:[FooterReusableView class] IsXib:NO];
                
            } else if (i==2){
                sectionModel.isRoundWithFooterView = YES;
                sectionModel.isRoundWithHeaerView = NO;
                
                [sectionModel initWithHeaderClass:[HeaderReusableView class] IsXib:NO];
                [sectionModel initWithFooterClass:[FooterRoundReusableView class] IsXib:NO];
                
            } else if (i==3){
                sectionModel.isRoundWithFooterView = NO;
                sectionModel.isRoundWithHeaerView = NO;
                
                [sectionModel initWithHeaderClass:[HeaderReusableView class] IsXib:NO];
                [sectionModel initWithFooterClass:[FooterReusableView class] IsXib:NO];
                
            }
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
            sectionModel.isRoundWithFooterView = YES;
            sectionModel.isRoundWithHeaerView = YES;
        } else{
            sectionModel.isRoundWithFooterView = YES;
            sectionModel.isRoundWithHeaerView = YES;
            
            sectionModel.isCalculateOpenIrregularCell = YES;
        }
        sectionModel.roundModel = roundModel;
        
        
        
        sectionModel.headerModel.headerBgColor = [UIColor orangeColor];
        sectionModel.headerModel.headerHeight = 40;
        sectionModel.headerModel.headerModel = self.titleArr[i];
        sectionModel.headerModel.isHaveTap = YES;
        
        
        sectionModel.footerModel.footerBgColor = [UIColor yellowColor];;
        sectionModel.footerModel.footerHeight = 40;
        sectionModel.footerModel.isHaveTap = YES;
        
        for (int j = 0; j<sectionModel.row * 2;j++) {
            CGXPageCollectionGeneralRowModel *rowModel = [[CGXPageCollectionGeneralRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
            rowModel.cellHeight = 50;
            rowModel.cellColor = RandomColor;
            [sectionModel.rowArray addObject:rowModel];
        }
        [dataArray addObject:sectionModel];
    }
    [self.generalView updateDataArray:dataArray IsDownRefresh:YES Page:1];
}

- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView Cell:(nonnull UICollectionViewCell *)cell cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView DidSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击：%ld--%ld",indexPath.section,indexPath.row);
}
//- (CGSize)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath Height:(CGFloat)height
//{
////    CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)baseView.dataArray[indexPath.section];
////    CGXPageCollectionGeneralRowModel *item =  (CGXPageCollectionGeneralRowModel *)sectionModel.rowArray[indexPath.row];;
//    return CGSizeMake(arc4random() % 30+50, height);
//}

@end

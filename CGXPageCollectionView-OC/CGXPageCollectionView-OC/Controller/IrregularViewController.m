//
//  IrregularViewController.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "IrregularViewController.h"


@interface IrregularViewController ()

@property (nonatomic , strong) CGXPageCollectionIrregularView *irregulaView;

@end

@implementation IrregularViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.irregulaView = [[CGXPageCollectionIrregularView alloc] init];
    self.irregulaView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-88-34);
    [self.view addSubview:self.irregulaView];
    [self.irregulaView registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
    [self.irregulaView registerFooter:[FooterReusableView class] IsXib:NO];
    [self.irregulaView registerHeader:[HeaderReusableView class] IsXib:NO];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(updateColor)];
    [self updateColor];
    
}
- (void)updateColor
{
    NSMutableArray *typeArray = [NSMutableArray arrayWithObjects:
                                 @(CGXPageCollectionIrregularLayoutDefault),
                                 @(CGXPageCollectionIrregularLayoutLeftRight1T2),
                                 @(CGXPageCollectionIrregularLayoutLeftRight2T1),
                                 @(CGXPageCollectionIrregularLayoutTopBottom1T2),
                                 @(CGXPageCollectionIrregularLayoutTopBottom2T1),
                                 @(CGXPageCollectionIrregularLayoutFirstBigTN),
                                 nil];
    
    
    NSMutableArray *dataArrayaaaa = [NSMutableArray array];
    for (int i = 0; i<typeArray.count; i++) {
        
        //        NSMutableArray *dataArr = dataArray[i];
        
        CGXPageCollectionIrregularLayoutShowType type = [typeArray[i] integerValue];
        CGXPageCollectionIrreguarSectionModel *sectionModel = [[CGXPageCollectionIrreguarSectionModel alloc] init];
        sectionModel.showType = type;
        
        [sectionModel initWithHeaderClass:[HeaderReusableView class] IsXib:NO];
        sectionModel.headerModel.headerBgColor = RandomColor;;
        sectionModel.headerModel.headerHeight = 40;
        
        [sectionModel initWithFooterClass:[FooterReusableView class] IsXib:NO];
        sectionModel.footerModel.footerBgColor = RandomColor;
        sectionModel.footerModel.footerHeight = 40;
        
        
        sectionModel.bottomRow = 4;
        
        NSInteger rowInter = 30;
        if (type == CGXPageCollectionIrregularLayoutDefault) {
            rowInter = 8;
        }
        if (type == CGXPageCollectionIrregularLayoutLeftRight1T2) {
            rowInter = 11;
        }
        if (type == CGXPageCollectionIrregularLayoutLeftRight2T1) {
            rowInter = 11;
        }
        if (type == CGXPageCollectionIrregularLayoutTopBottom1T2) {
            rowInter = 11;
        }
        if (type == CGXPageCollectionIrregularLayoutTopBottom2T1) {
            rowInter = 11;
        }
        if (type == CGXPageCollectionIrregularLayoutFirstBigTN) {
            rowInter = 17;
        }
        
        
        for (int j = 0; j<rowInter;j++) {
            CGXPageCollectionIrreguarRowModel *rowModel = [[CGXPageCollectionIrreguarRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
            rowModel.cellHeight = 50;
            if (type == CGXPageCollectionIrregularLayoutDefault) {
                rowModel.cellHeight =50;
            }
            if (type == CGXPageCollectionIrregularLayoutLeftRight1T2) {
                sectionModel.topHeight = 110;
                sectionModel.bottomHeight = 50;
            }
            if (type == CGXPageCollectionIrregularLayoutLeftRight2T1) {
                sectionModel.topHeight = 110;
                sectionModel.bottomHeight = 50;
            }
            if (type == CGXPageCollectionIrregularLayoutTopBottom1T2) {
                if (j) {
                    rowModel.cellHeight =50;
                } else{
                    rowModel.cellHeight =50;
                }
            }
            if (type == CGXPageCollectionIrregularLayoutTopBottom2T1) {
                if (j == 0 || j == 1) {
                    rowModel.cellHeight =110;
                } else{
                    rowModel.cellHeight =50;
                }
            }
            if (type == CGXPageCollectionIrregularLayoutFirstBigTN) {
                sectionModel.topSection = arc4random() % 2+2;;
                sectionModel.topRow = 3;
                sectionModel.bottomRow = 4+arc4random() % 2;
                
                sectionModel.topHeight = 40*sectionModel.topSection+10 *(sectionModel.topSection-1);;
                
                sectionModel.bottomHeight = 40;
            }
            rowModel.cellColor = RandomColor;
            [sectionModel.rowArray addObject:rowModel];
        }
        
        [dataArrayaaaa addObject:sectionModel];
    }
    [self.irregulaView updateDataArray:dataArrayaaaa IsDownRefresh:YES Page:1];
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

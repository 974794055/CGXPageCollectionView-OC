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
    
    UIBarButtonItem *rightItem1= [[UIBarButtonItem alloc] initWithTitle:@"插入1" style:UIBarButtonItemStyleDone target:self action:@selector(insertData)];
    UIBarButtonItem *rightItem2= [[UIBarButtonItem alloc] initWithTitle:@"替换" style:UIBarButtonItemStyleDone target:self action:@selector(replaceData)];
    UIBarButtonItem *rightItem3= [[UIBarButtonItem alloc] initWithTitle:@"删除" style:UIBarButtonItemStyleDone target:self action:@selector(deleteIData)];
    UIBarButtonItem *rightItem4= [[UIBarButtonItem alloc] initWithTitle:@"插入2" style:UIBarButtonItemStyleDone target:self action:@selector(insertData1)];
    
    self.navigationItem.rightBarButtonItems = @[rightItem1,rightItem4,rightItem2,rightItem3];
}
- (void)insertData
{
        CGXPageCollectionGeneralSectionModel *sectiomModel = (CGXPageCollectionGeneralSectionModel *)[self insertObjectAtSection:0];
    [self.generalView insertSections:0 withObject:sectiomModel];
}
- (void)insertData1
{
    CGXPageCollectionGeneralSectionModel *sectiomModel = (CGXPageCollectionGeneralSectionModel *)[self insertObjectAtSection:0];
    
    CGXPageCollectionGeneralRowModel *itemaaa = (CGXPageCollectionGeneralRowModel *)[sectiomModel.rowArray firstObject];
    CGXPageCollectionGeneralRowModel *item = [[CGXPageCollectionGeneralRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
    
    item.dataModel= @"";
    item.cellHeight = itemaaa.cellHeight;
    item.cellColor = RandomColor;
    [self.generalView insertSections:0 RowIndex:0 withObject:item];
}
- (void)replaceData
{
        CGXPageCollectionGeneralSectionModel *sectionModel = (CGXPageCollectionGeneralSectionModel *)[self.generalView pullSection:0];
    
        CGFloat height = arc4random() % 20+80;
        CGFloat row = arc4random() % 2+2;
        NSMutableArray *itemArr = [NSMutableArray array];
        sectionModel.row = row;
        for (int i= 0 ; i<row*2; i++) {
            CGXPageCollectionGeneralRowModel *item = [[CGXPageCollectionGeneralRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
    
            item.dataModel= @"";
            item.cellHeight = height;
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
    
}
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView DidSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击：%ld--%ld",indexPath.section,indexPath.row);
}


//插入一个分区
- (CGXPageCollectionGeneralSectionModel *)insertObjectAtSection:(NSInteger)section
{
    CGXPageCollectionGeneralSectionModel *sectionModel = [[CGXPageCollectionGeneralSectionModel alloc] init];
    sectionModel.row = 2;
    [sectionModel initWithFooterClass:[FooterReusableView class] IsXib:NO];
    sectionModel.headerModel.headerHeight = 40;
    
    sectionModel.headerModel.headerModel = [NSString stringWithFormat:@"头部-%d",0];
    sectionModel.headerModel.headerTag = 10000;
    sectionModel.headerModel.headerBgColor = [UIColor orangeColor];
    
    [sectionModel initWithFooterClass:[FooterReusableView class] IsXib:NO];
    sectionModel.footerModel.footerModel = [NSString stringWithFormat:@"脚部-%d",0];
    sectionModel.footerModel.footerTag = 20000;
    sectionModel.footerModel.footerHeight  = 40;
    sectionModel.footerModel.footerBgColor = [UIColor yellowColor];
    
    CGFloat height = 80;
    CGFloat row = arc4random() % 2+2;
    NSMutableArray *itemArr = [NSMutableArray array];
    for (int i= 0 ; i<row*2; i++) {
        CGXPageCollectionGeneralRowModel *item = [[CGXPageCollectionGeneralRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
        sectionModel.row = row;
        item.dataModel= @"";
        item.cellHeight = height;
        item.cellColor = RandomColor;
        [itemArr addObject:item];
    }
    sectionModel.rowArray = [NSMutableArray arrayWithArray:itemArr];
    return sectionModel;
}

@end

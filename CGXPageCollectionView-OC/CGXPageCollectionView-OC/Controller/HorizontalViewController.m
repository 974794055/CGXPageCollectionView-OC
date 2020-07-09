//
//  HorizontalViewController.m
//  CGXPageCollectionView-OC
//
//  Created by MacMini-1 on 2020/7/8.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "HorizontalViewController.h"

@interface HorizontalViewController ()<CGXPageCollectionUpdateViewDelegate>
@property (nonatomic , strong) CGXPageCollectionHorizontalView *generalView;

@property (strong, nonatomic) NSArray *titleArr;


@end

@implementation HorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
      self.edgesForExtendedLayout = UIRectEdgeNone;
      self.generalView = [[CGXPageCollectionHorizontalView alloc]  init];
      self.generalView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200+100);
      self.generalView.viewDelegate = self;
      self.generalView.backgroundColor = [UIColor whiteColor];
      [self.view addSubview:self.generalView];
      [self.generalView registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
      [self.generalView registerFooter:[FooterRoundReusableView class] IsXib:NO];
      [self.generalView registerHeader:[HeaderRoundReusableView class] IsXib:NO];
      [self.generalView registerFooter:[FooterReusableView class] IsXib:NO];
      [self.generalView registerHeader:[HeaderReusableView class] IsXib:NO];
    self.generalView.section = 2;
    self.generalView.row = 2;
    self.generalView.backgroundColor = [UIColor lightGrayColor];
      self.titleArr = ({
          NSArray *arr = [NSArray arrayWithObjects:
                          @"有Header&Footer",
                         @"有Header&Footer",
                          @"有Header&Footer",
                          @"有Header&Footer",
                          nil];
          arr;
      });
      NSMutableArray *dataArray1 = [NSMutableArray array];
      for (int i = 0; i<self.titleArr.count; i++) {
          CGXPageCollectionHorizontalSectionModel *sectionModel = [[CGXPageCollectionHorizontalSectionModel alloc] init];
          sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
          sectionModel.minimumLineSpacing = 10;
          sectionModel.minimumInteritemSpacing = 10;


          CGFloat sectionWidth = [[UIScreen mainScreen]bounds].size.width*0.56;
          sectionModel.sectionWidth = ceil(sectionWidth);
          sectionModel.roundModel = sectionModel.roundModel = [self sectionRoundModel];;


          [sectionModel initWithHeaderClass:[HeaderRoundReusableView class] IsXib:NO];
          [sectionModel initWithFooterClass:[FooterRoundReusableView class] IsXib:NO];

          sectionModel.headerModel.headerBgColor = [UIColor orangeColor];
          sectionModel.headerModel.headerHeight = 40;
          sectionModel.headerModel.headerModel = self.titleArr[i];
          sectionModel.headerModel.isHaveTap = YES;

          sectionModel.footerModel.footerBgColor = [UIColor yellowColor];;
          sectionModel.footerModel.footerHeight = 40;
          sectionModel.footerModel.isHaveTap = YES;

          for (int j = 0; j< self.generalView.row*self.generalView.section;j++) {
              CGXPageCollectionHorizontalRowModel *rowModel = [[CGXPageCollectionHorizontalRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
              rowModel.cellColor = RandomColor;
              [sectionModel.rowArray addObject:rowModel];
          }
          [dataArray1 addObject:sectionModel];
      }
      [self.generalView updateDataArray:dataArray1 IsDownRefresh:YES Page:1];
    
    NSMutableArray *dataArray2 = [NSMutableArray array];
    CGXPageCollectionHorizontalView *generalView1 = [[CGXPageCollectionHorizontalView alloc]  init];
    generalView1.frame = CGRectMake(0,CGRectGetMaxY(self.generalView.frame)+20, [UIScreen mainScreen].bounds.size.width, 100);
    generalView1.viewDelegate = self;
    generalView1.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:generalView1];
    [generalView1 registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
    [generalView1 registerFooter:[FooterRoundReusableView class] IsXib:NO];
    [generalView1 registerHeader:[HeaderRoundReusableView class] IsXib:NO];
    [generalView1 registerFooter:[FooterReusableView class] IsXib:NO];
    [generalView1 registerHeader:[HeaderReusableView class] IsXib:NO];
    generalView1.section = 1;
    generalView1.row = 2;
    generalView1.backgroundColor = [UIColor lightGrayColor];
    
    for (int i = 0; i<self.titleArr.count; i++) {
        CGXPageCollectionHorizontalSectionModel *sectionModel = [[CGXPageCollectionHorizontalSectionModel alloc] init];
        sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        sectionModel.minimumLineSpacing = 10;
        sectionModel.minimumInteritemSpacing = 10;
        CGFloat sectionWidth = [[UIScreen mainScreen]bounds].size.width*0.56;
        sectionModel.sectionWidth = ceil(sectionWidth);
        sectionModel.roundModel = [self sectionRoundModel];
        [sectionModel initWithHeaderClass:[HeaderRoundReusableView class] IsXib:NO];
        sectionModel.headerModel.headerBgColor = [UIColor orangeColor];
        sectionModel.headerModel.headerHeight = 40;
        sectionModel.headerModel.headerModel = self.titleArr[i];
        sectionModel.headerModel.isHaveTap = YES;
        for (int j = 0; j< generalView1.row*generalView1.section;j++) {
            CGXPageCollectionHorizontalRowModel *rowModel = [[CGXPageCollectionHorizontalRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
            rowModel.cellColor = RandomColor;
            [sectionModel.rowArray addObject:rowModel];
        }
        [dataArray2 addObject:sectionModel];
    }
    [generalView1 updateDataArray:dataArray2 IsDownRefresh:YES Page:1];
    
    
    NSMutableArray *dataArray3 = [NSMutableArray array];
    CGXPageCollectionHorizontalView *generalView2 = [[CGXPageCollectionHorizontalView alloc]  init];
    generalView2.frame = CGRectMake(0,CGRectGetMaxY(generalView1.frame)+20, [UIScreen mainScreen].bounds.size.width, 100);
    generalView2.viewDelegate = self;
    generalView2.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:generalView2];
    [generalView2 registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
    generalView2.section = 1;
    generalView2.row = 2;
    generalView2.backgroundColor = [UIColor lightGrayColor];
    
    for (int i = 0; i<self.titleArr.count; i++) {
        CGXPageCollectionHorizontalSectionModel *sectionModel = [[CGXPageCollectionHorizontalSectionModel alloc] init];
        sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        sectionModel.minimumLineSpacing = 10;
        sectionModel.minimumInteritemSpacing = 10;
        CGFloat sectionWidth = [[UIScreen mainScreen]bounds].size.width*0.56;
        sectionModel.sectionWidth = ceil(sectionWidth);
        sectionModel.roundModel = [self sectionRoundModel];
        for (int j = 0; j< generalView2.row*generalView2.section;j++) {
            CGXPageCollectionHorizontalRowModel *rowModel = [[CGXPageCollectionHorizontalRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
            rowModel.cellColor = RandomColor;
            [sectionModel.rowArray addObject:rowModel];
        }
        [dataArray3 addObject:sectionModel];
    }
    [generalView2 updateDataArray:dataArray3 IsDownRefresh:YES Page:1];
    
    NSMutableArray *dataArray4 = [NSMutableArray array];
    CGXPageCollectionHorizontalView *generalView3 = [[CGXPageCollectionHorizontalView alloc]  init];
    generalView3.frame = CGRectMake(0,CGRectGetMaxY(generalView2.frame)+20, [UIScreen mainScreen].bounds.size.width, 100);
    generalView3.viewDelegate = self;
    generalView3.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:generalView3];
    [generalView3 registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
    generalView3.section = 1;
    generalView3.row = 1;
    generalView3.backgroundColor = [UIColor lightGrayColor];
    
    for (int i = 0; i<10; i++) {
        CGXPageCollectionHorizontalSectionModel *sectionModel = [[CGXPageCollectionHorizontalSectionModel alloc] init];
        sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        sectionModel.minimumLineSpacing = 10;
        sectionModel.minimumInteritemSpacing = 10;
        CGFloat sectionWidth = [[UIScreen mainScreen]bounds].size.width*0.56;
        sectionModel.sectionWidth = ceil(sectionWidth);
        sectionModel.roundModel = [self sectionRoundModel];
        for (int j = 0; j< generalView3.row*generalView3.section;j++) {
            CGXPageCollectionHorizontalRowModel *rowModel = [[CGXPageCollectionHorizontalRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
            rowModel.cellColor = RandomColor;
            [sectionModel.rowArray addObject:rowModel];
        }
        [dataArray4 addObject:sectionModel];
    }
    [generalView3 updateDataArray:dataArray4 IsDownRefresh:YES Page:1];
    
      
     
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

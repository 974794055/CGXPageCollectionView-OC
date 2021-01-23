//
//  TagsViewController.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "TagsViewController.h"

@interface TagsViewController ()<CGXPageCollectionTagsViewTitleDelegate>
@property (nonatomic , strong) CGXPageCollectionTagsView *generalView;

@end

@implementation TagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
    self.view.backgroundColor = [UIColor whiteColor];
     self.edgesForExtendedLayout = UIRectEdgeNone;
    self.generalView = [[CGXPageCollectionTagsView alloc]  init];
    self.generalView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-kTopHeight-kSafeHeight);
      self.generalView.backgroundColor = [UIColor whiteColor];
    self.generalView.titleDelegate = self;
      [self.view addSubview:self.generalView];
      [self.generalView registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
    [self.generalView registerFooter:[CGXPageCollectionSectionTextView class] IsXib:NO];
    [self.generalView registerHeader:[CGXPageCollectionSectionTextView class] IsXib:NO];
    
    NSMutableArray *horizontalAlignments = [NSMutableArray arrayWithObjects:
                                            @(CGXPageCollectionTagsHorizontalAlignmentCenter),
                                            @(CGXPageCollectionTagsHorizontalAlignmentLeft),
                                            @(CGXPageCollectionTagsHorizontalAlignmentRight),
                                            @(CGXPageCollectionTagsHorizontalAlignmentFlow),
                                            nil];
    
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i<[horizontalAlignments count]; i++) {
        
        CGXPageCollectionTagsHorizontalAlignment horizontal = [horizontalAlignments[i] integerValue];

        CGXPageCollectionTagsSectionModel *sectionModel = [[CGXPageCollectionTagsSectionModel alloc] init];
        sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        sectionModel.minimumLineSpacing = 10;
        sectionModel.minimumInteritemSpacing = 10;

        
        CGXPageCollectionHeaderModel *headerModel = [[CGXPageCollectionHeaderModel alloc] initWithHeaderClass:[CGXPageCollectionSectionTextView class] IsXib:NO];
        headerModel.headerBgColor = [UIColor orangeColor];
        headerModel.headerHeight = 40;
        headerModel.isHaveTap = YES;
        sectionModel.headerModel = headerModel;
        
        CGXPageCollectionFooterModel *footerModel = [[CGXPageCollectionFooterModel alloc] initWithFooterClass:[CGXPageCollectionSectionTextView class] IsXib:NO];
        footerModel.footerBgColor = [UIColor yellowColor];;
        footerModel.footerHeight = 40;
        footerModel.isHaveTap = YES;
        sectionModel.footerModel = footerModel;

        sectionModel.horizontalAlignment = horizontal;
        sectionModel.verticalAlignment = CGXPageCollectionTagsVerticalAlignmentTop;
        sectionModel.direction = CGXPageCollectionTagsDirectionLTR;
        
        for (int j = 0; j<30;j++) {
            CGXPageCollectionTagsRowModel *rowModel = [[CGXPageCollectionTagsRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
            rowModel.cellHeight = 40;
            rowModel.cellWidth = arc4random() % 30+40;
            rowModel.cellColor = RandomColor;
            [sectionModel.rowArray addObject:rowModel];
        }
        [dataArray addObject:sectionModel];
    }
    [self.generalView updateDataArray:dataArray IsDownRefresh:YES Page:1];
    
}

- (CGSize)gx_PageCollectionTagsView:(CGXPageCollectionTagsView *)tagsView sizeForItemHeightAtIndexPath:(NSIndexPath *)indexPath ItemSize:(CGSize)itemSize
{
    return CGSizeMake(arc4random() % 60+40, itemSize.height);
}
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView DidSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击：%ld--%ld",indexPath.section,indexPath.row);
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

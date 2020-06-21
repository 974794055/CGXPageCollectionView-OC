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
      self.generalView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-88-34);
      self.generalView.backgroundColor = [UIColor whiteColor];
    self.generalView.titleDelegate = self;
      [self.view addSubview:self.generalView];
      [self.generalView registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
    [self.generalView registerFooter:[FooterReusableView class] IsXib:NO];
    [self.generalView registerHeader:[HeaderReusableView class] IsXib:NO];
    
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

        [sectionModel initWithHeaderClass:[HeaderReusableView class] IsXib:NO];
        sectionModel.headerModel.headerBgColor = [UIColor orangeColor];
        sectionModel.headerModel.headerHeight = 40;
        sectionModel.headerModel.isHaveTap = YES;
        
        [sectionModel initWithFooterClass:[FooterReusableView class] IsXib:NO];
        sectionModel.footerModel.footerBgColor = [UIColor yellowColor];;
        sectionModel.footerModel.footerHeight = 40;
        sectionModel.footerModel.isHaveTap = YES;

        sectionModel.horizontalAlignment = horizontal;
        sectionModel.verticalAlignment = CGXPageCollectionTagsVerticalAlignmentTop;
        sectionModel.direction = CGXPageCollectionTagsDirectionLTR;
        
        for (int j = 0; j<10;j++) {
            CGXPageCollectionTagsRowModel *rowModel = [[CGXPageCollectionTagsRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
            rowModel.cellHeight = 40;
            rowModel.cellColor = RandomColor;
            [sectionModel.rowArray addObject:rowModel];
        }
        [dataArray addObject:sectionModel];
    }
    [self.generalView updateDataArray:dataArray IsDownRefresh:YES Page:1];
    
}

- (CGSize)tagsView:(CGXPageCollectionTagsView *)tagsView sizeForItemHeightAtIndexPath:(NSIndexPath *)indexPath ItemSize:(CGSize)itemSize
{
    return CGSizeMake(arc4random() % 30+40, itemSize.height);
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

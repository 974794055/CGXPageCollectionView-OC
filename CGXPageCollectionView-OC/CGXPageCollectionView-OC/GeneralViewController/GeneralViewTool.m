//
//  GeneralViewTool.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/7/25.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "GeneralViewTool.h"

@implementation GeneralViewTool

+ (CGXPageCollectionGeneralSectionModel *)sectionModel
{
    CGXPageCollectionGeneralSectionModel *sectionModel = [[CGXPageCollectionGeneralSectionModel alloc] init];
    sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    sectionModel.minimumLineSpacing = 10;
    sectionModel.minimumInteritemSpacing = 10;
    sectionModel.row = 1;
    sectionModel.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
    sectionModel.sectionHeadersHovering = NO;
    sectionModel.sectionHeadersHoveringTopEdging = 0;
    return sectionModel;
}
+ (CGXPageCollectionRoundModel *)roundModel
{
    CGXPageCollectionRoundModel *roundModel = [[CGXPageCollectionRoundModel alloc] init];
    roundModel.cornerRadius = 10;
    roundModel.backgroundColor =[UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    
    roundModel.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    roundModel.shadowOffset = CGSizeMake(0,0);
    roundModel.shadowOpacity = 0;
    roundModel.shadowRadius = 10;
    
    roundModel.borderColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    roundModel.borderWidth = 0;
    return roundModel;
}
+ (CGXPageCollectionHeaderModel *)headerModel
{
    CGXPageCollectionHeaderModel *headerModel = [[CGXPageCollectionHeaderModel alloc] initWithHeaderClass:[CGXPageCollectionSectionTextView class] IsXib:NO];
    headerModel.headerBgColor = [UIColor orangeColor];
    headerModel.headerHeight = 40+arc4random() % 20;
    headerModel.isHaveTap = YES;
    return headerModel;
}
+ (CGXPageCollectionFooterModel *)footerModel
{
    CGXPageCollectionFooterModel *footerModel = [[CGXPageCollectionFooterModel alloc] initWithFooterClass:[CGXPageCollectionSectionTextView class] IsXib:NO];
    footerModel.footerBgColor = [UIColor yellowColor];;
    footerModel.footerHeight = 40+arc4random() % 20;
    footerModel.isHaveTap = YES;
    return footerModel;
}

//插入一个分区
+ (CGXPageCollectionGeneralSectionModel *)insertSectionModel
{
    CGXPageCollectionGeneralSectionModel *sectionModel = [[CGXPageCollectionGeneralSectionModel alloc] init];
    sectionModel.row = 2;
    
    CGXPageCollectionHeaderModel *headerModel = [[CGXPageCollectionHeaderModel alloc] initWithHeaderClass:[CGXPageCollectionSectionTextView class] IsXib:NO];
    
    
    headerModel.headerHeight = 40;
    
    headerModel.headerModel = [NSString stringWithFormat:@"头部-%d",0];
    headerModel.headerTag = 10000;
    headerModel.headerBgColor = [UIColor orangeColor];
    sectionModel.headerModel = headerModel;
    CGXPageCollectionFooterModel *footerModel = [[CGXPageCollectionFooterModel alloc] initWithFooterClass:[CGXPageCollectionSectionTextView class] IsXib:NO];
    
    footerModel.footerModel = [NSString stringWithFormat:@"脚部-%d",0];
    footerModel.footerTag = 20000;
    footerModel.footerHeight  = 40;
    footerModel.footerBgColor = [UIColor yellowColor];
    footerModel.footerModel = footerModel;
    
    CGFloat height = 80;
    CGFloat row = arc4random() % 2+2;
    NSMutableArray *itemArr = [NSMutableArray array];
    sectionModel.cellHeight = height;
    for (int i= 0 ; i<row*2; i++) {
        CGXPageCollectionGeneralRowModel *item = [[CGXPageCollectionGeneralRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
        sectionModel.row = row;
        item.dataModel= @"";
        
        item.cellColor = RandomColor;
        [itemArr addObject:item];
    }
    sectionModel.rowArray = [NSMutableArray arrayWithArray:itemArr];
    return sectionModel;
}
@end

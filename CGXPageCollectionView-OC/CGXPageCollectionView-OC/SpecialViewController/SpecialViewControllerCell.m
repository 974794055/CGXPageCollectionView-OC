//
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "SpecialViewControllerCell.h"
@interface SpecialViewControllerCell ()<CGXPageCollectionSpecialViewDelegate>

@property (nonatomic , strong) NSLayoutConstraint *hotTitleTop;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleleft;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleRight;
@property (nonatomic , strong) NSLayoutConstraint *hotTitleBottom;

@end
@implementation SpecialViewControllerCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeViews];
        
        self.viewHeight = 600;
    }
    return self;
}
- (void)initializeViews
{
    self.specialView = [[CGXPageCollectionSpecialView alloc] init];
    [self.contentView addSubview:self.specialView];
    self.specialView.translatesAutoresizingMaskIntoConstraints = NO;
    self.specialView.backgroundColor = [UIColor whiteColor];
    self.specialView.delegate = self;
    self.hotTitleTop = [NSLayoutConstraint constraintWithItem:self.specialView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    self.hotTitleleft = [NSLayoutConstraint constraintWithItem:self.specialView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
    self.hotTitleRight = [NSLayoutConstraint constraintWithItem:self.specialView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
    self.hotTitleBottom = [NSLayoutConstraint constraintWithItem:self.specialView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.hotTitleTop];
    [self.contentView addConstraint:self.hotTitleleft];
    [self.contentView addConstraint:self.hotTitleRight];
    [self.contentView addConstraint:self.hotTitleBottom];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.contentView setNeedsLayout];
    [self.contentView layoutIfNeeded];
    

}

- (void)updateWith:(NSIndexPath *)indexPath
{
    self.hotTitleTop.constant = 0;
    self.hotTitleleft.constant = 0;
    self.hotTitleRight.constant = 0;
    self.hotTitleBottom.constant = 0;

    NSMutableArray *dataArr = [NSMutableArray array];
    for (int i = 0; i<100; i++) {
        CGXPageCollectionSpecialModel *model = [[CGXPageCollectionSpecialModel alloc] init];
        model.itemImageStr = [NSString stringWithFormat:@"HotIcon%d",i % 5];
        model.dataModel = @"";
        model.itemColor = RandomColor;
        model.itemBorderColor = [UIColor blackColor];
        model.itemBorderWidth = 1;
        model.itemBorderRadius = 10;
        model.loadImageCallback = ^(UIImageView * _Nonnull imageView, NSURL * _Nonnull imageURL) {
            
        };
        if (indexPath.section>= 9){
            if (indexPath.section == 11){
                if (i< 13){
                    [dataArr addObject:model];
                }
            } else{
            [dataArr addObject:model];
            }
        } else{
            if (i< 4){
                [dataArr addObject:model];
            }
        }
    }
    if (indexPath.section == 0) {
        self.specialView.showType = indexPath.row % 2 == 0 ? CGXPageCollectionSpecialTypeLR21:CGXPageCollectionSpecialTypeLR12;
    } else if (indexPath.section == 1){
        self.specialView.showType = CGXPageCollectionSpecialTypeLR12;
    } else if (indexPath.section == 2){
        self.specialView.showType = CGXPageCollectionSpecialTypeTB21;
    } else if (indexPath.section == 3){
        self.specialView.showType = CGXPageCollectionSpecialTypeTB12;
    } else if (indexPath.section == 4){
        self.specialView.showType = CGXPageCollectionSpecialTypeL1TB12;
    } else if (indexPath.section == 5){
        self.specialView.showType = CGXPageCollectionSpecialTypeL1TB21;
    } else if (indexPath.section == 6){
        self.specialView.showType = CGXPageCollectionSpecialTypeR1TB12;
    } else if (indexPath.section == 7){
        self.specialView.showType = CGXPageCollectionSpecialTypeR1TB21;
    } else if (indexPath.section == 8){
        self.specialView.showType = CGXPageCollectionSpecialTypeDefaultH;
    } else if (indexPath.section == 9){
        self.specialView.showType = CGXPageCollectionSpecialTypeBig;
    } else{
        self.specialView.showType = CGXPageCollectionSpecialTypeCustom;
    }
    self.specialView.zoomSpace = (arc4random() % 5 + 3.0)/10.0;
    self.specialView.headerHeight = 30;
    self.specialView.footerHeight = 30;
    self.specialView.headerColor = [UIColor orangeColor];
    self.specialView.footerColor = [UIColor yellowColor];
    self.specialView.minimumLineSpacing=10;
    self.specialView.minimumInteritemSpacing=10;
    self.specialView.edgeInsets=UIEdgeInsetsMake(10, 10, 10, 10);
    [self.specialView updateWithDataArray:dataArr];

}

- (UICollectionViewLayoutAttributes*)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
                                               Attributes:(UICollectionViewLayoutAttributes *)attributes
                                                  AtIndex:(NSInteger)index
{
    UIEdgeInsets insets = specialView.edgeInsets;
    CGFloat spaceH = specialView.minimumLineSpacing;
//    CGFloat spaceV = specialView.minimumInteritemSpacing;
    CGFloat headHeight = specialView.headerHeight;
//    CGFloat  footHeight = specialView.footerHeight;
    CGFloat hWidth = CGRectGetWidth(specialView.collectionView.frame)-insets.left-insets.right;
//    CGFloat vHeight = CGRectGetHeight(specialView.collectionView.frame)-insets.top-insets.bottom-headHeight-footHeight;

    CGFloat itemWith = hWidth;
    CGRect rect = CGRectMake(0, 0, 0, 0);
    CGFloat itemH = hWidth/10;
    CGFloat itemCell = itemH-10;
    NSInteger column = itemWith/itemH;
    rect = CGRectMake((index%column)*(itemCell+10)+10, headHeight+insets.top+(index/column)*(itemCell+10), itemCell, itemCell);

    if (index%column==(arc4random() % 2+2) || index%column==column-2) {
        rect = CGRectMake(0, 0, 0, 0);;
    }
    if ((index/column==2&&index%column<2)
        ||(index/column==2&&index%column>column-2)
        ||(index/column==3&&index%column<2)
        ||(index/column==3&&index%column>column-2)) {
        rect = CGRectMake(0, 0, 0, 0);;
    }
    attributes.frame = rect;
    return attributes;
}
/*
 点击事件
 index 下标
 */
- (void)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
        didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"didSelectItemAtIndex---:%ld",index);
}
/*
 自定义heaerView分区
 index 下标
 */
- (void)hotBranndSpecialView:(CGXPageCollectionSpecialView *)specialView
              WithViewHeight:(CGFloat)ViewHeight
{
    NSLog(@"ViewHeight---:%f",ViewHeight);
    self.viewHeight = ViewHeight;
}
@end

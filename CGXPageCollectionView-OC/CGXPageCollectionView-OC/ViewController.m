//
//  ViewController.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "ViewController.h"
#import "ListCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) UICollectionView *collectionView;
@property (strong, nonatomic) NSMutableArray *titleArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(updateColor)];
    self.titleArr =  [NSMutableArray arrayWithObjects:
                      @"普通列表",
                      @"标签流对其方式",
                      @"瀑布流 分区带边框 圆角",
                      @"瀑布流 分区无带边框 圆角",
                      @"不规则 布局",
                      @"水平滚动",
                      @"特殊布局，用于嵌套",// 需要给定高度，然后去计算高度
                      nil];
    [self creatCollectionView];
}
- (void)updateColor
{
    [self.collectionView reloadData];
}
- (void)creatCollectionView
{
    self.collectionView = ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) collectionViewLayout:layout];
        mCollectionView.backgroundColor = [UIColor whiteColor];
        mCollectionView.showsHorizontalScrollIndicator = YES;
        mCollectionView.showsVerticalScrollIndicator = YES;
        mCollectionView.dataSource = self;
        mCollectionView.delegate = self;
        [mCollectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ListCollectionViewCell class])];
        mCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        //给collectionView注册头分区的Id
        [mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        //给collection注册脚分区的id
        [mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        if (@available(iOS 11.0, *)) {
            mCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        mCollectionView;
    });
    [self.view addSubview:self.collectionView];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titleArr.count;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, 0);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.bounds.size.width, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(collectionView.frame.size.width-20,80);
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        return view;
    } else {
        UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        return view;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ListCollectionViewCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArr[indexPath.row];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame));
    borderLayer.lineWidth = 1.f;
    borderLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, CGRectGetWidth(cell.frame), CGRectGetHeight(cell.frame)) cornerRadius:8];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    
    [cell.contentView.layer insertSublayer:borderLayer atIndex:0];
    [cell.contentView.layer setMask:maskLayer];
}
#pragma mark - cell的点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *titleStr = self.titleArr[indexPath.row];
    if (indexPath.row==0) {
        GeneralViewController *vc = [[GeneralViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row==1){
        TagsViewController *vc = [[TagsViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row==2){
        WaterViewController *vc = [[WaterViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        vc.isRoundEnabled = YES;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row==3){
        WaterViewController *vc = [[WaterViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        vc.isRoundEnabled = NO;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (indexPath.row==4){
        IrregularViewController *vc = [[IrregularViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row==5){
        HorizontalViewController *vc = [[HorizontalViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.row==6){
        SpecialViewController *vc = [[SpecialViewController alloc] init];
        vc.title = titleStr;
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end

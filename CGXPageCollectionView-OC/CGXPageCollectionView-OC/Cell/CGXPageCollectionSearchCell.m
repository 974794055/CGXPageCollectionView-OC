//
//  CGXPageCollectionSearchCell.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionSearchCell.h"

@implementation CGXPageCollectionSearchCell

- (void)initializeViews
{
    [super initializeViews];
    self.contentView.backgroundColor = [UIColor blackColor];
    self.searchBar = [[UISearchBar alloc] init];
    //设置背景图是为了去掉上下黑线
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的颜色主题为白色
    self.searchBar.translucent = YES;
    self.searchBar.barTintColor = [UIColor colorWithWhite:0.93 alpha:1];
    self.searchBar.backgroundColor = [UIColor whiteColor];
    self.searchBar.layer.cornerRadius = 4;
    self.searchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    self.searchBar.layer.borderWidth = 1;
    self.searchBar.layer.masksToBounds = YES;
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    self.searchBar.showsCancelButton = NO;
    self.searchBar.barStyle = UIBarMetricsDefault;
    self.searchBar.tintColor = [UIColor blueColor];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"搜索商品";
    self.searchBar.keyboardType = UIKeyboardTypeDefault;
    [self.contentView addSubview: self.searchBar];
    
    [self updateKit:self.searchBar];
}
- (void)updateKit:(UIView *)view
{
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0];
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0];
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
    [self.contentView addConstraint:top];
    [self.contentView addConstraint:left];
    [self.contentView addConstraint:right];
    [self.contentView addConstraint:bottom];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
     [self updateKit:self.searchBar];
}
- (void)updateWithCGXPageCollectionCellModel:(CGXPageCollectionBaseRowModel *)cellModel AtIndex:(NSInteger)index
{
    [super updateWithCGXPageCollectionCellModel:cellModel AtIndex:index];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
//    if (self.searchBlock) {
//        self.searchBlock(searchBar.text);
//    }
    searchBar.text = @"";
    [searchBar resignFirstResponder];//释放第一响应者
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSString *strUrl = [searchText stringByReplacingOccurrencesOfString:@" " withString:@""];
    searchBar.text = strUrl;
}


@end

//
//  CGXPageCollectionSearchCell.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionSearchCell.h"

@interface CGXPageCollectionSearchCell ()

@property (nonatomic , strong) NSLayoutConstraint *top;
@property (nonatomic , strong) NSLayoutConstraint *bottom;
@property (nonatomic , strong) NSLayoutConstraint *left;
@property (nonatomic , strong) NSLayoutConstraint *right;
@end

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
    self.searchBar.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.top = [NSLayoutConstraint constraintWithItem:self.searchBar
                                            attribute:NSLayoutAttributeTop
                                            relatedBy:NSLayoutRelationEqual
                                               toItem:self.contentView
                                            attribute:NSLayoutAttributeTop
                                           multiplier:1.0 constant:0];
    self.left = [NSLayoutConstraint constraintWithItem:self.searchBar
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self.contentView
                                             attribute:NSLayoutAttributeLeft
                                            multiplier:1.0 constant:0];
    self.right = [NSLayoutConstraint constraintWithItem:self.searchBar
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.contentView
                                              attribute:NSLayoutAttributeRight
                                             multiplier:1.0 constant:0];
    self.bottom = [NSLayoutConstraint constraintWithItem:self.searchBar
                                               attribute:NSLayoutAttributeBottom
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:self.contentView
                                               attribute:NSLayoutAttributeBottom
                                              multiplier:1.0 constant:0];
    [self.contentView addConstraint:self.top];
    [self.contentView addConstraint:self.left];
    [self.contentView addConstraint:self.right];
    [self.contentView addConstraint:self.bottom];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.top.constant = 0;
    self.right.constant = 0;
    self.left.constant = 0;
    self.bottom.constant = 0;
    
}
- (void)updateWithCGXPageCollectionCellModel:(CGXPageCollectionBaseRowModel *)cellModel AtIndex:(NSInteger)index
{
    [super updateWithCGXPageCollectionCellModel:cellModel AtIndex:index];
    self.top.constant = 0;
    self.right.constant = 0;
    self.left.constant = 0;
    self.bottom.constant = 0;
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

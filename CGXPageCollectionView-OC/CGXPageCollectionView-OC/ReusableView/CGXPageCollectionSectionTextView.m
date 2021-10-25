//
//  CGXPageCollectionSectionTextView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "CGXPageCollectionSectionTextView.h"
@interface CGXPageCollectionSectionTextView()
@property (nonatomic , strong) NSLayoutConstraint *top;
@property (nonatomic , strong) NSLayoutConstraint *bottom;
@property (nonatomic , strong) NSLayoutConstraint *left;
@property (nonatomic , strong) NSLayoutConstraint *right;
@end
@implementation CGXPageCollectionSectionTextView
- (void)initializeViews
{
    [super initializeViews];
    _titleLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.adjustsFontSizeToFitWidth=YES;
        [self addSubview:label];
        label;
    });
    self.top =  [NSLayoutConstraint constraintWithItem:_titleLabel
                                             attribute:NSLayoutAttributeTop
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self
                                             attribute:NSLayoutAttributeTop
                                            multiplier:1.0
                                              constant:0];
    
    self.left = [NSLayoutConstraint constraintWithItem:_titleLabel
                                             attribute:NSLayoutAttributeLeft
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:self
                                             attribute:NSLayoutAttributeLeft
                                            multiplier:1.0
                                              constant:0];
    
    self.bottom = [NSLayoutConstraint constraintWithItem:_titleLabel
                                               attribute:NSLayoutAttributeBottom
                                               relatedBy:NSLayoutRelationEqual
                                                  toItem:self
                                               attribute:NSLayoutAttributeBottom
                                              multiplier:1.0
                                                constant:0];
    
    self.right = [NSLayoutConstraint constraintWithItem:_titleLabel
                                              attribute:NSLayoutAttributeRight
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self
                                              attribute:NSLayoutAttributeRight
                                             multiplier:1
                                               constant:0];
    [self addConstraint:self.top];
    [self addConstraint:self.bottom];
    [self addConstraint:self.left];
    [self addConstraint:self.right];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    ;
}

- (void)updateWithCGXCollectionViewFooterViewModel:(CGXPageCollectionBaseSectionModel *)sectionModel InSection:(NSInteger)section
{
    [super updateWithCGXCollectionViewFooterViewModel:sectionModel InSection:section];
//    self.titleLabel.backgroundColor = sectionModel.footerModel.footerBgColor;
    self.right.constant = 0;
    self.left.constant = 0;
    self.top.constant = 0;
    self.bottom.constant = 0;
    
    if ([sectionModel isKindOfClass:[CGXPageCollectionGeneralSectionModel class]]) {
        CGXPageCollectionGeneralSectionModel *seee = (CGXPageCollectionGeneralSectionModel *)sectionModel;
        if (seee.isRoundWithFooterView) {
            self.bottom.constant = -seee.borderEdgeInserts.bottom;
        }
    }
//
    if ([self.sectionModel.headerModel.headerModel isKindOfClass:[NSString class]]) {
        self.titleLabel.text = [NSString stringWithFormat:@"脚分区%ld：%@",section,self.sectionModel.headerModel.headerModel];
    } else{
        self.titleLabel.text = [NSString stringWithFormat:@"脚分区--：%ld",section];
    }
}

- (void)updateWithCGXCollectionViewHeaderViewModel:(CGXPageCollectionBaseSectionModel *)sectionModel InSection:(NSInteger)section
{
    [super updateWithCGXCollectionViewHeaderViewModel:sectionModel InSection:section];
//    self.titleLabel.backgroundColor = sectionModel.headerModel.headerBgColor;
    self.right.constant = 0;
    self.left.constant = 0;
    self.top.constant = 0;
    self.bottom.constant = 0;
    if ([sectionModel isKindOfClass:[CGXPageCollectionGeneralSectionModel class]]) {
        CGXPageCollectionGeneralSectionModel *seee = (CGXPageCollectionGeneralSectionModel *)sectionModel;
        if (seee.isRoundWithHeaderView) {
        self.top.constant = seee.borderEdgeInserts.top;
        }
    }
    if ([self.sectionModel.headerModel.headerModel isKindOfClass:[NSString class]]) {
        self.titleLabel.text = [NSString stringWithFormat:@"头分区%ld：%@",section,self.sectionModel.headerModel.headerModel];
    } else{
        self.titleLabel.text = [NSString stringWithFormat:@"头分区--：%ld",section];
    }
}
@end

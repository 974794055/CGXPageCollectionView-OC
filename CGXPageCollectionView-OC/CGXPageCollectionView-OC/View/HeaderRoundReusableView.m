//
//  HeaderRoundReusableView.m
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import "HeaderRoundReusableView.h"

@interface HeaderRoundReusableView()
@property (nonatomic , strong) CGXPageCollectionGeneralSectionModel *sectionModel;
@end
@implementation HeaderRoundReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}

- (void)initialization{
    _myLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        
        label;
    });
    
    [self initLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self initLayout];
}
- (void)initLayout{
    
    [self addConstraints:@[
       //tableview constraints
       [NSLayoutConstraint constraintWithItem:_myLabel
                                    attribute:NSLayoutAttributeTop
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeTop
                                   multiplier:1.0
                                     constant:20],

       [NSLayoutConstraint constraintWithItem:_myLabel
                                    attribute:NSLayoutAttributeLeft
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeLeft
                                   multiplier:1.0
                                     constant:10],

       [NSLayoutConstraint constraintWithItem:_myLabel
                                    attribute:NSLayoutAttributeBottom
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeBottom
                                   multiplier:1.0
                                     constant:0],

       [NSLayoutConstraint constraintWithItem:_myLabel
                                    attribute:NSLayoutAttributeRight
                                    relatedBy:NSLayoutRelationEqual
                                       toItem:self
                                    attribute:NSLayoutAttributeRight
                                   multiplier:1
                                     constant:-10],

    ]];
}

- (void)updateWithCGXCollectionViewHeaderViewModel:(CGXPageCollectionBaseSectionModel *)sectionModel InSection:(NSInteger)section
{
    self.sectionModel=(CGXPageCollectionGeneralSectionModel *)sectionModel;
    if ([self.sectionModel.headerModel.headerModel isKindOfClass:[NSString class]]) {
            self.myLabel.text = [NSString stringWithFormat:@"头分区%ld：%@",section,self.sectionModel.headerModel.headerModel];
    } else{
            self.myLabel.text = [NSString stringWithFormat:@"头分区--：%ld",section];
    }
}
@end

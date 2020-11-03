//
//  CGXPageCollectionHeaderModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionHeaderModel : NSObject
/*
 初始化方法  Class类型 [UICollectionReusableView class]
 */
- (instancetype)initWithHeaderClass:(Class)headerClass IsXib:(BOOL)isXib;
/*
 //类型 UICollectionReusableView 类
 */
@property (nonatomic , strong,readonly) NSString *headerIdentifier;
/*
 //Class类型 [UICollectionReusableView class]
 */
@property (nonatomic, strong,readonly) Class headerClass;
/*
 是否是xib创建
 */
@property (nonatomic , assign,readonly) BOOL headerXib;
/*
 高度
 */
@property (nonatomic , assign) CGFloat headerHeight;
/*
 颜色
 */
@property (nonatomic , strong) UIColor *headerBgColor;
/*
 原始数据
 */
@property (nonatomic , strong) id headerModel;
/*
 设置标签值 默认0
 */
@property (nonatomic , assign) NSInteger headerTag;

/*
 是否有头分区
 */
@property (nonatomic , assign) BOOL isHaveHeader;
/*
是否有头分区点击
*/
@property (nonatomic , assign) BOOL isHaveTap;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

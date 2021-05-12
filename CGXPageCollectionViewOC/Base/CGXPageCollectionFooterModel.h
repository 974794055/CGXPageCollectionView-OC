//
//  CGXPageCollectionFooterModel.h
//  CGXPageCollectionView-OC
//
//  Created by CGX on 2020/6/06.
//  Copyright © 2020 CGX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CGXPageCollectionFooterModel : NSObject
/*
 初始化方法  Class类型 [UICollectionReusableView class]
 */
- (instancetype)initWithFooterClass:(Class)footerClass IsXib:(BOOL)isXib;
/*
 //类型 UICollectionReusableView 类
 */
@property (nonatomic , strong,readonly) NSString *footerIdentifier;
/*
 //Class类型 [UICollectionReusableView class]
 */
@property (nonatomic, strong,readonly) Class footerClass;
/*
 是否是xib创建
 */
@property (nonatomic , assign,readonly) BOOL footerXib;
/*
 高度
 */
@property (nonatomic , assign) CGFloat footerHeight;
/*
 颜色
 */
@property (nonatomic , strong) UIColor *footerBgColor;
/*
 原始数据
 */
@property (nonatomic , strong) id footerModel;
/*
 设置标签值 默认0
 */
@property (nonatomic , assign) NSInteger footerTag;
/*
 是否有脚分区
 */
@property (nonatomic , assign) BOOL isHaveFooter;
/*
是否有头分区点击
*/
@property (nonatomic , assign) BOOL isHaveTap;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END

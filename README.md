# CGXPageCollectionView-OC

[![platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic)](#)
[![languages](https://img.shields.io/badge/language-objective--c-blue.svg)](#) 
[![cocoapods](https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic)](https://cocoapods.org/pods/CGXPageCollectionViewOC)
[![support](https://img.shields.io/badge/support-ios%208%2B-orange.svg)](#) 

## 基于UICollectionView封装库封装列表

- 下载链接：https://github.com/974794055/CGXPageCollectionView-OC.git
-  pod名称 ：CGXPageCollectionViewOC
- 最新版本号： 1.0.2

- 功能：    
- UICollectionView封装的库，分区圆角边框，瀑布流、标签流、不规则布局等主流APP分页列表滚动视图的库封装
 
优点：
- 1、快速搭建项目列表界面；
- 2、提供更加全面丰富、高度自定义的效果；
- 3、使用子类化代理管理cell样式，逻辑更清晰，扩展更简单；
- 4、高度封装列表容器，使用便捷，完美支持列表的生命周期调用；

效果：
- 1、常规列表;
- 2、瀑布流列表;
- 3、标签流列表;
- 4、不规则列表;
- 4、水平滚动列表;
- 5、嵌套固定列表;

## 效果预览
### 库架构预览
说明 | Gif |
----|------|
架构🌈层级架构  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main1.png" width="343" height="350"> |

### 主列表效果预览
说明 | Gif |
----|------|
效果🌈普通列表  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main2.gif" width="287" height="600"> |
效果🌈标签列表  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main3.gif" width="287" height="600"> |
效果🌈瀑布流列表  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main4.gif" width="287" height="600"> |
效果🌈不规则列表  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main5.gif" width="287" height="600"> |
效果🌈水平滚动列表  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main6.gif" width="287" height="600"> |
效果🌈特殊嵌套  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main7.gif" width="287" height="600"> |

### 目的：
- 参考学习如何自定义
- 直接修改自定义示例类以快速实现自己的需求
## 要求
- iOS 8.0+
- Xcode 9+
- Objective-C
## 安装
### 手动
Clone代码，把CGXPageCollectionViewOC文件夹拖入项目，#import "CGXPageCollectionViewOC.h"，就可以使用了；
### CocoaPods
```ruby
target '<Your Target Name>' do
    pod 'CGXPageCollectionViewOC'
end
```
先执行`pod repo update`，再执行`pod install`
## 结构图
<img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main0..png" width="933" height="482">

## 使用

### CGXPageCollectionGeneralView普通布局使用示例

1.初始化CGXPageCollectionGeneralView
```Objective-C
self.generalView = [[CGXPageCollectionGeneralView alloc]  init];
self.generalView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-88-34);
self.generalView.viewDelegate = self;
self.generalView.isShowDifferentColor = YES;
self.generalView.backgroundColor = [UIColor whiteColor];
[self.view addSubview:self.generalView];
[self.generalView registerCell:[CGXPageCollectionTextCell class] IsXib:NO];
[self.generalView registerFooter:[FooterRoundReusableView class] IsXib:NO];
[self.generalView registerHeader:[HeaderRoundReusableView class] IsXib:NO];
[self.generalView registerFooter:[FooterReusableView class] IsXib:NO];
[self.generalView registerHeader:[HeaderReusableView class] IsXib:NO];
```
2.加载CGXPageCollectionGeneralView数据源
```Objective-C
self.titleArr = ({
    NSArray *arr = [NSArray arrayWithObjects:
                    @"有Header&Footer，包Header,包Footer",
                    @"有Header&Footer，包Header,不包Footer",
                    @"有Header&Footer，不包Header,包Footer",
                    @"有Header&Footer，不包Header,不包Footer",
                    @"borderLine 包Section",
                    @"borderLine 包Section（带投影）",
                    @"有sections底色，cell左对齐",
                    @"有sections底色，cell居中",
                    @"有sections底色，cell右对齐",
                    @"cell右对齐与cell右侧开始",
                    nil];
    arr;
});
NSMutableArray *dataArray = [NSMutableArray array];
for (int i = 0; i<self.titleArr.count; i++) {
    CGXPageCollectionGeneralSectionModel *sectionModel = [[CGXPageCollectionGeneralSectionModel alloc] init];
    sectionModel.insets = UIEdgeInsetsMake(10, 10, 10, 10);
    sectionModel.minimumLineSpacing = 10;
    sectionModel.minimumInteritemSpacing = 10;
    sectionModel.row = arc4random() % 5 + 1;
    sectionModel.borderEdgeInserts = UIEdgeInsetsMake(10, 10, 10, 10);
    sectionModel.cellHeight = 50;
    
    CGXPageCollectionHeaderModel *headerModel = [[CGXPageCollectionHeaderModel alloc] initWithHeaderClass:[HeaderRoundReusableView class] IsXib:NO];
    CGXPageCollectionFooterModel *footerModel = [[CGXPageCollectionFooterModel alloc] initWithFooterClass:[FooterRoundReusableView class] IsXib:NO];
    headerModel.headerBgColor = [UIColor orangeColor];
    headerModel.headerHeight = 40+arc4random() % 30;
    headerModel.headerModel = self.titleArr[i];
    headerModel.isHaveTap = YES;
    footerModel.footerBgColor = [UIColor yellowColor];;
    footerModel.footerHeight = 40+arc4random() % 20;;
    footerModel.isHaveTap = YES;
    sectionModel.headerModel = headerModel;
    sectionModel.footerModel = footerModel;

    for (int j = 0; j<sectionModel.row * 2;j++) {
        CGXPageCollectionGeneralRowModel *rowModel = [[CGXPageCollectionGeneralRowModel alloc] initWithCelllass:[CGXPageCollectionTextCell class] IsXib:NO];
        rowModel.cellColor = RandomColor;
        [sectionModel.rowArray addObject:rowModel];
    }
    [dataArray addObject:sectionModel];
}
[self.generalView updateDataArray:dataArray IsDownRefresh:YES Page:1];
```
3.可选实现`CGXPageCollectionUpdateViewDelegate`代理
```Objective-C
/* 展示cell 处理数据 */
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView Cell:(UICollectionViewCell *)cell cellForItemAtIndexPath:(NSIndexPath *)indexPath;
/*点击cell*/
- (void)gx_PageCollectionBaseView:(CGXPageCollectionBaseView *)baseView DidSelectItemAtIndexPath:(NSIndexPath *)indexPath;
```
## 更新记录

### V1.0.0版本
1. 优化头分区、脚分区注册逻辑
2. 增加UICollectionView滚动时代理方法
### V1.0.2版本
1. 增加cell代理方法，便于处理多样化
1. 优化下拉刷新加载问题

如果刚开始使用`CGXPageCollectionViewOC`，当开发过程中需要支持某种特性时，请务必先搜索使用文档或者源代码。确认是否已经实现支持了想要的特性。请别不要文档和源代码都没有看，就直接提问，这对于大家都是一种时间浪费。如果没有支持想要的特性，欢迎提Issue讨论，或者自己实现提一个PullRequest。

该仓库保持随时更新，对于主流新的列表效果会第一时间支持。使用过程中，有任何建议或问题，可以通过以下方式联系我：</br>
邮    箱：974794055@qq.com </br>
群名称：潮流App-iOS交流</br>
QQ  群：227219165</br>
QQ  号：974794055</br>

<img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/authorGroup.png" width="300" height="411">

喜欢就star❤️一下吧

## License

CGXPageCollectionViewOC is released under the MIT license.

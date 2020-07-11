# CGXPageCollectionView-OC

[![platform](https://img.shields.io/badge/platform-iOS-blue.svg?style=plastic)](#)
[![languages](https://img.shields.io/badge/language-objective--c-blue.svg)](#) 
[![cocoapods](https://img.shields.io/badge/cocoapods-supported-4BC51D.svg?style=plastic)](https://cocoapods.org/pods/JXCategoryView)
[![support](https://img.shields.io/badge/support-ios%208%2B-orange.svg)](#) 

基于UICollectionView封装库封装列表

- 下载链接：https://github.com/974794055/CGXPageCollectionView-OC.git
-  pod名称 ：CGXPageCollectionViewOC
- 群名称：
- 群   号：
- 最新版本号： 0.4
- QQ号：974794055
  
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

## 效果预览
### 库架构预览
说明 | Gif |
----|------|
LineView🌈层级架构  |  <img src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main1.png" width="343" height="350"> |

### 主列表效果预览
说明 | Gif |
----|------|
LineView🌈普通列表  |  <img
src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main2.gif" width="287" height="600"> |
LineView🌈标签列表  |  <img
src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main3.gif" width="287" height="600"> |
LineView🌈瀑布流列表  |  <img
src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main4.gif" width="287" height="600"> |
LineView🌈不规则列表  |  <img
src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main5.gif" width="287" height="600"> |
LineView🌈水平滚动列表  |  <img
src="https://github.com/974794055/CGXPageCollectionView-OC/blob/master/CGXPageCollectionViewImageGif/main6.gif" width="287" height="600"> |

目的：
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


## 补充

如果刚开始使用`CGXPageCollectionViewOC`，当开发过程中需要支持某种特性时，请务必先搜索使用文档或者源代码。确认是否已经实现支持了想要的特性。请别不要文档和源代码都没有看，就直接提问，这对于大家都是一种时间浪费。如果没有支持想要的特性，欢迎提Issue讨论，或者自己实现提一个PullRequest。

该仓库保持随时更新，对于主流新的分类选择效果会第一时间支持。使用过程中，有任何建议或问题，可以通过以下方式联系我：</br>
邮箱：974794055@qq.com </br>
QQ群： 
<img src="" width="300" height="411">

喜欢就star❤️一下吧

## License

CGXPageCollectionViewOC is released under the MIT license.

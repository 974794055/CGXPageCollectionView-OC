Pod::Spec.new do |s|
    s.name         = "CGXPageCollectionViewOC"    #存储库名称
    s.version      = "1.0.4"      #版本号，与tag值一致
    s.summary      = "CGXPageCollectionView-OC是基于UICollectionView封装的库，分区圆角边框，瀑布流、标签流等主流APP分页列表滚动视图的库)"  #简介
    s.description  = "(UICollectionView封装的库，分区圆角边框，瀑布流、标签流、不规则布局、特殊布局等主流APP分页列表滚动视图的库封装"  #描述
    s.homepage     = "https://github.com/974794055/CGXPageCollectionView-OC"      #项目主页，不是git地址
    s.license      = { :type => "MIT", :file => "LICENSE" }   #开源协议
    s.author             = { "974794055" => "974794055@qq.com" }  #作者
    s.platform     = :ios, "8.0"                  #支持的平台和版本号
    s.source       = { :git => "https://github.com/974794055/CGXPageCollectionView-OC.git", :tag => s.version }         #存储库的git地址，以及tag值
    s.requires_arc = true #是否支持ARC
    s.frameworks = 'UIKit','QuartzCore'
    s.pod_target_xcconfig = {'OTHER_LDFLAGS' => ['-lObjC', '-all_load']}
    #需要托管的源代码路径
    s.source_files = 'CGXPageCollectionViewOC/CGXPageCollectionViewOC.h'
    #开源库头文件
    s.public_header_files = 'CGXPageCollectionViewOC/CGXPageCollectionViewOC.h'
    s.subspec 'Common' do |ss|
        ss.source_files = 'CGXPageCollectionViewOC/Common/**/*.{h,m}'
    end
    s.subspec 'Base' do |ss|
        ss.source_files = 'CGXPageCollectionViewOC/Base/**/*.{h,m}'
        ss.dependency 'CGXPageCollectionViewOC/Common'
    end
    s.subspec 'Water' do |ss|
        ss.source_files = 'CGXPageCollectionViewOC/Water/**/*.{h,m}'
        ss.dependency 'CGXPageCollectionViewOC/Base'
    end
    s.subspec 'General' do |ss|
        ss.source_files = 'CGXPageCollectionViewOC/General/**/*.{h,m}'
        ss.dependency 'CGXPageCollectionViewOC/Base'
    end
    s.subspec 'IrregularView' do |ss|
        ss.source_files = 'CGXPageCollectionViewOC/IrregularView/**/*.{h,m}'
        ss.dependency 'CGXPageCollectionViewOC/Base'
    end
    s.subspec 'Tags' do |ss|
        ss.source_files = 'CGXPageCollectionViewOC/Tags/**/*.{h,m}'
        ss.dependency 'CGXPageCollectionViewOC/Base'
    end
    s.subspec 'Horizontal' do |ss|
        ss.source_files = 'CGXPageCollectionViewOC/Horizontal/**/*.{h,m}'
        ss.dependency 'CGXPageCollectionViewOC/Base'
    end
    s.subspec 'SpecialView' do |ss|
        ss.source_files = 'CGXPageCollectionViewOC/SpecialView/**/*.{h,m}'
        ss.dependency 'CGXPageCollectionViewOC/Base'
    end
end





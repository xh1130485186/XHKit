Pod::Spec.new do |s|

  s.name         = "XiangHongKit"
  s.version      = "0.4.3"
  s.summary      = "framework"
  s.description  = <<-DESC
            Initialize the
                   DESC

  s.homepage     = "https://github.com/xh1130485186/XHKit"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  
  s.author             = { "xianghong" => "1130485186@qq.com" }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/xh1130485186/XHKit.git", :tag => s.version }

  s.resources = "xhkit.bundle"

  s.requires_arc = true
  s.public_header_files = 'Extensions/**/*.h', 'Common/*.h', 'Tools/**/*.h'
  s.source_files = 'XHKit.h'

  s.subspec 'Extensions' do |ss|

    ss.subspec 'DZNEmptyDataSet' do |sss|
      sss.source_files = 'Extensions/DZNEmptyDataSet/*.{h,m}'
    end

    ss.subspec 'NSAttributedString' do |sss|
      sss.source_files = 'Extensions/NSAttributedString/*.{h,m}'
    end

    ss.subspec 'NSDate' do |sss|
      sss.source_files = 'Extensions/NSDate/*.{h,m}'
    end

    ss.subspec 'NSObject' do |sss|
      sss.source_files = 'Extensions/NSObject/*.{h,m}'
    end

    ss.subspec 'NSString' do |sss|
      sss.source_files = 'Extensions/NSString/*.{h,m}'
    end

    ss.subspec 'UIApplication' do |sss|
      sss.source_files = 'Extensions/UIApplication/*.{h,m}'
    end

    ss.subspec 'UIColor' do |sss|
      sss.source_files = 'Extensions/UIColor/*.{h,m}'
    end

    ss.subspec 'UIImage' do |sss|
      sss.dependency 'XiangHongKit/Extensions/UIColor'
      sss.source_files = 'Extensions/UIImage/*.{h,m}'
    end

    ss.subspec 'UIView' do |sss|
      sss.source_files = 'Extensions/UIView/*.{h,m}'
    end

    ss.subspec 'UIViewController' do |sss|
      sss.source_files = 'Extensions/UIViewController/*.{h,m}'
    end

  end

  s.subspec 'Common' do |ss|
    ss.dependency 'XiangHongKit/Extensions/DZNEmptyDataSet'
    ss.dependency 'XiangHongKit/Extensions/UIView'
    ss.dependency 'XiangHongKit/Extensions/UIImage'
    ss.source_files = 'Common/*.{h,m}'
  end

  s.subspec 'Tools' do |ss|

    ss.subspec 'QMUIKeyboard' do |sss|
      sss.source_files = 'Tools/QMUIKeyboard/*.{h,m}'
    end

    ss.subspec 'RFJModel' do |sss|
      sss.source_files = 'Tools/RFJModel/*.{h,m}'
    end

    ss.subspec 'XHFile' do |sss|
      sss.source_files = 'Tools/XHFile/*.{h,m}'
    end

    ss.subspec 'XHKeychain' do |sss|
      sss.source_files = 'Tools/XHKeychain/*.{h,m}'
    end

    ss.subspec 'XHLocation' do |sss|
      sss.source_files = 'Tools/XHLocation/*.{h,m}'
    end

    ss.subspec 'XHTimer' do |sss|
      sss.source_files = 'Tools/XHTimer/*.{h,m}'
    end

  end

end

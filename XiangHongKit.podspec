Pod::Spec.new do |s|

  s.name         = "XiangHongKit"
  s.version      = "0.4.6"
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
  s.public_header_files = 'XHKit.h'
  s.source_files = 'XHKit.h'

  s.subspec 'Extensions' do |ss|

    ss.subspec 'DZNEmptyDataSet' do |sss|
      sss.source_files = 'Extensions/DZNEmptyDataSet/*.{h,m}'
      sss.public_header_files = 'Extensions/DZNEmptyDataSet/*.{h}'
    end

    ss.subspec 'NSAttributedString' do |sss|
      sss.source_files = 'Extensions/NSAttributedString/*.{h,m}'
      sss.public_header_files = 'Extensions/NSAttributedString/*.{h}'
    end

    ss.subspec 'NSDate' do |sss|
      sss.source_files = 'Extensions/NSDate/*.{h,m}'
      sss.public_header_files = 'Extensions/NSDate/*.{h}'
    end

    ss.subspec 'NSObject' do |sss|
      sss.source_files = 'Extensions/NSObject/*.{h,m}'
      sss.public_header_files = 'Extensions/NSObject/*.{h}'
    end

    ss.subspec 'NSString' do |sss|
      sss.source_files = 'Extensions/NSString/*.{h,m}'
      sss.public_header_files = 'Extensions/NSString/*.{h}'
    end

    ss.subspec 'UIApplication' do |sss|
      sss.source_files = 'Extensions/UIApplication/*.{h,m}'
      sss.public_header_files = 'Extensions/UIApplication/*.{h}'
    end

    ss.subspec 'UIColor' do |sss|
      sss.source_files = 'Extensions/UIColor/*.{h,m}'
      sss.public_header_files = 'Extensions/UIColor/*.{h}'
    end

    ss.subspec 'UIImage' do |sss|
      sss.dependency 'XiangHongKit/Extensions/UIColor'
      sss.source_files = 'Extensions/UIImage/*.{h,m}'
      sss.public_header_files = 'Extensions/UIImage/*.{h}'
    end

    ss.subspec 'UIView' do |sss|
      sss.source_files = 'Extensions/UIView/*.{h,m}'
      sss.public_header_files = 'Extensions/UIView/*.{h}'
    end

    ss.subspec 'UIViewController' do |sss|
      sss.source_files = 'Extensions/UIViewController/*.{h,m}'
      sss.public_header_files = 'Extensions/UIViewController/*.{h}'
    end

  end

  s.subspec 'Common' do |ss|
    ss.dependency 'XiangHongKit/Extensions/DZNEmptyDataSet'
    ss.dependency 'XiangHongKit/Extensions/UIView'
    ss.dependency 'XiangHongKit/Extensions/UIImage'
    ss.dependency 'XiangHongKit/Extensions/UIViewController'
    ss.source_files = 'Common/*.{h,m}'
    ss.public_header_files = 'Common/*.{h}'
  end

  s.subspec 'Tools' do |ss|

    ss.subspec 'QMUIKeyboard' do |sss|
      sss.source_files = 'Tools/QMUIKeyboard/*.{h,m}'
      sss.public_header_files = 'Tools/QMUIKeyboard/*.{h}'
    end

    ss.subspec 'RFJModel' do |sss|
      sss.source_files = 'Tools/RFJModel/*.{h,m}'
      sss.public_header_files = 'Tools/RFJModel/*.{h}'
    end

    ss.subspec 'XHFile' do |sss|
      sss.source_files = 'Tools/XHFile/*.{h,m}'
      sss.public_header_files = 'Tools/XHFile/*.{h}'
    end

    ss.subspec 'XHKeychain' do |sss|
      sss.source_files = 'Tools/XHKeychain/*.{h,m}'
      sss.public_header_files = 'Tools/XHKeychain/*.{h}'
    end

    ss.subspec 'XHLocation' do |sss|
      sss.source_files = 'Tools/XHLocation/*.{h,m}'
      sss.public_header_files = 'Tools/XHLocation/*.{h}'
    end

    ss.subspec 'XHTimer' do |sss|
      sss.source_files = 'Tools/XHTimer/*.{h,m}'
      sss.public_header_files = 'Tools/XHTimer/*.{h}'
    end

  end

end

Pod::Spec.new do |s|
  s.name             = 'TQBaseProject'
  s.version          = '0.0.3'
  s.summary          = 'TQBaseProject'
  s.homepage         = 'https://github.com/worksq/TQBaseProject'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'worksq' => 'worksq@yeah.net' }
  s.source           = { :git => 'https://github.com/worksq/TQBaseProject.git', :tag => "0.0.3" }
  s.frameworks = 'UIKit'
  s.requires_arc     = true
  s.ios.deployment_target = '8.0'
  

s.subspec 'Base' do |ss|
    ss.source_files = 'TQBaseProject/GlobalBase/Base/*.h'
    ss.public_header_files = 'TQBaseProject/GlobalBase/Base/*.h'
  end

   s.subspec 'Controller' do |ss|
    ss.source_files = 'TQBaseProject/GlobalBase/Controller/*.h'
    ss.public_header_files = 'TQBaseProject/GlobalBase/Base/*.h'
  end

  s.subspec 'Gategory' do |ss|
    ss.source_files = 'TQBaseProject/GlobalBase/Gategory/*.h'
    ss.public_header_files = 'TQBaseProject/GlobalBase/Base/*.h'
  end

  s.subspec 'Model' do |ss|
    ss.source_files = 'TQBaseProject/GlobalBase/Model/*.h'
    ss.public_header_files = 'TQBaseProject/GlobalBase/Base/*.h'
  end

  s.subspec 'Resouce' do |ss|
    ss.source_files = 'TQBaseProject/GlobalBase/Resouce/*'
    
  end

  s.subspec 'Service' do |ss|
    ss.source_files = 'TQBaseProject/GlobalBase/Service/*.h'
    ss.public_header_files = 'TQBaseProject/GlobalBase/Base/*.h'
  end

  s.subspec 'Tool' do |ss|
    ss.source_files = 'TQBaseProject/GlobalBase/Tool/*.h'
    ss.public_header_files = 'TQBaseProject/GlobalBase/Base/*.h'
  end

  s.subspec 'View' do |ss|
    ss.source_files = 'TQBaseProject/GlobalBase/View/*.h','TQBaseProject/GlobalBase/View/JYCustomAlertView/*.h','TQBaseProject/GlobalBase/View/ZFChart/*.h'
    ss.public_header_files = 'TQBaseProject/GlobalBase/Base/*.h'
  end
  
  s.dependency 'MBProgressHUD'
  s.dependency 'CocoaLumberjack'
  s.dependency 'MMPopupView'
  s.dependency 'YYCategories'
  s.dependency 'YYModel'
  s.dependency 'YYText'
  s.dependency 'QMUIKit'
  s.dependency 'MJRefresh','~> 3.1.15'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'FDFullscreenPopGesture', '~> 1.1'
  s.dependency 'BlocksKit'
  s.dependency 'RETableViewManager'
  s.dependency 'YTKNetwork'

end
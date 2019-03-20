Pod::Spec.new do |s|
  s.name             = 'TQBaseProject'
  s.version          = '0.0.3'
  s.summary          = 'TQBaseProject'
  s.homepage         = 'https://github.com/worksq/TQBaseProject'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'worksq' => 'worksq@yeah.net' }
  s.source           = { :git => 'https://github.com/worksq/TQBaseProject.git', :tag => "0.0.3" }
  s.requires_arc     = true
  s.ios.deployment_target = '8.0'

  s.default_subspec = 'All'
  s.subspec 'All' do |ss|
    ss.dependency 'TQBaseProject/Controller'
    ss.dependency 'TQBaseProject/Gategory'
    ss.ios.dependency 'TQBaseProject/Model'
    ss.ios.dependency 'TQBaseProject/Resouce'
    ss.ios.dependency 'TQBaseProject/Service'
    ss.ios.dependency 'TQBaseProject/Tool'
    ss.ios.dependency 'TQBaseProject/View'
  end

   s.subspec 'Controller' do |ss|
    ss.source_files = 'TQBaseProject/Controller/*.{h,m}'
  end

  s.subspec 'Gategory' do |ss|
    ss.source_files = 'TQBaseProject/Gategory/*.{h,m}'
  end

  s.subspec 'Model' do |ss|
    ss.source_files = 'TQBaseProject/Model/*.{h,m}'
  end

  s.subspec 'Resouce' do |ss|
    ss.source_files = 'TQBaseProject/Resouce/*'
  end

  s.subspec 'Service' do |ss|
    ss.source_files = 'TQBaseProject/Service/*.{h,m}'
  end

  s.subspec 'Tool' do |ss|
    ss.source_files = 'TQBaseProject/Tool/*.{h,m}'
  end

  s.subspec 'View' do |ss|
    ss.source_files = 'TQBaseProject/View/*.{h,m}'
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
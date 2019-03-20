
Pod::Spec.new do |s|
  s.name             = 'TQBaseProject'
  s.version          = '0.0.2'
  s.summary          = 'TQBaseProject'
  s.homepage         = 'https://github.com/worksq/TQBaseProject'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'worksq' => 'worksq@yeah.net' }
  s.source           = { :git => 'https://github.com/worksq/TQBaseProject.git', :tag => "0.0.2" }
  s.requires_arc     = true
  s.ios.deployment_target = '8.0'

  s.source_files  = 'TQBaseProject/GlobalBase/**/*'
  s.public_header_files = 'TQBaseProject/GlobalBase/**/*.h'
  
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
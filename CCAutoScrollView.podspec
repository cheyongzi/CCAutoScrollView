#
#  Be sure to run `pod spec lint CCAutoScrollView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = 'CCAutoScrollView'
  s.version      = '2.0.3'
  s.summary      = '基于CollectionView实现的用户可自定义cell的循环滚动库'
  s.description  = '基于CollectionView实现的用户可自定义cell的循环滚动库'
  s.homepage     = 'https://github.com/cheyongzi/CCAutoScrollView'
  s.license      = 'MIT'
  s.author             = { '车勇子' => '389936133@qq.com' }
  s.ios.deployment_target = '8.0'
  s.platform = :ios, '8.0'
  s.source       = { :git => 'https://github.com/cheyongzi/CCAutoScrollView.git', :tag => s.version }
  s.source_files  = 'AutoScrollView/*.swift'

end

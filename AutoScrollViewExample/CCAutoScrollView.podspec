#
#  Be sure to run `pod spec lint CCAutoScrollView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "CCAutoScrollView"
  s.version      = "2.0"
  s.summary      = "基于CollectionView实现的用户可自定义cell的循环滚动库"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = "基于CollectionView实现的用户可自定义cell的循环滚动库"

  s.homepage     = "https://github.com/cheyongzi/CCAutoScrollView"

  s.license      = "MIT CCAutoScrollView"

  s.author             = { "车勇子" => "389936133@qq.com" }


   s.ios.deployment_target = "8.0"
	s.ios.framework    = 'UIKit'

  s.source       = { :git => "https://github.com/cheyongzi/CCAutoScrollView.git", :tag => "2.0" }

  s.source_files  = "AutoScrollViewExample/AutoScrollView/*.swift"


  s.requires_arc = true

end

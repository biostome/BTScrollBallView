#
# Be sure to run `pod lib lint BTScrollBallView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BTScrollBallView'
  s.version          = '0.1.1'
  s.summary          = 'a scroll ball view, like slot machine scorll animate effect'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
a scroll ball view, just like the animation effect of slot machine, can customize each cell view
                       DESC

  s.homepage         = 'https://github.com/biostome/BTScrollBallView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'biostome' => '453816118@qq.com' }
  s.source           = { :git => 'https://github.com/biostome/BTScrollBallView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'BTScrollBallView/Classes/**/*'
  
  s.resource_bundles = {
    'BTScrollBallView' => ['BTScrollBallView/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

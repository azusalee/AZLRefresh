#
# Be sure to run `pod lib lint AZLRefresh.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AZLRefresh'
  s.version          = '0.1.1'
  s.summary          = '下拉刷新控件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 一个swift写的，用于iOS的下拉上拉刷新控件
                       DESC

  s.homepage         = 'https://github.com/azusalee/AZLRefresh'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'azusalee' => '384433472@qq.com' }
  s.source           = { :git => 'https://github.com/azusalee/AZLRefresh.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'

  s.source_files = 'AZLRefresh/Classes/**/*'
  s.resource     = 'AZLRefresh/Resources/AZLRefresh.bundle'
  
  # s.resource_bundles = {
  #   'AZLRefresh' => ['AZLRefresh/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

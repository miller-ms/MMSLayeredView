#
# Be sure to run `pod lib lint MMSLayeredView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MMSLayeredView'
  s.version          = '0.1.0'
  s.summary          = 'Provides the features to layer views on top of a background view'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This class supports layering 1 or more views upon a background view. The user can resize, scale, and move each subview. They can select one of them for focus of operations and set the background view.  The class supports a method to merge the background and subviews into an image.  One application of this class would be to layer text over a photo and export the merged image to a file for submitting to your text messages or social networks.
                       DESC

  s.homepage         = 'https://github.com/<GITHUB_USERNAME>/MMSLayeredView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'William Miller' => 'support@millermobilesoft.com' }
  s.source           = { :git => 'https://github.com/miller-ms/MMSLayeredView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MMSLayeredView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MMSLayeredView' => ['MMSLayeredView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end

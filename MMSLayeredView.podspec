#
# Be sure to run `pod lib lint MMSLayeredView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MMSLayeredView'
  s.version          = '1.0.4'
  s.summary          = 'Provides the features to layer views on top of a background view with gestures to move, scale, resize, and give them focus.'
  s.description      = <<-DESC
This class supports layering 1 or more views upon a background view. The user can resize, scale, and move each subview. They can select one of them for focus of operations and set a background view.  The class supports a method to merge the background and subviews into an image.  Use the pinch gesture to scale a subview; two finger drag gesture to move a subview; one finger drag gesture to size each dimension independently; and the tap gesture to change or remove focus.  One application of this class would be to layer text over a photo and export the merged image to a file for submitting to your text messages or social networks.  Another application would be for an application to add decorations to an image.
                       DESC

  s.homepage         = 'https://github.com/miller-ms/MMSLayeredView'
  s.screenshots      = 'https://raw.githubusercontent.com/miller-ms/MMSLayeredView/master/screenshot.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'William Miller' => 'support@millermobilesoft.com' }
  s.source           = { :git => 'https://github.com/miller-ms/MMSLayeredView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.ios.deployment_target = '8.3'
  s.source_files = 'MMSLayeredView/Classes/**/*'
  s.frameworks = 'UIKit'
end

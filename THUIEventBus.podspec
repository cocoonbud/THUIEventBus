#
# Be sure to run `pod lib lint THUIEventBus.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'THUIEventBus'
  s.version          = '0.1.3'
  s.summary          = 'A lightweight event delivery tool between views.'

  s.description      = <<-DESC
Based on the event response chain events are passed from top to bottom.
Deliver events from the bottom to the top layer based on UI view hierarchy.
                       DESC

  s.homepage         = 'https://github.com/cocoonbud/THUIEventBus'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cocoonbud' => 'cocoonbud@gmail.com' }
  s.source           = { :git => 'https://github.com/cocoonbud/THUIEventBus.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'THUIEventBus/Classes/**/*'
  
  # s.resource_bundles = {
  #   'THUIEventBus' => ['THUIEventBus/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

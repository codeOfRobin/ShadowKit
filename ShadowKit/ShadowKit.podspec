#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ShadowKit'
  s.version          = '0.1.0'
  s.summary          = 'Creates colored shadows like  MUSIC'

  s.description      = s.summary

  s.homepage         = 'https://github.com/codeOfRobin/shadowkit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Robin Malhotra' => 'me@rmalhotra.com' }
  s.source           = { :git => 'https://github.com/codeOfRobin/ShadowKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/iavins'

  s.ios.deployment_target = '10.0'

  s.source_files = './ShadowKit/*.swift'
end
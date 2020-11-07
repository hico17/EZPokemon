Pod::Spec.new do |spec|
  spec.name             = 'Utilities'
  spec.version          = '0.0.1'
  spec.license          = { :type => 'BSD' }
  spec.authors          = { 'Luca Celiento' => '' }
  spec.homepage         = 'https://linkToHomePage'
  spec.source           = { :git => '', :tag => '' }
  spec.summary          = 'Utility class for iOS'
  spec.source_files     = 'Sources/**/*.{h,m,swift}'
  spec.framework        = 'SystemConfiguration'
  spec.requires_arc     = true
  spec.ios.deployment_target  = '11.0'
  spec.dependency 'RxSwift', '6.0.0-rc.1'
end
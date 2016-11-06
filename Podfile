#
#   Created by : Nghia Tran
#   Sun, 25th Sept 2016, Vietnam
#

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
workspace 'Titan.xcworkspace'

# Pods
def important_pods
    pod 'Alamofire', '~> 4.0'
    pod 'ReSwift', :git => 'https://github.com/ReSwift/ReSwift.git', :tag => '2.1.0'
    pod 'SwiftyBeaver', :git => 'https://github.com/SwiftyBeaver/SwiftyBeaver.git', :tag => '1.1.0'
    pod 'ObjectMapper', :git => 'https://github.com/Hearst-DD/ObjectMapper.git', :tag => '2.1.0'
    pod 'RxSwift',    '3.0.0-rc.1'
    pod 'RxCocoa',    '3.0.0-rc.1'
    pod 'RxOptional', :git => 'https://github.com/RxSwiftCommunity/RxOptional.git', :tag => '3.1.2'
    
    # Realm
    pod 'RxRealm'
    pod 'RealmSwift'
end

# Test
def test_pods
    pod 'Quick'
    pod 'Nimble', '~> 4.0.0'
end

# macOS
target "Titan" do
  project 'Titan.xcodeproj'
  platform :osx, '10.11'
  important_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.11'
    end
  end
end

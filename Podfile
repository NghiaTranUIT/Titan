#
#   Created by : Nghia Tran
#   Sun, 25th Sept 2016, Vietnam
#

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
workspace 'Titan.xcworkspace'

# Pods
def important_pods
    pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :tag => '4.3.0'
    pod 'ReSwift', :git => 'https://github.com/ReSwift/ReSwift.git', :tag => '2.1.0'
    pod 'SwiftyBeaver', :git => 'https://github.com/SwiftyBeaver/SwiftyBeaver.git', :tag => '1.1.0'
    pod 'ObjectMapper', :git => 'https://github.com/Hearst-DD/ObjectMapper.git', :tag => '2.2.2'
    pod 'DynamicColor', '~> 3.1.0'
    pod 'KVOController'
    pod 'SnapKit', '~> 3.1.2'

    # Can't use Promise kit in pod
    # Always get: Cannot define category for undefined class 'OS_dispatch_queue'
    # (」゜ロ゜)」
    #pod 'PromiseKit', '~> 4.0'
    #

    # Realm
    pod 'RealmSwift'
end

# Test
def test_pods
    pod 'Quick', '~> 0.10.0'
    pod 'Nimble', '~> 5.0.0'
end

# Titan
target "Titan" do
  project 'Titan.xcodeproj'
  platform :osx, '10.12'
  important_pods
end

# Titan Test
target "TitanTests" do
    project 'Titan.xcodeproj'
    platform :osx, '10.12'
    important_pods
    test_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.12'
    end
  end
end

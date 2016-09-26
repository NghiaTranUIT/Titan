#
#   Created by : Nghia Tran
#   Sun, 25th Sept 2016, Vietnam
#

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
workspace 'Titan.xcworkspace'

# Pods
def important_pods
    pod 'Alamofire', '4.0'
end

# macOS
target "Titan" do
  xcodeproj 'Titan.xcodeproj'
  platform :osx, '10.11'
  important_pods
end

# iOS
target "Titan iOS" do
  xcodeproj 'Titan iOS/Titan iOS.xcodeproj'
  platform :ios, '10.0'
  important_pods
end

source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!
workspace 'Titan.xcworkspace'

def important_pods
    pod 'Alamofire', '4.0'
end

target "Titan" do
  xcodeproj 'Titan.xcodeproj'
   platform :osx, '10.11'
   important_pods
end


target "Titan iOS" do
  xcodeproj 'Titan iOS/Titan iOS.xcodeproj'
  platform :ios, '10.0'
  important_pods
end

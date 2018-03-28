Pod::Spec.new do |s|

s.name         = "SPTextField"
s.version      = "0.1"
s.author       = { "R4L" => "ralphwayne1991@gmail.com" }
s.summary      = "Animated TextField"
s.description  = <<-DESC
Animated TextField with warning message.
DESC
s.homepage     = "http://flashhand.github.io"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.platform = :ios
s.ios.deployment_target = "7.0"
s.source = { :git => "https://github.com/FlashHand/SPTextField.git", :tag => "v0.1" }
s.public_header_files = "SPTextField/*.h","SPTextField/**/*.h"
s.source_files = "SPTextField/**/*.{h,m}"
s.ios.frameworks   = "Foundation","UIKit"
s.requires_arc = true
end


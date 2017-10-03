Pod::Spec.new do |s|
  s.name         = "MCJSONKit"
  s.version      = "0.1.0"
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.summary      = "A fast and convenient conversion between JSON and model"
  s.homepage     = "https://github.com/mylcode/MCJSONKit"
  s.license      = "MIT"
  s.author             = { "mylcode" => "mylcode.ali@gmail.com" }
  s.source       = { :git => "https://github.com/mylcode/MCJSONKit.git" }
  s.source_files  = "MCJSONKit"
  s.requires_arc = true
end

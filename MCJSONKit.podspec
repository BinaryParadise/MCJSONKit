Pod::Spec.new do |s|
  s.name         = "MCJSONKit"
  s.version      = "0.1.5"
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.summary      = "A fast and convenient conversion between JSON and model"
  s.description  = <<-DESC
A fast and convenient conversion between JSON and model.Magical Data Modeling Framework for JSON - allows rapid creation of smart data models.
DESC

  s.homepage     = "https://github.com/mylcode/MCJSONKit"
  s.license      = "MIT"
  s.author       = { "mylcode" => "mylcode.ali@gmail.com" }
  s.source       = { :git => 'https://github.com/mylcode/MCJSONKit.git', :tag => s.version.to_s }
  s.source_files = "MCJSONKit/Classes/**/*"
  s.requires_arc = true
  s.dependency "MCLogger", "~> 0.1.3"
end

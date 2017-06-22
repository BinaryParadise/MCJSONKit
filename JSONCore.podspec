Pod::Spec.new do |s|
  s.name         = "JSONCore"
  s.version      = "0.0.2"
  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.7'
  s.summary      = "A fast and convenient conversion between JSON and model"
  s.homepage     = "https://github.com/kbonana/JSONCore"
  s.license      = "MIT"
  s.author             = { "bonana" => "rmacbookpro@163.com" }
  s.social_media_url   = "http://weibo.com/fenglaijun"
  s.source       = { :git => "https://github.com/kbonana/JSONCore.git" }
  s.source_files  = "JSONCore"
  s.requires_arc = true
end

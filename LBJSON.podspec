Pod::Spec.new do |s|
  s.name             = "LBJSON"
  s.version          = "2.0.0"
  s.summary          = "LBJSON framework"
  s.description      = <<-DESC
                       LBJSON framework is a Swift Enum which helps working with JSON.
                       DESC
  s.homepage         = "https://github.com/lucianboboc/"
  s.license          = 'MIT'
  s.author           = { "Lucian Boboc" => "info@lucianboboc.com" }
  s.social_media_url = 'http://twitter.com/lucianboboc'
  s.source           = { :git => "https://github.com/lucianboboc/LBJSON.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'LBJSON/*.swift'
  
end
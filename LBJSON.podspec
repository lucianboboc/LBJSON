Pod::Spec.new do |s|
  s.name = "LBJSON"
  s.version = "3.0.0"
  s.license = 'MIT'
  s.summary = "LBJSON framework"
  s.homepage = "https://github.com/lucianboboc/"
  s.social_media_url = 'http://twitter.com/lucianboboc'
  s.author = { "Lucian Boboc" => "info@lucianboboc.com" }
  s.source = { :git => "https://github.com/lucianboboc/LBJSON.git", :tag => s.version.to_s }
  s.description      = <<-DESC
                       LBJSON framework is a Swift Enum which helps working with JSON.
                       DESC

  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'LBJSON/*.swift'
end

Pod::Spec.new do |s|
  s.name = "LBJSON"
  s.version = "4.0.1"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary = "LBJSON framework"
  s.homepage = "https://github.com/lucianboboc/"
  s.social_media_url = 'http://twitter.com/lucianboboc'
  s.author = { "Lucian Boboc" => "info@lucianboboc.com" }
  s.source = { :git => "https://github.com/lucianboboc/LBJSON.git", :tag => s.version.to_s }
  s.description      = <<-DESC
                       LBJSON framework is a Swift Enum which helps working with JSON.
                       DESC

  s.platform     = :ios, '9.0'
  s.requires_arc = true
  s.source_files = 'LBJSON/*.swift'
  s.swift_version = '4.2'
end

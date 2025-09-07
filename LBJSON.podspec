Pod::Spec.new do |s|
  s.name = "LBJSON"
  s.version = "6.0.0"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.summary = "LBJSON framework"
  s.homepage = "https://github.com/lucianboboc/LBJSON"
  s.social_media_url = 'http://twitter.com/lucianboboc'
  s.author = { "Lucian Boboc" => "info@lucianboboc.com" }
  s.source = { :git => "https://github.com/lucianboboc/LBJSON.git", :tag => s.version.to_s }
  s.description      = <<-DESC
                       LBJSON framework is a Swift Enum which helps working with JSON.
                       DESC

  s.platform     = :ios, '13.0'
  s.requires_arc = true
  s.ios.deployment_target = "13.0"
  s.source_files = 'Sources/LBJSON/**/*.{h,m,swift}'
  s.public_header_files = 'Sources/LBJSON/*.h'
  s.swift_version = '5.10'
  s.resource_bundles = {
    'LBJSON' => ['Sources/LBJSON/PrivacyInfo.xcprivacy']
  }
  s.exclude_files = ['**/Info.plist']
end

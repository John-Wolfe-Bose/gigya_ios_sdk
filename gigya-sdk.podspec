Pod::Spec.new do |s|
s.name              = 'gigya-sdk'
s.version           = '3.6.0'
s.summary           = 'The iOS client library provides an Objective-C interface for the Gigya API'
s.homepage          = 'http://developers.gigya.com/display/GD/iOS'

s.author            = { 'Name' => 'sdks-team@gigya-inc.com' }

s.license           = { :type => 'Copyright', :text => 'Copyright 2017 Gigya. See the terms of service at http://www.gigya.com/terms-of-service/' }

s.platform          = :ios
s.source            = { :path => '/Users/admin/Documents/Projects/iOS/SDK/gigya-ios-sdk' }#{ :http => 'https://s3.amazonaws.com/wikifiles.gigya.com/SDKs/iPhone/3.6.0/GigyaSDK.framework_3.6.0.zip' }

s.ios.deployment_target = '8.0'
s.source_files = 'GigyaSDK/*.{h,m}', 'GigyaSDK/**/*.{h,m}'
#s.public_header_files = 'GigyaSDK/*.h'
s.exclude_files = 'GigyaSDK/Vendor/Google', 'GigyaSDK/Vendor/Facebook', 'GigyaSDK/Vendor/Line',
s.ios.vendored_frameworks = 'GigyaSDK.framework'

end

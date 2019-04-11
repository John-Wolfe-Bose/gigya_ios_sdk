Pod::Spec.new do |s|
s.name              = 'gigya-sdk'
s.version           = '3.7.0'
s.summary           = 'The iOS client library provides an Objective-C interface for the Gigya API'
s.homepage          = 'http://developers.gigya.com/display/GD/iOS'

s.author            = { 'Name' => 'sdks-team@gigya-inc.com' }

s.license           = { :type => 'Copyright', :text => 'Copyright 2017 Gigya. See the terms of service at http://www.gigya.com/terms-of-service/' }

s.platform          = :ios
s.source            = { :path => '../External/gigya_ios_sdk_3.7.0' }

s.ios.deployment_target = '8.0'
s.source_files = 'GigyaSDK/*.{h,m}', 'GigyaSDK/**/*.{h,m,c}'
#s.public_header_files = 'GigyaSDK/*.h'
s.exclude_files = 'GigyaSDK/Vendor/Google', 'GigyaSDK/Vendor/Facebook', 'GigyaSDK/Vendor/LineSDK'
#s.ios.vendored_frameworks = 'GigyaSDK.framework'

s.dependency 'Bolts'
s.dependency 'FBSDKCoreKit'
s.dependency 'FBSDKLoginKit'
s.dependency 'FBSDKShareKit'
#s.dependency 'GoogleSignIn'
#s.dependency 'LineSDK'

#spec.dependency 'Bolts',          '= 1.9.0'
#spec.dependency 'FBSDKCoreKit',   '= 4.42.0'
#spec.dependency 'FBSDKLoginKit',  '= 4.42.0'
#spec.dependency 'FBSDKShareKit' , '= 4.42.0'
#spec.dependency 'GoogleSignIn',   '= 4.4.0'
#spec.dependency 'LineSDK',        '= 5.0.0'

end


end

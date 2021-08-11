Pod::Spec.new do |s|
  s.name             = 'Stipop'
  s.version          = '0.1.0-beta.1'
  s.summary          = 'Stipop iOS UI SDK'
  s.description      = <<-DESC
Welcome to Stipop iOS Sticker SDK. With just a simple integration process you can add optimized UI kit and over 270,000 unique stickers to your chat interface.
                       DESC
  s.homepage         = 'https://developers.stipop.io'
  s.license          = { :type => 'Copyright', :text => 'Copyright © Stipop, Inc. 2021 - All Rights Reserved.' }
  s.author           = { 'Stipop, Inc.' => 'contact@stipop.io' }
  s.social_media_url = 'https://twitter.com/stipopdev'

  s.source           = { :git => 'https://github.com/stipop-development/stipop-ios-sdk.git', :tag => s.version.to_s }
  s.vendored_frameworks = 'Sources/Stipop.xcframework'

  s.ios.deployment_target = '10.0'

end

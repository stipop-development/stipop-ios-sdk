# Stipop iOS UI SDK
![Release](https://img.shields.io/github/v/release/stipop-development/stipop-ios-sdk?sort=semver&style=flat&label=release)
![Beta](https://img.shields.io/github/v/release/stipop-development/stipop-ios-sdk?include_prereleases&sort=semver&style=flat&label=beta)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-green.svg?style=flat)](https://swift.org/package-manager/)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-green.svg?style=flat)](https://cocoapods.org/pods/Stipop)

Stipop SDK powers over 270,000 stickers(+animated) that can be integrated to chat, camera, video call, and profile interfaces. Get access to world's no.1 sticker platform and boost user engagement.

Stipop iOS UI SDK offers you a super easy way to implement sticker service right into your app.

## Requirements
- iOS 10.0+
- XCode 11.0+

## How to install
We support Swift Package manager and Cocoapods for dependency manager.
We recommend using Swift Package Manager rather than others.

### Swift Package Manager
#### By XCode
Go to File > Swift Packages > Add Package Dependency... and enter `https://github.com/stipop-development/stipop-ios-sdk`. Then, select a version you wanna use.

#### By Package.swift
If you have a Swift Package, simply add dependency into Package.swift
```swift
dependencies: [
  .package(url: "https://github.com/stipop-development/stipop-ios-sdk.git", .upToNextMajor(from: "0.0.1-beta.1"))
]
```

### Cocoapods
Copy & Paste below into `Podfile`
```ruby
pod 'Stipop' , '~> 0.0.1-beta.1'
```

## Getting Started
### Generate API Key
API Key is required to use our API and SDK. If you're first time using Stipop, generate a new API Key at our [Dashboard](https://dashboard.stipop.io/create-application).

### Integrating Stipop
See [docs](https://docs.stipop.io/en/sdk/ios/get-started/quick-start) to see how our SDK works in detail.

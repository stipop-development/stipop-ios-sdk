[English](./README.md) | [한국어](./README.kr.md)
![Cover image](https://user-images.githubusercontent.com/30883319/139041228-f88b6e2f-4523-4d56-913e-927956e88dc6.png)

# Stipop UI SDK for iOS

![Release](https://img.shields.io/github/v/release/stipop-development/stipop-ios-sdk?sort=semver&style=flat&label=release)
![Beta](https://img.shields.io/github/v/release/stipop-development/stipop-ios-sdk?include_prereleases&sort=semver&style=flat&label=beta)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-green.svg?style=flat)](https://swift.org/package-manager/)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-green.svg?style=flat)](https://cocoapods.org/pods/Stipop)

스티팝은 모바일 채팅, 댓글, 라이브 방송, 화상채팅 등에 손쉽게 적용할 수 있는 150,000개 이상의 png, gif 이모티콘을 제공합니다. 전 세계 수백만명이 사랑하는 이모티콘을 이용하여 여러분의 앱을 다채롭게 만들어 보세요.

## Requirements

- Swift 5.4+
- XCode 12.5+
- iOS 10.0+

## Getting started

- 더욱 자세한 정보는 [스티팝 SDK 문서](https://docs.stipop.io/en/sdk/ios/get-started/quick-start)를 참고해주세요

- [대시보드](https://dashboard.stipop.io/create-application)에 들어가서 Stipop.plist 파일을 다운로드 해주세요.

## 데모 앱(for XCode 13.0+)

1. 데모 앱 프로젝트를 다운로드(혹은 clone)받아주세요
   (SPM이나 Cocoapods을 별도로 설정하지 않으셔도 됩니다.)

```bash
git clone https://github.com/stipop-development/stipop-ios-sdk
```

2. 프로젝트에 Stipop.plist 파일을 추가해주세요

   ![screenshot](https://user-images.githubusercontent.com/30883319/138623975-d5666bad-e0b4-405b-beaf-ed233e376135.png)

3. 데모 앱을 실행하세요

<p align="center"><img src="https://user-images.githubusercontent.com/30883319/139041399-d4aee7d3-387f-4f9e-a045-f239a0cc2918.png"></p>

## 기존 프로젝트에 설치하기

### Swift Package Manager

#### By XCode

File > Swift Packages > Add Package Dependency... 에 들어가서
`https://github.com/stipop-development/stipop-ios-sdk`을 입력하고, 사용하고 싶은 버전을 선택하여 설치하세요.

#### By Package.swift

Swift Package가 있다면, Package.swift의 dependency에 추가하세요.

```swift
dependencies: [
    .package(url: "https://github.com/stipop-development/stipop-ios-sdk.git", .upToNextMajor(from: "0.9.2"))
]
```

### Cocoapods

아래 코드를 `Podfile`에 붙여넣고 `pod install`로 설치하세요

```ruby
pod 'StipopUIKit'
```

## Contact us

- 더 많은 정보는 [Stipop Docs](https://docs.stipop.io/en/sdk/ios/get-started/quick-start)를 확인해주세요.
- 궁금한 점이나 문제점을 발견하셨다면, tech-support@stipop.io 로 이메일을 보내주세요.

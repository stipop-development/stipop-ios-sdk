[English](./README.md) | [한국어](./README.kr.md)
![Cover image](https://user-images.githubusercontent.com/30883319/139041228-f88b6e2f-4523-4d56-913e-927956e88dc6.png)

# Stipop UI SDK for iOS

![Release](https://img.shields.io/github/v/release/stipop-development/stipop-ios-sdk?sort=semver&style=flat&label=release)
![Beta](https://img.shields.io/github/v/release/stipop-development/stipop-ios-sdk?include_prereleases&sort=semver&style=flat&label=beta)
[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-green.svg?style=flat)](https://swift.org/package-manager/)
[![CocoaPods compatible](https://img.shields.io/badge/CocoaPods-compatible-green.svg?style=flat)](https://cocoapods.org/pods/Stipop)

Stipop SDK provides over 150,000 .png and .gif stickers that can be easily integrated into mobile app chats, comment sections, live streams, video calls, etc. Bring fun to your mobile app with stickers loved by millions of users worldwide.

## Requirements

- Swift 5.4+
- XCode 12.5+
- iOS 10.0+

## Getting started

- Check [Stipop Docs](https://docs.stipop.io/en/sdk/ios/get-started/quick-start) for the comprehensive guide.

- Sign up to [Stipop Dashboard](https://dashboard.stipop.io/create-application) to download Stipop.plist file.

## Try demo(for XCode 13.0+)

1. Download(or Clone) Demo App
   (SPM or Cocoapods Adjustment is not necessary)

```bash
git clone https://github.com/stipop-development/stipop-ios-sdk
```

2. Add Stipop.plist file into the project

   ![screenshot](https://user-images.githubusercontent.com/30883319/138623975-d5666bad-e0b4-405b-beaf-ed233e376135.png)

3. Run demo app

<p align="center"><img src="https://user-images.githubusercontent.com/30883319/139041399-d4aee7d3-387f-4f9e-a045-f239a0cc2918.png"></p>

## Including in your project

### Swift Package Manager

#### By XCode

Go to File > Swift Packages > Add Package Dependency...
Enter `https://github.com/stipop-development/stipop-ios-sdk`. Then select a version you want to use.

#### By Package.swift

If you have a Swift Package, add dependency into Package.swift

```swift
dependencies: [
    .package(url: "https://github.com/stipop-development/stipop-ios-sdk.git", .upToNextMajor(from: "0.9.5"))
]
```

### Cocoapods

Copy & Paste below into `Podfile`. Then, run `pod install`.

```ruby
pod 'StipopUIKit', '0.9.5'
```


How do I use Stipop SDK?
-------------------

1. Add Stipop.plist file into the project.
2. Import Stipop and Initialize Stipop SDK before use at AppDelegate.
```swift
import UIKit
import Stipop

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
//    let semaphore = DispatchSemaphore(value: 1)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // If you want to use SAuth, execute setSAuthDelegate method.
        // *setSAuthDelegate() should be typed before initialize()
        // Stipop.setSAuthDelegate(sAuthDelegate: self)
        Stipop.initialize()
        return true
    }
    
    ...
}
/* If you use SAuth, implement SAuthDelegate and refresh accessToken when authorization error occured. */
/*
extension AppDelegate: SAuthDelegate {
    
    func httpError(apiEnum: SPAPIEnum, error: SPError) {
        print("⚡️Stipop: HTTP Error => \(apiEnum)")
        DispatchQueue.global().async {
            self.semaphore.wait()
            DemoSAuthManager.getAccessTokenIfOverExpiryTime(userId: Stipop.getUser().userID, completion: { accessToken in
                self.semaphore.signal()
                guard let accessToken = accessToken else { return }
                Stipop.setAccessToken(accessToken: accessToken)
                SAuthManager.reRequest(api: apiEnum)
            })
        }
    }
}
 */
```
3. Go to the View Controller where you want to place the button. Then, Initialize SPUIButton and connect delegate.

```swift
import UIKit
import Stipop

class ViewController: UIViewController {
  
    let stipopButton = SPUIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(stipopButton)
        stipopButton.translatesAutoresizingMaskIntoConstraints = false
        stipopButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stipopButton.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        stipopButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        stipopButton.widthAnchor.constraint(equalToConstant: 25).isActive = true

        let user = SPUser(userID: "some_user_id")
        stipopButton.setUser(user, viewType: .picker)
        stipopButton.delegate = self
    }
}

extension ViewController: SPUIDelegate {
 
    func onStickerSingleTapped(_ view: SPUIView, sticker: SPSticker) {
        // This function will be executed when user chooses a sticker.
    }
  
    /* If you want to use double tap feature, change the plist file and implement this function. */
    func onStickerDoubleTapped(_ view: SPUIView, sticker: SPSticker) {
        // This function will be executed when user chooses a sticker.
    }
  
}
```

## Contact us

- For more information, visit [Stipop Docs](https://docs.stipop.io/en/sdk/ios/get-started/quick-start).
- Email us at tech-support@stipop.io if you need any help.

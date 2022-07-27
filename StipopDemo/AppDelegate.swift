//
//  AppDelegate.swift
//  StipopDemo-UIKit
//
//  Created by Jay Ahn on 2021/07/26.
//

import UIKit
import Stipop

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
//    let semaphore = DispatchSemaphore(value: 1)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // *setSAuthDelegate() should be typed before initialize()
        // Stipop.setSAuthDelegate(sAuthDelegate: self)
        Stipop.initialize()
        navigationBarSetup()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    private func navigationBarSetup(){
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: ColorEnum.StipopMain)
            appearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
    }
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

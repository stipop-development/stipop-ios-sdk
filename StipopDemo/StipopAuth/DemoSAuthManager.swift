//
//  DemoSAuthManager.swift
//  StipopDemo-UIKit
//
//  Created by kyum on 2022/07/25.
//

import UIKit
import Stipop

class DemoSAuthManager {
    
    static var key: String = "YOUR_API_KEY"
    
    static var appId: String = "YOUR_APP_ID"
    static var clientId: String = "YOUR_APP_CLIENT_ID"
    static var clientSecret: String = "YOUR_APP_CLIENT_SECRET"
    static var refreshToken: String = "YOUR_APP_REFRESH_TOKEN"
    static var expiryTime: Int = 86400
    
    private static var isSAuthWorking = false
    
    private static var sAuthAccessToken = ""
    static var sAuthAccessTokenUserId = "-1"
    private static var shouldRefreshAccessTokenTimeMillis: Double = 0
    
    static func getAccessTokenIfOverExpiryTime(userId: String, completion: ((String?) -> Void)?){
        
        setIsSAuthWorking(true)
        
        let currentTimeMillis = NSDate().currentTimeMillis()
        
        if(sAuthAccessTokenUserId != userId){
            getAccessToken(userId: userId){ accessToken in
                setIsSAuthWorking(false)
                completion?(accessToken)
            }
        } else if(currentTimeMillis >= shouldRefreshAccessTokenTimeMillis){
            getAccessToken(userId: userId){ accessToken in
                setIsSAuthWorking(false)
                completion?(accessToken)
            }
        } else {
            setIsSAuthWorking(false)
            completion?(sAuthAccessToken)
        }
    }
    
    private static func getAccessToken(userId: String, completion: ((String?) -> Void)?){
        let _ = DemoSAuthAPI.getAccessToken(userId: userId, completion: { accessToken in
            Stipop.setAccessToken(accessToken: accessToken)
            setSAuthInformation(accessToken: accessToken, userId: userId)
            completion?(accessToken)
        }, failure: { error in
            completion?(nil)
        })
    }
    
    private static func setIsSAuthWorking(_ isSAuthWorking: Bool){
        self.isSAuthWorking = isSAuthWorking
    }
    
    static func getIsSAuthWorking() -> Bool {
        return isSAuthWorking
    }
    
    private static func setSAuthInformation(accessToken: String, userId: String){
        let currentTimeMillis = NSDate().currentTimeMillis()
        let expiryTimeMillis = Double((expiryTime > 60 ? expiryTime - 5 : expiryTime - 3) * 1000)
        sAuthAccessToken = accessToken
        sAuthAccessTokenUserId = userId
        shouldRefreshAccessTokenTimeMillis = currentTimeMillis + expiryTimeMillis
    }
}

extension NSDate {
    func currentTimeMillis() -> Double {
        return self.timeIntervalSince1970 * 1000
    }
}

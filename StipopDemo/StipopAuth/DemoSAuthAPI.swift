//
//  DemoSAuthAPI.swift
//  StipopDemo-UIKit
//
//  Created by kyum on 2022/07/25.
//

import Alamofire
import UIKit

enum DemoSAuthError: Error {
    case alamofire(AFError)
    case error(Error)
    case api(DemoSAuthAPI.Response.Header)
    case message(String)
}

extension DemoSAuthError: LocalizedError {
    var code: String? {
        switch self {
        case .api(let error):
            return error.code
        case .alamofire(let error):
            return String(describing: error.responseCode)
        default:
            return nil
        }
    }
    var message: String? {
        switch self {
        case .api(let error):
            return error.message
        case .message(let error):
            return error
        default:
            return nil
        }
    }
}

internal class DemoSAuthAPI {
    
    internal class Path {
        
        static let root: String = "https://messenger.stipop.io/v1"
        static let accessToken: String = root + "/access"
        
    }
    
    internal struct Response: Codable {
        let header: Header?
        struct Header: Codable {
            let code: String?
            let message: String?
            var isSuccess: Bool {
                return code == "0000"
            }
        }
        
        let body: Body?
        struct Body: Codable {
            let accessToken: String?
        }
        
        fileprivate func isSuccess(_ success: (()->Void)? = nil, failure: ((DemoSAuthError?) -> Void)? = nil) {
            if let header = header {
                if header.isSuccess {
                    success?()
                } else {
                    failure?(DemoSAuthError.api(header))
                }
            } else {
                failure?(DemoSAuthError.message("Cannot parse response header"))
            }
        }
        
        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            if let header = try? values.decode(Header.self, forKey: .header) {
                self.header = header
            } else {
                self.header = nil
            }
            if let body = try? values.decode(Body.self, forKey: .body) {
                self.body = body
            } else {
                self.body = nil
            }
        }
    }
    
    internal static func request(_ url: String,
                                 method: HTTPMethod,
                                 userId: String = "",
                                 encoding: ParameterEncoding = JSONEncoding.default,
                                 headers: HTTPHeaders = [:],
                                 completion: ((DemoSAuthAPI.Response)->Void)?,
                                 failure: ((DemoSAuthError?)->Void)? = nil) -> DataRequest {
        
        //Set Parameter
        var parameters_final: Parameters = [:]
        
        parameters_final["userId"] = userId
        
        parameters_final["appId"] = DemoSAuthManager.appId
        parameters_final["clientId"] = DemoSAuthManager.clientId
        parameters_final["clientSecret"] = DemoSAuthManager.clientSecret
        parameters_final["refreshToken"] = DemoSAuthManager.refreshToken
        parameters_final["expiryTime"] = DemoSAuthManager.expiryTime
        
        //Set Header
        var headers_final: HTTPHeaders = headers
        headers_final.add(name: "api_key", value: DemoSAuthManager.key)
        
        //Request
        return AF.request(url,
                          method: method,
                          parameters: parameters_final,
                          encoding: encoding,
                          headers: headers_final)
        .responseJSON { response in
            switch response.result {
            case .success(let obj):
                do {
                    let dataJSON = try JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted)
                    let getInstanceData = try JSONDecoder().decode(DemoSAuthAPI.Response.self, from: dataJSON)
                    getInstanceData.isSuccess({
                        completion?(getInstanceData)
                    }, failure: failure)
                } catch(let error) {
                    failure?(DemoSAuthError.error(error))
                }
            case .failure(let e):
                failure?(DemoSAuthError.alamofire(e))
            }
        }
    }
}

fileprivate struct FailableDecodable<Base : Decodable> : Decodable {
    let base: Base?
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}

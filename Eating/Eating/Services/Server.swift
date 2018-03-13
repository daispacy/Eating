//
//  Server.swift
//  Eating
//
//  Created by Dai Pham on 11/7/17.
//  Copyright © 2018 Eating VIETNAM. All rights reserved.
//

import UIKit
import Alamofire


typealias JSON = Dictionary<String, Any>

enum Result<T, U> where U: Error {
    case success(T)
    case failure(U?)
}

enum EmptyResult<U> where U: Error {
    case success
    case failure(U?)
}


final class Server: NSObject {
    
    
    /// Enum store code errors from api
    ///
    /// - unAuthorized: api token wrong or invalid
    /// - notFound: api not found
    /// - cantParseData: data return wrong format
    /// - emailUsed: email register has exist
    /// - invalid: something happen wrong with server
    /// - missingField: missing params
    /// - unkownUser: user not exist
    /// - invalidService: Service maintaince
    enum GetDataFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
        case cantParseData = 501
        case paramUsed = 503 // email has used
        case invalid = 0
        case missingField = 1002 // missing params
        case unkownData = 1001  // user not exist
        case invalidService = 1003
        
    }
    
    typealias GetListResult = Result<[JSON], GetDataFailureReason>
    typealias GetListCompletion = (_ result: GetListResult) -> Void
    
    typealias GetSingleResult = Result<JSON, GetDataFailureReason>
    typealias GetSingleCompletion = (_ result: GetSingleResult) -> Void
    
    static let shared = Server()
    
    private override init() {
        super.init()
    }
    
    // MARK: - private
    // refactor
    
    /// handle response data from api
    ///
    /// - Parameters:
    ///   - response: response received from alamofire
    ///   - completion: return Any?, GetDataFailureReason?, orderParams will stored in this third param
    fileprivate func handleResponseData(response:DataResponse<String>,_ completion:((Any?,GetDataFailureReason?,Any?)->Void)? = nil) {
        switch response.result {
        case .success:
            
            guard let jsonArray = response.result.value?.convertToJSON() else {
                if let reason = GetDataFailureReason(rawValue: 404) {
                    completion?(nil,reason,nil)
                }
                return
            }
            
            var error:Int = 0
            if let err = jsonArray["status"] as? Int {
                error = err
            } else if let err = jsonArray["status"] as? String {
                error = Int(err)!
            }
            
            var otherParams:JSON = [:]
            for key in jsonArray.keys {
                if key != "data" && key != "status" {
                    otherParams[key] = jsonArray[key]
                }
            }
            
            if error == 200 {
                completion?(jsonArray["data"],nil,otherParams)
            } else if error == 401 {
                self.apiTokenExpired()
                return
            } else {
                if let reason = GetDataFailureReason(rawValue: error) {
                    completion?(nil,reason,otherParams)
                }
            }
            
            
        case .failure(_):
            if let reason = GetDataFailureReason(rawValue: 404) {
                completion?(nil,reason,nil)
            }
        }
    }
    
    fileprivate func getMessage(error:GetDataFailureReason) -> String{
        var msg = "service_unavailable".localized().capitalizingFirstLetter()
        switch error  {
        case .unAuthorized:
            msg = "api_token_expired".localized().capitalizingFirstLetter()
        case .notFound:
            msg = "service_unavailable".localized().capitalizingFirstLetter()
        case .cantParseData:
            msg = "wrong_params_cant_send_to_server".localized().capitalizingFirstLetter()
        case .paramUsed:
            msg = "information_that_you_already_exists".localized().capitalizingFirstLetter()
        case .invalid:
            msg = "information_that_you_invalid".localized().capitalizingFirstLetter()
        case .missingField:
            msg = "information_that_you_invalid".localized().capitalizingFirstLetter()
        case .unkownData:
            msg = "information_that_you_invalid".localized().capitalizingFirstLetter()
        case .invalidService:
            msg = "service_unavailable".localized().capitalizingFirstLetter()
        }
        return msg
    }

    // MARK: - APITOKEN EXPIRED
    func apiTokenExpired() {
//        AppConfig.navigation.logOut()
        
        let alert = UIAlertController(title: "Error!",
                                      message: "api_token_expired".localized(),
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        Support.topVC!.present(alert, animated: true, completion: nil)
    }
}
// MARK: - AUTHENTIC
extension Server {
    
    
    func login(email:String? = nil,
               password:String? = nil,
               _ onComplete: @escaping GetSingleCompletion) {
        
        guard let e = email, let p = password else {
            if let reason = GetDataFailureReason(rawValue: 404) {
                onComplete(.failure(reason))
            }
            return
        }
        
        let parameters = ["email":e,"password":p]
        
        Alamofire.request(api_login, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: ["Accept":"application/json"])
            .responseString { response in
                switch response.result {
                case .success:
                    
                    guard let jsonArray = response.result.value?.convertToJSON() else {
                        if let reason = GetDataFailureReason(rawValue: 404) {
                            onComplete(.failure(reason))
                        }
                        return
                    }
                    if let error = jsonArray["status"] as? Int{
                        if error == 200 {
                            let objectJson = jsonArray
                            if let js = objectJson["data"] as? String {
                                if let data = js.data(using: String.Encoding.utf8) {
                                    do {
                                        if let pro:JSON = try JSONSerialization.jsonObject(with: data, options: []) as? JSON {
                                            DispatchQueue.main.async {
                                                onComplete(.success(pro))
                                            }
                                            return
                                        }
                                    } catch {
                                        DispatchQueue.main.async {
                                            if let reason = GetDataFailureReason(rawValue: 404) {
                                                onComplete(.failure(reason))
                                            }
                                        }
                                    }
                                }
                            }
                            if let js = objectJson["data"] as? JSON {
                                DispatchQueue.main.async {
                                    onComplete(.success(js))
                                }
                                return
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        if let reason = GetDataFailureReason(rawValue: 404) {
                            onComplete(.failure(reason))
                        }
                    }
                case .failure(_):
                    if let reason = GetDataFailureReason(rawValue: 404) {
                        onComplete(.failure(reason))
                    }
                }
        }
    }
}

// MARK: - GET CONFIG
extension Server {
    
    
}

// MARK: - CATEGORIES
extension Server {
    // get all categories
    
    
    // post categories
   
}

// MARK: - STREAMS
extension Server {
    // get all streams
    
    
    // like | unlike stream
    
    
    // like | unlike stream
    
    // share stream link to facebook
    
}

// MARK: - upload Thumb Stream
extension Server {
    
}

// MARK: - update profile
extension Server {
   
}

// MARK: - API Products
extension Server {
    
}
// MARK: - API Orders
extension Server {
    
}


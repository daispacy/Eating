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
    
    enum GetDataFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
        case cantParseData = 501
        case invalid = 0
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
    fileprivate func handleSingleData(response:DataResponse<String>,_ completion:GetSingleCompletion? = nil) {
        switch response.result {
        case .success:
            
            guard let jsonArray = response.result.value?.convertToJSON() else {
                if let reason = GetDataFailureReason(rawValue: 404) {
                    completion?(.failure(reason))
                }
                return
            }
            if let error = jsonArray["status"] as? Int{
                if error == 200 {
                    completion?(.success(jsonArray))
                } else if error == 401 {
                    self.apiTokenExpired()
                    return
                } else {
                    if let reason = GetDataFailureReason(rawValue: 404) {
                        completion?(.failure(reason))
                    }
                }
            } else {
                if let reason = GetDataFailureReason(rawValue: 404) {
                    completion?(.failure(reason))
                }
            }
            
        case .failure(_):
            if let reason = GetDataFailureReason(rawValue: 404) {
                completion?(.failure(reason))
            }
        }
    }
    
    fileprivate func handleListData(response:DataResponse<String>,_ completion:GetListCompletion? = nil) {
        switch response.result {
        case .success:
            
            guard let jsonArray = response.result.value?.convertToJSON() else {
                if let reason = GetDataFailureReason(rawValue: 404) {
                    completion?(.failure(reason))
                }
                return
            }
            if let error = jsonArray["status"] as? Int{
                if error == 200 {
                    if let data = jsonArray["data"] as? [JSON] {
                        completion?(.success(data))
                    } else if let data = jsonArray["data"] as? JSON {
                        completion?(.success([data]))
                    }
                } else if error == 401 {
                    self.apiTokenExpired()
                    return
                } else {
                    if let reason = GetDataFailureReason(rawValue: 404) {
                        completion?(.failure(reason))
                    }
                }
            } else {
                if let reason = GetDataFailureReason(rawValue: 404) {
                    completion?(.failure(reason))
                }
            }
            
        case .failure(_):
            if let reason = GetDataFailureReason(rawValue: 404) {
                completion?(.failure(reason))
            }
        }
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
    
    func register(email:String,
                  password:String,
                  password_confirmation:String,
                  _ name:String? = nil,
                  _ completion:((JSON?,Any?)->Void)? = nil) {
        
        var parameters: Parameters = [:]
        
        parameters["email"] = email
        parameters["password"] = password
        parameters["password_confirmation"] = password_confirmation
        
        if let name = name {
            parameters["name"] = name
        }
        
        var request = URLRequest(url: try! api_register.asURL())
        
        //some header examples
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            print("httpBody request parse fail \(parameters)")
            if let reason = GetDataFailureReason(rawValue: 404) {
                completion?(nil, reason)
            }
        }
        
        Alamofire.request(request).responseString { response in
            self.handleSingleData(response: response, { result in
                switch response.result {
                case .success:
                    
                    guard let jsonArray = response.result.value?.convertToJSON() else {
                        if let reason = GetDataFailureReason(rawValue: 404) {
                            completion?(nil, reason)
                        }
                        return
                    }
                    if let error = jsonArray["status"] as? Int{
                        if error == 200 {
                            if let json = jsonArray["data"] as? JSON {
                                completion?(json, nil)
                                return
                            }
                        }
                        if let reason = GetDataFailureReason(rawValue: 404) {
                            completion?(nil, reason)
                        }
                    } else {
                        if let reason = GetDataFailureReason(rawValue: 404) {
                            completion?(nil, reason)
                        }
                    }
                    
                case .failure(_):
                    if let reason = GetDataFailureReason(rawValue: 404) {
                        completion?(nil, reason)
                    }
                }
            })
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
    
    
    // create stream
    typealias CreateStreamResult = Result<Stream, GetDataFailureReason>
    typealias CreateStreamCompletion = (_ result: CreateStreamResult) -> Void
    
    
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

// MARK: - API USER SHIPPING
extension Server {
    
}

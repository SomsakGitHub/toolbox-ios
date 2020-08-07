//
//  ServiceWrapper.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 19/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServiceWrapper: ServiceWrapperProtocol {

    func serviceResponse(request: URLRequest,completion : @escaping (Data?,statusWebService) -> Void) {
        AF.request(request).responseJSON { (response) in
            
            print("request: \(request)")
            print("status code: \(String(describing: response.response?.statusCode))")
            print("data: \(String(describing: response.result))")
            
            switch response.response?.statusCode {
                case 200:
                    completion(response.data!, .success)
                    break
                case 204:
                    completion(nil, .noContent)
                    break
                case 400:
                    completion(response.data!, .badRequest)
                    break
                case 401:
                    completion(response.data!, .unAuthorized)
                    break
                case 500:
                    completion(response.data!, .internalServerError)
                    break
                case nil:
                    completion(response.data!, .null)
                    break
                default :
                    completion(response.data!, .internalServerError)
            }
        }
    }
    
    func refreshToken(completion : @escaping (statusWebService) -> Void) {
        
        let token: String = (CoreDataManager().getUserData().first?.refreshToken)!
        
        let service = ServiceWrapper()
        let parameters: Parameters = ["refreshToken": token]
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.refreshToken)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]
                    
                    CoreDataManager().saveUserData(
                        accessToken: data["accessToken"].stringValue,
                        refreshToken: data["refreshToken"].stringValue
                    )
                    
                    UserDefaults.standard.set(data["userID"].intValue, forKey: "userID")
                    
                    break
                case .internalServerError:
                    
                    break
                case nil:
                    
                    break
                default :
                    break
            }
            
            completion(status)
        }
    }
}

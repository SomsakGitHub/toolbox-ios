//
//  ForgotPasswordModel.swift
//  BridgeStone
//
//  Created by somsak on 23/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ForgotPasswordModel{
    
    private var forgotPasswordModelDelegate: ForgotPasswordModelDelegate?
    
    init(view: ForgotPasswordModelDelegate) {
        self.forgotPasswordModelDelegate = view
    }
    
    func fetchForgotPassword(email: String){
        let service = ServiceWrapper()
        let parameters: Parameters = ["username": email]
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.forgotPassword)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
            case .success:
//                let json: JSON = JSON(response)
//                let data = json["result"]
//                
//                UserManager.shared.saveUserInformation(
//                    accessToken: data["accessToken"].stringValue,
//                    refreshToken: data["refreshToken"].stringValue
//                )
                
                break
            case .unAuthorized:
//                service.refreshToken(){ (statusRefreshToken) in
//                    if statusRefreshToken == .success {
//                        self.forgotPasswordModelDelegate?.didFinishRefreshToken()
//                    }
//                }
                break
            case .internalServerError:
                
                break
            case nil:
                
                break
            default :
                break
            }
            
            self.forgotPasswordModelDelegate?.didFinishFetchingForgotPassword(status)
        }
    }
}

//
//  LoginViewModel.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 19/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginViewModel{
    
    private var loginViewModelDelegate: LoginViewModelDelegate?
    
    init(view: LoginViewModelDelegate) {
        self.loginViewModelDelegate = view
    }
    
    func fetchLogin(email: String, password: String){
        
        let service = ServiceWrapper()
        let parameters: Parameters = ["username": email,"password": password]
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.login)!)
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
                    UserDefaults.standard.set(email, forKey: "username")
                    
                    break
                case .internalServerError:
                    
                    break
                case nil:
                    
                    break
                default :
                    break
            }
            
            self.loginViewModelDelegate?.didFinishFetchingLogin(status)
        }
    }
}

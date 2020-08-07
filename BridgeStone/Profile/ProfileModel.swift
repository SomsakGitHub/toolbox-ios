//
//  ProfileModel.swift
//  BridgeStone
//
//  Created by somsak on 1/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProfileModel{
    
    private var profileModelDelegate: ProfileModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let userID = UserDefaults.standard.integer(forKey: "userID")
    let username: String = UserDefaults.standard.string(forKey: "username")!
    
    init(view: ProfileModelDelegate) {
        self.profileModelDelegate = view
    }
    
    func fetchProfile(){
        
        let service = ServiceWrapper()
        let webServiceURLFleets = "https://api.toolbox.projects.ifra.io/v1/users/\(userID)"
        var urlRequest = URLRequest(url:  URL(string: webServiceURLFleets)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]
                    
                    var profile:[Profile]? = []
                    
                    profile?.append(Profile(
                        id: data["id"].intValue,
                        username: data["username"].stringValue,
                        firstName: data["firstName"].stringValue,
                        lastName: data["lastName"].stringValue,
                        language: data["language"].stringValue,
                        mobileNumber: data["mobileNumber"].stringValue)
                    )
                    
                    self.profileModelDelegate?.didFinishFetchingProfile(status, profile: profile!)
                    break
                case .unAuthorized:
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.profileModelDelegate?.didFinishRefreshToken(type: .fetchProfile)
                    }
                }
                break
                case .internalServerError:
                    
                    break
                case nil:
                    
                    break
                default :
                    break
            }
        }
    }
    
    func editProfile(name: String, lastName: String, phone: String, language: String){
        
        let service = ServiceWrapper()
        
        let parameters: Parameters = ["username": username, "FirstName": name, "LastName": lastName, "mobileNumber": phone, "language": language]
        let webServiceURLEditProfile = "https://api.toolbox.projects.ifra.io/v1/users/\(userID)"
        var urlRequest = URLRequest(url:  URL(string: webServiceURLEditProfile)!)
        urlRequest.httpMethod = HTTPMethod.put.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
            case .success:
                
                switch language {
                case "EN":
                    LanguageManager().selectEnglishLanguage()
                    break;
                case "TH":
                    LanguageManager().selectThaiLanguage()
                    break;
                default:
                    break;
                }
                
                self.profileModelDelegate?.didFinishEditProfile(status)
                break
            case .unAuthorized:
            service.refreshToken(){ (statusRefreshToken) in
                if statusRefreshToken == .success {
                    self.profileModelDelegate?.didFinishRefreshToken(type: .editProfile)
                }
            }
            break
            case .internalServerError:
                
                break
            case nil:
                
                break
            default :
                break
            }
        }
    }
}

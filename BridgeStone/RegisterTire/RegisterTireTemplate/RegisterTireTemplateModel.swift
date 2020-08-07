//
//  RegisterTireTemplateModel.swift
//  BridgeStone
//
//  Created by somsak on 21/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RegisterTireTemplateModel{

    private var registerTireTemplateModelDelegate: RegisterTireTemplateModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!
    let isNewTire: Bool = UserDefaults.standard.bool(forKey: "isNewTire")

    init(view: RegisterTireTemplateModelDelegate) {
        self.registerTireTemplateModelDelegate = view
    }
    
    func registerTireTemplate(data: [Int]){
        let service = ServiceWrapper()
        let parameters: Parameters = ["tireSizeID": data[0], "tireBrandID": data[1], "tirePatternID": data[2], "fleetID": Int(fleetID)]
        var webServiceURLFTireTemplates = ""
        
        if isNewTire {
            webServiceURLFTireTemplates = "https://api.toolbox.projects.ifra.io/v1/tires/templates"
        }else{
            webServiceURLFTireTemplates = "https://api.toolbox.projects.ifra.io/v1/tires/past-templates"
        }
        
        var urlRequest = URLRequest(url:  URL(string: webServiceURLFTireTemplates)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        service.serviceResponse(request: urlRequest) { (response, status) in

            switch status {
            case .success:
                
                if webServiceURLFTireTemplates == "https://api.toolbox.projects.ifra.io/v1/tires/templates" {
                    UserDefaults.standard.set(true, forKey: "isSaveTemplates")
                }else if webServiceURLFTireTemplates == "https://api.toolbox.projects.ifra.io/v1/tires/past-templates"{
                    
                    UserDefaults.standard.set(true, forKey: "isSavePastTemplates")
                }
                
                break
            case .unAuthorized:
                
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.registerTireTemplateModelDelegate?.didFinishRefreshToken()
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
            self.registerTireTemplateModelDelegate?.didFinishRegisterTireTemplate(status)
        }
    }
}



//
//  DesignTireAfterModel.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DesignTireAfterModel{
    
    private var designTireAfterModelDelegate: DesignTireAfterModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!
    
    init(view: DesignTireAfterModelDelegate) {
        self.designTireAfterModelDelegate = view
    }
    
    func fetchDesignTireAfter(q: String){
        let service = ServiceWrapper()
        let webServiceURLFTireTemplates = "https://api.toolbox.projects.ifra.io/v1/tires/templates?fleetID=\(fleetID)&q=\(q)"
        
        var urlRequest = URLRequest(url:  URL(string: webServiceURLFTireTemplates)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]
                    
                    var tireTemplates: [TireTemplates]? = []
                    
                    for index in data.arrayValue{
                        tireTemplates?.append(TireTemplates(
                            id: index["id"].intValue,
                            nameTireTemplate: index["nameTireTemplate"].stringValue
                        ))
                    }
                    
                    self.designTireAfterModelDelegate?.didFinishFetchingDesignTireAfter(status, tireTemplates: tireTemplates!)
                    break
                case .unAuthorized:
                
                    service.refreshToken(){ (statusRefreshToken) in
                        if statusRefreshToken == .success {
                            self.designTireAfterModelDelegate?.didFinishRefreshToken()
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

//
//  StandardMaintenanceModel.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class StandardMaintenanceModel{
    
    private var standardMaintenanceModelDelegate: StandardMaintenanceModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    
    init(view: StandardMaintenanceModelDelegate) {
        self.standardMaintenanceModelDelegate = view
    }
    
    func fetchPolicies(param: [String]){
        let service = ServiceWrapper()
        
        let webServiceURLPolicies = "https://api.toolbox.projects.ifra.io/v1/policies?axlesQTY=\(param[0])&fleetID=\(param[1])&q=\(param[2])"
        
        var urlRequest = URLRequest(url:  URL(string: webServiceURLPolicies)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]
                    
                    var policies: [Policies]? = []
                    
                    for index in data.arrayValue{
                        policies?.append(Policies(
                            id: index["id"].intValue,
                            fleetID: index["fleetID"].intValue,
                            axlesQTY: index["axlesQTY"].intValue,
                            name: index["name"].stringValue
                        ))
                    }
                    
                    self.standardMaintenanceModelDelegate?.didFinishFetchingStandardMaintenance(status, policies: policies!)
                    break
                case .unAuthorized:
                
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.standardMaintenanceModelDelegate?.didFinishRefreshToken()
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


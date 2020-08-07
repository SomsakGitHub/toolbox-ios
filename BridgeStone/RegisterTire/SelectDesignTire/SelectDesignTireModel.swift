//
//  SelectDesignTireModel.swift
//  BridgeStone
//
//  Created by somsak on 14/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SelectDesignTireModel{
    
    private var selectDesignTireModelDelegate: SelectDesignTireModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!
    let isNewTire: Bool = UserDefaults.standard.bool(forKey: "isNewTire")
    
    init(view: SelectDesignTireModelDelegate) {
        self.selectDesignTireModelDelegate = view
    }
    
    func fetchDesignTire(q: String){
        let service = ServiceWrapper()
        var webServiceURLFTireTemplates = ""
        
        if isNewTire {
            webServiceURLFTireTemplates = "https://api.toolbox.projects.ifra.io/v1/tires/templates?fleetID=\(fleetID)&q=\(q)"
        }else{
            webServiceURLFTireTemplates = "https://api.toolbox.projects.ifra.io/v1/tires/past-templates?fleetID=\(fleetID)&q=\(q)"
        }
        
        var urlRequest = URLRequest(url:  URL(string: webServiceURLFTireTemplates.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed)!)!)
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
                    
                    self.selectDesignTireModelDelegate?.didFinishFetchingTireTemplates(status, tireTemplates: tireTemplates!)
                    break
                case .unAuthorized:
                    service.refreshToken(){ (statusRefreshToken) in
                        if statusRefreshToken == .success {
                            self.selectDesignTireModelDelegate?.didFinishRefreshToken()
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

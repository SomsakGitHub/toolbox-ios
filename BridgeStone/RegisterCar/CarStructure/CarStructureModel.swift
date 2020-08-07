//
//  DialogHeadTailTableViewCellModel.swift
//  BridgeStone
//
//  Created by somsak on 17/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CarStructureModel{
    
    private var carStructureModelDelegate: CarStructureModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    
    init(view: CarStructureModelDelegate) {
        self.carStructureModelDelegate = view
    }
    
    func fetchCarStructure(param: [String]){
        let service = ServiceWrapper()
        let webServiceURLCarStructure = "https://api.toolbox.projects.ifra.io/v1/car-structure?axlesQTY=\(param[1])&wheelQTY=\(param[2])&structureType=\(param[0])&q=\(param[3])"
        var urlRequest = URLRequest(url:  URL(string: webServiceURLCarStructure.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed)!)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]
                    
                    var carStructure: [CarStructure]? = []
                    
                    for index in data.arrayValue{
                        carStructure?.append(CarStructure(
                            id: index["id"].intValue,
                            axlesQTY: index["axlesQTY"].intValue,
                            wheelQTY: index["wheelQTY"].intValue,
                            image: index["image"].stringValue,
                            name: index["name"].stringValue,
                            code: index["code"].stringValue,
                            structureType: index["structureType"].stringValue
                        ))
                    }
                    
                    self.carStructureModelDelegate?.didFinishFetchingCarStructure(status, carStructure: carStructure!)
                    break
                case .unAuthorized:
                
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.carStructureModelDelegate?.didFinishRefreshToken()
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



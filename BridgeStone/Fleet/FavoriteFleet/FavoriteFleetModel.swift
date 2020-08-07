//
//  FavoriteFleetModel.swift
//  BridgeStone
//
//  Created by somsak on 29/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FavoriteFleetModel{
    
    private var favoriteFleetModelDelegate: FavoriteFleetModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    
    init(view: FavoriteFleetModelDelegate) {
        self.favoriteFleetModelDelegate = view
    }
    
    func fetchFleet(){
        
        let service = ServiceWrapper()
        //        let webServiceURLFleets = "http://api.toolbox.projects.ifra.io/v1/fleets?offset=0&limit=5"
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.fleets)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
            case .success:
                let json: JSON = JSON(response)
                let data = json["result"]
                
                var fleetList:[Fleet]? = []
                
                for index in data["fleets"].arrayValue{
                    fleetList?.append(Fleet(
                        id: index["id"].stringValue,
                        name: index["name"].stringValue,
                        addr: index["addr"].stringValue,
                        district: index["district"].stringValue,
                        province: index["province"].stringValue,
                        bussines_type_id: index["bussines_type_id"].stringValue,
                        transport_type_id: index["transport_type_id"].stringValue
                    ))
                }
                self.favoriteFleetModelDelegate?.didFinishFetchingAllFleet(status, fleet: fleetList!)
                break
                
            case .unAuthorized:
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.favoriteFleetModelDelegate?.didFinishRefreshToken(type: .fetchFleet)
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
    
    func fetchFavoriteFleet(){
        
        let service = ServiceWrapper()
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.getFleetfavorite)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]
                    
                    var favoriteFleetsList:[FavoriteFleets]? = []
                    
                    for index in data.arrayValue{
                        favoriteFleetsList?.append(FavoriteFleets(
                            id: index["id"].intValue,
                            fleetsID: index["fleetsID"].intValue,
                            userID: index["userID"].intValue
                        ))
                    }
                    self.favoriteFleetModelDelegate?.didFinishFetchingFavoriteFleet(status, favoriteFleet: favoriteFleetsList!)
                    break
                case .unAuthorized:
                    service.refreshToken(){ (statusRefreshToken) in
                        if statusRefreshToken == .success {
                            self.favoriteFleetModelDelegate?.didFinishRefreshToken(type: .fetchFavoriteFleet)
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
    
    func deleteFleetFavorite(id: Int){
        
        let service = ServiceWrapper()
        let webServiceURLFleets = "https://api.toolbox.projects.ifra.io/v1/fleets-favorite/\(id)"
        var urlRequest = URLRequest(url:  URL(string: webServiceURLFleets)!)
        urlRequest.httpMethod = HTTPMethod.delete.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    self.favoriteFleetModelDelegate?.didFinishFetchingDeleteFleetFavorite(status)
                    break
                case .unAuthorized:
                    service.refreshToken(){ (statusRefreshToken) in
                        if statusRefreshToken == .success {
                            self.favoriteFleetModelDelegate?.didFinishRefreshToken(type: .deleteFleetFavorite)
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


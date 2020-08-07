//
//  DialogCarDetailModel.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DialogCarDetailModel{
    
    private var dialogCarDetailModelDelegate: DialogCarDetailModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    
    init(view: DialogCarDetailModelDelegate) {
        self.dialogCarDetailModelDelegate = view
    }
    
    func fetchSizeTire(){
        let service = ServiceWrapper()
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.masterDataTiresSizes)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]
                    
                    var sizeTire: [SizeTire]? = []
                    
                    for index in data.arrayValue{
                        sizeTire?.append(SizeTire(
                            id: index["id"].intValue,
                            name: index["name"].stringValue
                        ))
                    }
                    
                    self.dialogCarDetailModelDelegate?.didFinishFetchingSizeTire(status, sizeTire: sizeTire!)
                    break
                case .unAuthorized:
                
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.dialogCarDetailModelDelegate?.didFinishRefreshToken(type: .fetchSizeTire)
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
    
    func fetchBrandTire(){
        let service = ServiceWrapper()
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.masterDataTiresBrands)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
            case .success:
                let json: JSON = JSON(response)
                let data = json["result"]

                var sizeTire: [SizeTire]? = []

                for index in data.arrayValue{
                    sizeTire?.append(SizeTire(
                        id: index["id"].intValue,
                        name: index["name"].stringValue
                    ))
                }

                self.dialogCarDetailModelDelegate?.didFinishFetchingSizeTire(status, sizeTire: sizeTire!)
                break
            case .unAuthorized:
            
            service.refreshToken(){ (statusRefreshToken) in
                if statusRefreshToken == .success {
                    self.dialogCarDetailModelDelegate?.didFinishRefreshToken(type: .fetchBrandTire)
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
    
    func fetchPatternTire(){
        let service = ServiceWrapper()
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.masterDataTiresPatterns)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
            case .success:
                let json: JSON = JSON(response)
                let data = json["result"]

                var sizeTire: [SizeTire]? = []

                for index in data.arrayValue{
                    sizeTire?.append(SizeTire(
                        id: index["id"].intValue,
                        name: index["name"].stringValue
                    ))
                }

                self.dialogCarDetailModelDelegate?.didFinishFetchingSizeTire(status, sizeTire: sizeTire!)
                break
            case .unAuthorized:
            
            service.refreshToken(){ (statusRefreshToken) in
                if statusRefreshToken == .success {
                    self.dialogCarDetailModelDelegate?.didFinishRefreshToken(type: .fetchPatternTire)
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

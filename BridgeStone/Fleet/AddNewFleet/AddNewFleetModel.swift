//
//  AddNewFleetModel.swift
//  BridgeStone
//
//  Created by somsak on 27/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AddNewFleetModel{
    private var addNewFleetDelegate: AddNewFleetDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    
    init(view: AddNewFleetDelegate) {
        self.addNewFleetDelegate = view
    }
    
    func saveFleet(data: [String]){
        let service = ServiceWrapper()
        let parameters: Parameters = [
            "name": data[0],
            "address": data[1],
            "district": data[2],
            "province": data[3],
            "businessTypeID": 1,
            "transportTypeID": 1]
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.saveFleet)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        service.serviceResponse(request: urlRequest) { (response, status) in

            switch status {
            case .success:
                self.addNewFleetDelegate?.didFinishSaveFleet(status)
                break
            case .unAuthorized:
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.addNewFleetDelegate?.didFinishRefreshToken()
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

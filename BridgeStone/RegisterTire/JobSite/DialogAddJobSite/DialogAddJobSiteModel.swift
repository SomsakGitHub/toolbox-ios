//
//  DialogAddJobSiteModel.swift
//  BridgeStone
//
//  Created by somsak on 20/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DialogAddJobSiteModel{

    private var dialogAddJobSiteModelDelegate: DialogAddJobSiteModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!

    init(view: DialogAddJobSiteModelDelegate) {
        self.dialogAddJobSiteModelDelegate = view
    }
    
    func addJobSite(jobSiteName: String){
        let service = ServiceWrapper()
        let parameters: Parameters = ["fleetID": Int(fleetID), "jobsiteName": jobSiteName]
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.jobsites)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        service.serviceResponse(request: urlRequest) { (response, status) in

            switch status {
            case .success:
                self.dialogAddJobSiteModelDelegate?.didFinishAddJobSite(status)
                break
            case .unAuthorized:
            
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.dialogAddJobSiteModelDelegate?.didFinishRefreshToken()
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



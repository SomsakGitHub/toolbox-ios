//
//  JobSiteModel.swift
//  BridgeStone
//
//  Created by somsak on 16/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JobSiteModel{
    
    private var jobSiteModelDelegate: JobSiteModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!
    
    init(view: JobSiteModelDelegate) {
        self.jobSiteModelDelegate = view
    }
    
    func fetchJobSite(){
        let service = ServiceWrapper()
        let webServiceURLJobsites = "https://api.toolbox.projects.ifra.io/v1/jobsites?fleetID=\(fleetID)"
        var urlRequest = URLRequest(url:  URL(string: webServiceURLJobsites)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]["jobsite"]
                    
                    var jobsites: [Jobsites]? = []
                    
                    for index in data.arrayValue{
                        jobsites?.append(Jobsites(
                            id: index["id"].intValue,
                            totalVehicles: index["totalVehicles"].intValue,
                            fleetID: index["fleetID"].stringValue,
                            jobsiteName: index["jobsiteName"].stringValue,
                            address: index["address"].stringValue,
                            district: index["district"].stringValue,
                            province: index["province"].stringValue,
                            updated: index["updated"].stringValue
                        ))
                    }
                    
                    self.jobSiteModelDelegate?.didFinishFetchingJobSite(status, jobsites: jobsites!)
                    break
            case .unAuthorized:
                
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.jobSiteModelDelegate?.didFinishRefreshToken()
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

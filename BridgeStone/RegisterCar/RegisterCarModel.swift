//
//  RegisterCarModel.swift
//  BridgeStone
//
//  Created by somsak on 17/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RegisterCarModel{

    private var registerCarModelDelegate: RegisterCarModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!

    init(view: RegisterCarModelDelegate) {
        self.registerCarModelDelegate = view
    }
    
    func registerCar(data: [String], isRegister: Bool){
        let service = ServiceWrapper()
        let parameters: Parameters = ["licensePlate": data[0], "driverFirstname": data[1], "driverLastname": data[1], "mobileNumber": data[2], "jobSiteID": Int(data[3]), "carStructuresID": Int(data[4]), "carPoliciesID": Int(data[5])]
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.cars)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        service.serviceResponse(request: urlRequest) { (response, status) in

            switch status {
            case .success:
                self.registerCarModelDelegate?.didFinishRegisterCar(status, isRegister: isRegister)
                break
                
            case .unAuthorized:
            
            service.refreshToken(){ (statusRefreshToken) in
                if statusRefreshToken == .success {
                    self.registerCarModelDelegate?.didFinishRefreshToken(type: .registerCar)
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
    
    func fetchPolicies(){
        let service = ServiceWrapper()
        let axlesQTYCarStructure: String = UserDefaults.standard.string(forKey: "axlesQTYCarStructure")!
        
        let webServiceURLPolicies = "https://api.toolbox.projects.ifra.io/v1/policies?axlesQTY=\(axlesQTYCarStructure)&fleetID=\(fleetID)"
        
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
                    
                    self.registerCarModelDelegate?.didFinishFetchingStandardMaintenance(status, policies: policies!.last!)
                    break
                case .unAuthorized:
                
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.registerCarModelDelegate?.didFinishRefreshToken(type: .fetchPolicies)
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
                    
                    self.registerCarModelDelegate?.didFinishFetchingJobSite(status, jobsites: jobsites!.last!)
                    break
                case .unAuthorized:
                
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.registerCarModelDelegate?.didFinishRefreshToken(type: .fetchJobSite)
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


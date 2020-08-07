//
//  RegisterTireModel.swift
//  BridgeStone
//
//  Created by somsak on 13/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class RegisterTireModel{

    private var registerTireModelDelegate: RegisterTireModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!
    let isNewTire: Bool = UserDefaults.standard.bool(forKey: "isNewTire")

    init(view: RegisterTireModelDelegate) {
        self.registerTireModelDelegate = view
    }
    
    func registerTire(data: [String]){
        let service = ServiceWrapper()
        var parameters: Parameters = [:]
        
        if !data[6].isEmpty {
            parameters = ["tireType": data[0], "tireSerialNumber": data[1], "pastTireTemplateID": Int(data[2]), "jobSiteID": Int(data[3]), "manufacturingWeek": Int(data[4]), "manufacturingYear": Int(data[5]), "tireTemplateID": Int(data[6]), "tiresRetreadSerialNumber": data[7]
            ]
        }else{
            parameters = ["tireType": data[0], "tireSerialNumber": data[1], "tireTemplateID": Int(data[2]), "jobSiteID": Int(data[3]), "manufacturingWeek": Int(data[4]), "manufacturingYear": Int(data[5])
            ]
        }
        
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.tires)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        service.serviceResponse(request: urlRequest) { (response, status) in

            switch status {
            case .success:
                self.registerTireModelDelegate?.didFinishRegisterTire(status)
                break
            case .unAuthorized:
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.registerTireModelDelegate?.didFinishRefreshToken(type: .registerTire)
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
    
    func registerTireNext(data: [String]){
        let service = ServiceWrapper()
        var parameters: Parameters = [:]
        
        if !data[6].isEmpty {            
            parameters = ["tireType": data[0], "tireSerialNumber": data[1], "pastTireTemplateID": Int(data[2]), "jobSiteID": Int(data[3]), "manufacturingWeek": Int(data[4]), "manufacturingYear": Int(data[5]), "tireTemplateID": Int(data[6]), "tiresRetreadSerialNumber": data[7]
            ]
        }else{
            
            parameters = ["tireType": data[0], "tireSerialNumber": data[1], "tireTemplateID": Int(data[2]), "jobSiteID": Int(data[3]), "manufacturingWeek": Int(data[4]), "manufacturingYear": Int(data[5])
            ]
            
            parameters = ["tireType": data[0], "tireSerialNumber": data[1], "tireTemplateID": Int(data[2]), "jobSiteID": Int(data[3]), "manufacturingWeek": Int(data[4]), "manufacturingYear": Int(data[5])
            ]
        }
        
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.tires)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        service.serviceResponse(request: urlRequest) { (response, status) in

            switch status {
            case .success:

                break
            case .unAuthorized:
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.registerTireModelDelegate?.didFinishRefreshToken(type: .registerTireNext)
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

            self.registerTireModelDelegate?.didFinishRegisterTireNext(status)
        }
    }
    
    func fetchDesignTire(){
        let service = ServiceWrapper()
        var webServiceURLFTireTemplates = ""
        let isSaveTemplates = UserDefaults.standard.bool(forKey: "isSaveTemplates")
        
        if isSaveTemplates {
            webServiceURLFTireTemplates = "https://api.toolbox.projects.ifra.io/v1/tires/templates?fleetID=\(fleetID)"
        }else{
            webServiceURLFTireTemplates = "https://api.toolbox.projects.ifra.io/v1/tires/past-templates?fleetID=\(fleetID)"
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
                
                self.registerTireModelDelegate?.didFinishFetchingTireTemplates(status, tireTemplates: tireTemplates!.last!)
                break
                
            case .unAuthorized:
                
                service.refreshToken(){ (statusRefreshToken) in
                    if statusRefreshToken == .success {
                        self.registerTireModelDelegate?.didFinishRefreshToken(type: .fetchDesignTire)
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
                    
                    self.registerTireModelDelegate?.didFinishFetchingJobSite(status, jobsites: jobsites!.last!)
                    break
                case .unAuthorized:
                
                    service.refreshToken(){ (statusRefreshToken) in
                        if statusRefreshToken == .success {
                            self.registerTireModelDelegate?.didFinishRefreshToken(type: .fetchJobSite)
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

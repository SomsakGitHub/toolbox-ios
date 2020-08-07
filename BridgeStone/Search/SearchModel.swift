//
//  SearchModel.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SearchModel{
    
    private var searchModelDelegate: SearchModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!
    
    init(view: SearchModelDelegate) {
        self.searchModelDelegate = view
    }
    
    func fetchTire(params: [String]){
        let service = ServiceWrapper()
        
        let webServiceURLTires = "https://api.toolbox.projects.ifra.io/v1/tires?q=\(params[0])&dlow=\(params[1])&dheight=\(params[2])&orderby=\(params[3])&status=\(params[4])&fleetID=\(fleetID)"
        
        var urlRequest = URLRequest(url:  URL(string: webServiceURLTires.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed)!)!)
        
        print("urlRequest", urlRequest)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]["tires"]
                    
                    var tire: [Tire]? = []

                    for index in data.arrayValue{
                        
                        let tireStatus: TireStatus? = TireStatus(
                            id: index["tireStatus"]["id"].intValue,
                            nameTH: index["tireStatus"]["nameTH"].stringValue,
                            nameEN: index["tireStatus"]["nameEN"].stringValue
                        )
                        
                        tire?.append(Tire(
                            id: index["id"].intValue,
                            pastTireTemplateID: index["pastTireTemplateID"].intValue,
                            tireSerialNumber: index["tireSerialNumber"].stringValue,
                            licensePlate: index["licensePlate"].stringValue,
                            firstname: index["firstname"].stringValue,
                            actionTime: index["actionTime"].stringValue,
                            image: index["image"].stringValue,
                            tiresRetreadSerialNumber: index["tiresRetreadSerialNumber"].stringValue,
                            tireStatus: tireStatus!
                        ))
                    }

                    self.searchModelDelegate?.didFinishFetchingTire(status, tire: tire!)
                    
                    break
                case .unAuthorized:
                    service.refreshToken(){ (statusRefreshToken) in
                        if statusRefreshToken == .success {
                            self.searchModelDelegate?.didFinishRefreshToken(type: .fetchTire)
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
    
    func fetchCar(params: [String]){
        let service = ServiceWrapper()

        let webServiceURLCar = "https://api.toolbox.projects.ifra.io/v1/cars?q=\(params[0])&axlesQTY=\(params[1])&wheelQTY=\(params[2])&carType=\(params[3])&lastCheck=\(params[4])&carStatus=\(params[5])&fleetID=\(fleetID)"

        var urlRequest = URLRequest(url:  URL(string: webServiceURLCar.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed)!)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs

        service.serviceResponse(request: urlRequest) { (response, status) in

            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]["cars"]

                    var car: [Car]? = []

                    for index in data.arrayValue{

                        let vehicleType: VehicleType? = VehicleType(
                            id: index["carStructures"]["vehicleType"]["id"].intValue,
                            nameTH: index["carStructures"]["vehicleType"]["nameTH"].stringValue,
                            nameEN: index["carStructures"]["vehicleType"]["nameEN"].stringValue
                        )
                        
                        let carStructures: CarStructures? = CarStructures(
                            id: index["carStructures"]["id"].intValue,
                            axlesQTY: index["carStructures"]["axlesQTY"].intValue,
                            wheelQTY: index["carStructures"]["wheelQTY"].intValue,
                            name: index["carStructures"]["name"].stringValue,
                            code: index["carStructures"]["code"].stringValue,
                            type: index["carStructures"]["type"].stringValue,
                            image: index["carStructures"]["image"].stringValue,
                            vehicleType: vehicleType!
                        )
                        
                        let carPolicies: CarPolicies? = CarPolicies(
                            id: index["carPolicies"]["id"].intValue,
                            name: index["carPolicies"]["name"].stringValue
                        )

                        car?.append(Car(
                            id: index["id"].intValue,
                            carMile: index["carMile"].intValue,
                            jobSiteID: index["jobSiteID"].intValue,
                            licensePlate: index["licensePlate"].stringValue,
                            latestCheck: index["latestCheck"].stringValue,
                            driverFirstname: index["driverFirstname"].stringValue,
                            driverLastname: index["driverLastname"].stringValue,
                            mobileNumber: index["mobileNumber"].stringValue,
                            jobSitesName: index["jobSitesName"].stringValue,
                            fleetName: index["fleetName"].stringValue,
                            carImage: index["carImage"].stringValue,
                            carStatus: index["carStatus"].bool!,
                            carStructures: carStructures!,
                            carPolicies: carPolicies!
                        ))
                    }

                    self.searchModelDelegate?.didFinishFetchingCar(status, car: car!)
                    break
                case .unAuthorized:
                    service.refreshToken(){ (statusRefreshToken) in
                        if statusRefreshToken == .success {
                            self.searchModelDelegate?.didFinishRefreshToken(type: .fetchCar)
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
    
    func fetchJobSite(params: [String]){
        let service = ServiceWrapper()

        let webServiceURLCar = "https://api.toolbox.projects.ifra.io/v1/jobsites?q=\(params[0])&fleetID=\(fleetID)"

        var urlRequest = URLRequest(url:  URL(string: webServiceURLCar.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed)!)!)
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

                    self.searchModelDelegate?.didFinishFetchingJobsites(status, jobsites: jobsites!)
                    break
                case .unAuthorized:
                    service.refreshToken(){ (statusRefreshToken) in
                        if statusRefreshToken == .success {
                            self.searchModelDelegate?.didFinishRefreshToken(type: .fetchJobSite)
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




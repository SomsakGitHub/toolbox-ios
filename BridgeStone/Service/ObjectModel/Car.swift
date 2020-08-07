//
//  Car.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

class Car {
    var id, carMile, jobSiteID: Int
    var licensePlate, latestCheck, driverFirstname, driverLastname, mobileNumber, jobSitesName, fleetName, carImage: String
    var carStatus: Bool
    var carStructures: CarStructures
    var carPolicies: CarPolicies
    
    init(id: Int, carMile: Int, jobSiteID: Int, licensePlate: String, latestCheck: String, driverFirstname: String, driverLastname: String, mobileNumber: String, jobSitesName: String, fleetName: String, carImage: String, carStatus: Bool, carStructures: CarStructures, carPolicies: CarPolicies) {
        self.id = id
        self.carMile = carMile
        self.jobSiteID = jobSiteID
        self.licensePlate = licensePlate
        self.latestCheck = latestCheck
        self.driverFirstname = driverFirstname
        self.driverLastname = driverLastname
        self.mobileNumber = jobSitesName
        self.jobSitesName = jobSitesName
        self.fleetName = fleetName
        self.carImage = carImage
        self.carStatus = carStatus
        self.carStructures = carStructures
        self.carPolicies = carPolicies
    }
}

class CarStructures {
    var id, axlesQTY, wheelQTY: Int
    var name, code, type, image: String
    var vehicleType: VehicleType
    
    init(id: Int, axlesQTY: Int, wheelQTY: Int, name: String, code: String, type: String, image: String, vehicleType: VehicleType) {
        self.id = id
        self.axlesQTY = axlesQTY
        self.wheelQTY = wheelQTY
        self.name = name
        self.code = code
        self.type = type
        self.image = image
        self.vehicleType = vehicleType
    }
}

class VehicleType {
    var id: Int
    var nameTH, nameEN: String
    
    init(id: Int, nameTH: String, nameEN: String) {
        self.id = id
        self.nameTH = nameTH
        self.nameEN = nameEN
    }
}

class CarPolicies {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

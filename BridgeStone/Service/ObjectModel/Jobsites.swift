//
//  Jobsites.swift
//  BridgeStone
//
//  Created by somsak on 16/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

class Jobsites {
    var id, totalVehicles: Int
    var fleetID, jobsiteName, address, district, province, updated: String
    
    init(id: Int, totalVehicles: Int, fleetID: String, jobsiteName: String, address: String, district: String, province: String, updated: String) {
        self.id = id
        self.totalVehicles = totalVehicles
        self.fleetID = fleetID
        self.jobsiteName = jobsiteName
        self.address = address
        self.district = district
        self.province = province
        self.updated = updated
    }
}

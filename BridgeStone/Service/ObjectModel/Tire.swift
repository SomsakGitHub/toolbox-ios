//
//  Tire.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
class Tire {
    var id, pastTireTemplateID: Int
    var tireSerialNumber, licensePlate, firstname, actionTime, image, tiresRetreadSerialNumber: String
    var tireStatus: TireStatus
    
    init(id: Int, pastTireTemplateID: Int, tireSerialNumber: String, licensePlate: String, firstname: String, actionTime: String, image: String, tiresRetreadSerialNumber: String, tireStatus: TireStatus) {
        self.id = id
        self.pastTireTemplateID = pastTireTemplateID
        self.tireSerialNumber = tireSerialNumber
        self.licensePlate = licensePlate
        self.firstname = firstname
        self.actionTime = actionTime
        self.image = image
        self.tiresRetreadSerialNumber = tiresRetreadSerialNumber
        self.tireStatus = tireStatus
    }
}

class TireStatus {
    var id: Int
    var nameTH, nameEN: String
    
    init(id: Int, nameTH: String, nameEN: String) {
        self.id = id
        self.nameTH = nameTH
        self.nameEN = nameEN
    }
}



//
//  CarStructure.swift
//  BridgeStone
//
//  Created by somsak on 17/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

class CarStructure {
    var id, axlesQTY, wheelQTY: Int
    var image, name, code, structureType: String
    
    init(id: Int, axlesQTY: Int, wheelQTY: Int, image: String, name: String, code: String, structureType: String) {
        self.id = id
        self.axlesQTY = axlesQTY
        self.wheelQTY = wheelQTY
        self.image = image
        self.name = name
        self.code = code
        self.structureType = structureType
    }
}

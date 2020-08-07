//
//  Policies.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

class Policies {
    var id, fleetID, axlesQTY: Int
    var name: String
    
    init(id: Int, fleetID: Int, axlesQTY: Int, name: String) {
        self.id = id
        self.fleetID = fleetID
        self.axlesQTY = axlesQTY
        self.name = name
    }
}

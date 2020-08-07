//
//  Fleet.swift
//  BridgeStone
//
//  Created by somsak on 21/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

class Fleet {
    var id, name, addr, district, province, bussines_type_id, transport_type_id: String
    
    init(id: String, name: String, addr: String, district: String, province: String, bussines_type_id: String, transport_type_id: String) {
        self.id = id
        self.name = name
        self.addr = addr
        self.district = district
        self.province = province
        self.bussines_type_id = bussines_type_id
        self.transport_type_id = transport_type_id
    }
}

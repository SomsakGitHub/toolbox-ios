//
//  FavoriteFleets.swift
//  BridgeStone
//
//  Created by somsak on 29/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

class FavoriteFleets {
    var id, fleetsID, userID: Int
    
    init(id: Int, fleetsID: Int, userID: Int) {
        self.id = id
        self.fleetsID = fleetsID
        self.userID = userID
    }
}

//
//  UserManagerProtocol.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 19/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol UserManagerProtocol {
    func saveUserInformation(accessToken: String, refreshToken: String)
    func saveFavoriteFleet(favoriteFleet: String)
}

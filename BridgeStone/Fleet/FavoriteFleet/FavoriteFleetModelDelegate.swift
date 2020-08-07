//
//  FavoriteFleetModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 29/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol FavoriteFleetModelDelegate {
    func didFinishFetchingAllFleet(_ status: statusWebService, fleet: [Fleet])
    func didFinishFetchingFavoriteFleet(_ status: statusWebService, favoriteFleet: [FavoriteFleets])
    func didFinishFetchingDeleteFleetFavorite(_ status: statusWebService)
    func didFinishRefreshToken(type: favoriteFleetModelEnum)
}

enum favoriteFleetModelEnum {
    case fetchFleet
    case fetchFavoriteFleet
    case deleteFleetFavorite
}

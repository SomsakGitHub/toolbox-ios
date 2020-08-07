//
//  AllFleetModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 21/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol AllFleetModelDelegate {
    func didFinishFetchingAllFleet(_ status: statusWebService, fleet: [Fleet])
    func didFinishFetchingFavoriteFleet(_ status: statusWebService, favoriteFleet: [FavoriteFleets])
    func didFinishSaveFleetfavorite(_ status: statusWebService)
    func didFinishFetchingDeleteFleetFavorite(_ status: statusWebService)
    func didFinishRefreshToken(type: allFleetModelEnum)
}

enum allFleetModelEnum {
    case fetchFleet
    case saveFleetfavorite
    case fetchFavoriteFleet
    case deleteFleetFavorite
}

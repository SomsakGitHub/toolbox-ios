//
//  DialogCarDetailModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
protocol DialogCarDetailModelDelegate {
    func didFinishFetchingSizeTire(_ status: statusWebService, sizeTire: [SizeTire])
    func didFinishRefreshToken(type: dialogCarDetailModelEnum)
//    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile])
//    func didFinishEditProfile(_ status: statusWebService)
}

enum dialogCarDetailModelEnum {
    case fetchSizeTire
    case fetchBrandTire
    case fetchPatternTire
}

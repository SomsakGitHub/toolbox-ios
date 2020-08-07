//
//  DesignTireAfterModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol DesignTireAfterModelDelegate {
    func didFinishFetchingDesignTireAfter(_ status: statusWebService, tireTemplates: [TireTemplates])
    func didFinishRefreshToken()
//    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile])
//    func didFinishEditProfile(_ status: statusWebService)
}

protocol DesignTireAfterVCDelegate {
    func selectDesignTireAfter(data: TireTemplates)
}

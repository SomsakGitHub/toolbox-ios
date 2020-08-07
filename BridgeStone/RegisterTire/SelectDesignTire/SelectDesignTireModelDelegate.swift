//
//  DesignTireAfterModelModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 14/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol SelectDesignTireModelDelegate {
    func didFinishFetchingTireTemplates(_ status: statusWebService, tireTemplates: [TireTemplates])
    func didFinishRefreshToken()
//    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile])
//    func didFinishEditProfile(_ status: statusWebService)
}

protocol SelectDesignTireVCDelegate {
    func selectDesignTire(data: TireTemplates)
}

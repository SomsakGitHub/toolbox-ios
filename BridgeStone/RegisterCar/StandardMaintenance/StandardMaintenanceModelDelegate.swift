//
//  StandardMaintenanceModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol StandardMaintenanceModelDelegate {
    func didFinishFetchingStandardMaintenance(_ status: statusWebService, policies: [Policies])
    func didFinishRefreshToken()
//    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile])
//    func didFinishEditProfile(_ status: statusWebService)
}

protocol StandardMaintenanceVCDelegate {
    func selectStandardMaintenance(data: Policies)
}

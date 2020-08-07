//
//  CreateStandardMaintenanceModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 21/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol CreateStandardMaintenanceModelDelegate {
    func didFinishCreateStandardMaintenance(_ status: statusWebService)
    func didFinishRefreshToken()
//    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile])
//    func didFinishEditProfile(_ status: statusWebService)
}

//
//  CarStructureModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 17/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol CarStructureModelDelegate {
    func didFinishFetchingCarStructure(_ status: statusWebService, carStructure: [CarStructure])
    func didFinishRefreshToken()
//    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile])
//    func didFinishEditProfile(_ status: statusWebService)
}

protocol CarStructureVCDelegate {
    func selectcarStructure(data: CarStructure)
}

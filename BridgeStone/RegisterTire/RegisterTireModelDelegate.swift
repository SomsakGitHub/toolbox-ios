//
//  RegisterTireModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 13/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol RegisterTireModelDelegate {
    func didFinishRegisterTire(_ status: statusWebService)
    func didFinishRegisterTireNext(_ status: statusWebService)
    func didFinishFetchingJobSite(_ status: statusWebService, jobsites: Jobsites)
    func didFinishFetchingTireTemplates(_ status: statusWebService, tireTemplates: TireTemplates)
    func didFinishRefreshToken(type: registerTireModelEnum)
}

enum registerTireModelEnum {
    case registerTire
    case registerTireNext
    case fetchDesignTire
    case fetchJobSite
}

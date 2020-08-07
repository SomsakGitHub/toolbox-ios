//
//  RegisterCarModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 17/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol RegisterCarModelDelegate {
    func didFinishRegisterCar(_ status: statusWebService, isRegister: Bool)
    func didFinishFetchingStandardMaintenance(_ status: statusWebService, policies: Policies)
    func didFinishFetchingJobSite(_ status: statusWebService, jobsites: Jobsites)
    func didFinishRefreshToken(type: registerCarModelEnum)
}

enum registerCarModelEnum {
    case registerCar
    case fetchPolicies
    case fetchJobSite
}

//
//  SearchModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol SearchModelDelegate {
    func didFinishRefreshToken(type: searchModelEnum)
    func didFinishFetchingTire(_ status: statusWebService, tire: [Tire])
    func didFinishFetchingCar(_ status: statusWebService, car: [Car])
    func didFinishFetchingJobsites (_ status: statusWebService, jobsites: [Jobsites])
//    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile])
//    func didFinishEditProfile(_ status: statusWebService)
}

enum searchModelEnum {
    case fetchTire
    case fetchCar
    case fetchJobSite
}

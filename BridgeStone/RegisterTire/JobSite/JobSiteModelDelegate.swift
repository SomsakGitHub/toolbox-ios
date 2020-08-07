//
//  JobSiteModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 16/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol JobSiteModelDelegate {
    func didFinishFetchingJobSite(_ status: statusWebService, jobsites: [Jobsites])
    func didFinishRefreshToken()
//    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile])
//    func didFinishEditProfile(_ status: statusWebService)
}

protocol SelectJobSiteVCDelegate {
    func selectJobSite(data: Jobsites)
}

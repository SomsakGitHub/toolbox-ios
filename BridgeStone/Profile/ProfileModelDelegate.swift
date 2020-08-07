//
//  ProfileModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 1/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol ProfileModelDelegate {
    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile])
    func didFinishEditProfile(_ status: statusWebService)
    func didFinishRefreshToken(type: profileModelEnum)
}

enum profileModelEnum {
    case fetchProfile
    case editProfile
}

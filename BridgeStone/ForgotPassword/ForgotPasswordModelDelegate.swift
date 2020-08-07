//
//  ForgotPasswordModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 23/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol ForgotPasswordModelDelegate {
    func didFinishFetchingForgotPassword(_ status: statusWebService)
    func didFinishRefreshToken()
}

//
//  RegisterTireTemplateModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 21/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
protocol RegisterTireTemplateModelDelegate {
    func didFinishRegisterTireTemplate(_ status: statusWebService)
    func didFinishRefreshToken()
}

//
//  AddNewFleetDelegate.swift
//  BridgeStone
//
//  Created by somsak on 27/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol AddNewFleetDelegate {
    func didFinishSaveFleet(_ status: statusWebService)
    func didFinishRefreshToken()
}

protocol AddNewFleetVCDelegate {
    func addNewFleet(status: Bool)
}

//
//  DialogAddJobSiteModelDelegate.swift
//  BridgeStone
//
//  Created by somsak on 20/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

protocol DialogAddJobSiteModelDelegate {
    func didFinishAddJobSite(_ status: statusWebService)
    func didFinishRefreshToken()
}

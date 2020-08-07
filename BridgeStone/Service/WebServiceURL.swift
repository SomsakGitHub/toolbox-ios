//
//  WebServiceURL.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 19/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

class WebServiceURL {
    
    static let BridgeStoneRootURL = "https://api.toolbox.projects.ifra.io"
    static let PATH = "v1"
    
    //service list
//    static var register = "\(meeChokRootUrl)/user/register"
    static var login = "\(BridgeStoneRootURL)/\(PATH)/users/login"
    static var refreshToken = "\(BridgeStoneRootURL)/\(PATH)/users/refresh-token"
    static var forgotPassword = "\(BridgeStoneRootURL)/\(PATH)/users/forgot-password"
    static var fleets = "\(BridgeStoneRootURL)/\(PATH)/fleets"
    static var getFleetfavorite = "\(BridgeStoneRootURL)/\(PATH)/fleets-favorite"
    static var saveFleetfavorite = "\(BridgeStoneRootURL)/\(PATH)/fleets-favorite"
    static var saveFleet = "\(BridgeStoneRootURL)/\(PATH)/fleets"
    static var tireTemplates = "\(BridgeStoneRootURL)/\(PATH)/tires/templates"
    static var pastTireTemplates = "\(BridgeStoneRootURL)/\(PATH)/tires/past-templates"
    static var jobsites = "\(BridgeStoneRootURL)/\(PATH)/jobsites"
    static var tires = "\(BridgeStoneRootURL)/\(PATH)/tires"
    static var carStructure = "\(BridgeStoneRootURL)/\(PATH)/car-structure"
    static var policies = "\(BridgeStoneRootURL)/\(PATH)/policies"
    static var cars = "\(BridgeStoneRootURL)/\(PATH)/cars"
    static var masterDataTiresSizes = "\(BridgeStoneRootURL)/\(PATH)/master-data/tires-sizes"
    static var masterDataTiresBrands = "\(BridgeStoneRootURL)/\(PATH)/master-data/tires-brands"
    static var masterDataTiresPatterns = "\(BridgeStoneRootURL)/\(PATH)/master-data/tires-patterns"
    
}

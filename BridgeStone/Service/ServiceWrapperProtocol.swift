//
//  ServiceWrapperProtocol.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 19/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ServiceWrapperProtocol {
    func serviceResponse(request: URLRequest, completion: @escaping (Data?,statusWebService) -> Void)
}

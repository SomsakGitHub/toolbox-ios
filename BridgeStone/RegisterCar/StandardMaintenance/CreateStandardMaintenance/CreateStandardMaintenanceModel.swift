//
//  CreateStandardMaintenanceModel.swift
//  BridgeStone
//
//  Created by somsak on 21/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class CreateStandardMaintenanceModel{

    private var createStandardMaintenanceModelDelegate: CreateStandardMaintenanceModelDelegate?
    let token: String = (CoreDataManager().getUserData().first?.accessToken)!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!
    let axlesQTYCarStructure: String = UserDefaults.standard.string(forKey: "axlesQTYCarStructure")!

    init(view: CreateStandardMaintenanceModelDelegate) {
        self.createStandardMaintenanceModelDelegate = view
    }
    
    func createStandardMaintenance(name: String, axles1: [String], axles2: [String], axles3: [String], axles4: [String], axles5: [String], axles6: [String], axles7: [String], axles8: [String]){
        
        let axles1Int = [1, Int(axles1[1]), Int(axles1[2]), Int(axles1[3]), Int(axles1[4]), Int(axles1[5])]
        let axles2Int = [2, Int(axles2[1]), Int(axles2[2]), Int(axles2[3]), Int(axles2[4]), Int(axles2[5])]
        let axles3Int = [3, Int(axles3[1]), Int(axles3[2]), Int(axles3[3]), Int(axles3[4]), Int(axles3[5])]
        let axles4Int = [4, Int(axles4[1]), Int(axles4[2]), Int(axles4[3]), Int(axles4[4]), Int(axles4[5])]
        let axles5Int = [5, Int(axles5[1]), Int(axles5[2]), Int(axles5[3]), Int(axles5[4]), Int(axles5[5])]
        let axles6Int = [6, Int(axles6[1]), Int(axles6[2]), Int(axles6[3]), Int(axles6[4]), Int(axles6[5])]
        let axles7Int = [7, Int(axles7[1]), Int(axles7[2]), Int(axles7[3]), Int(axles7[4]), Int(axles7[5])]
        let axles8Int = [8, Int(axles8[1]), Int(axles8[2]), Int(axles8[3]), Int(axles8[4]), Int(axles8[5])]
        
        let axlesQTYCarStructureInt = Int(axlesQTYCarStructure)
        var parameters: Parameters = [:]
        
        
        switch axlesQTYCarStructureInt {
        case 1:
            
            parameters = [
                "axlesQTY": 1,
                "fleetID": Int(fleetID),
                "name": name,
                "policies": [
                    [
                        "axles": 1,
                        "warningTireDepth": axles1Int[1],
                        "criticalTireDepth": axles1Int[2],
                        "standardTirePressure": axles1Int[3],
                        "warningTirePressure": axles1Int[4],
                        "criticalTirePressure": axles1Int[5]
                    ]
                ]
            ]
            break
        case 2:
            
            parameters = [
                "axlesQTY": 2,
                "fleetID": Int(fleetID),
                "name": name,
                "policies": [
                    [
                        "axles": 1,
                        "warningTireDepth": axles1Int[1],
                        "criticalTireDepth": axles1Int[2],
                        "standardTirePressure": axles1Int[3],
                        "warningTirePressure": axles1Int[4],
                        "criticalTirePressure": axles1Int[5]
                    ],
                    [
                        "axles": 2,
                        "warningTireDepth": axles2Int[1],
                        "criticalTireDepth": axles2Int[2],
                        "standardTirePressure": axles2Int[3],
                        "warningTirePressure": axles2Int[4],
                        "criticalTirePressure": axles2Int[5]
                    ]
                ]
            ]
            break
        case 3:
            parameters = [
                "axlesQTY": 3,
                "fleetID": Int(fleetID),
                "name": name,
                "policies": [
                    [
                        "axles": 1,
                        "warningTireDepth": axles1Int[1],
                        "criticalTireDepth": axles1Int[2],
                        "standardTirePressure": axles1Int[3],
                        "warningTirePressure": axles1Int[4],
                        "criticalTirePressure": axles1Int[5]
                    ],
                    [
                        "axles": 2,
                        "warningTireDepth": axles2Int[1],
                        "criticalTireDepth": axles2Int[2],
                        "standardTirePressure": axles2Int[3],
                        "warningTirePressure": axles2Int[4],
                        "criticalTirePressure": axles2Int[5]
                    ],
                    [
                        "axles": 3,
                        "warningTireDepth": axles3Int[1],
                        "criticalTireDepth": axles3Int[2],
                        "standardTirePressure": axles3Int[3],
                        "warningTirePressure": axles3Int[4],
                        "criticalTirePressure": axles3Int[5]
                    ]
                ]
            ]
            break
        case 4:
            parameters = [
                "axlesQTY": 4,
                "fleetID": Int(fleetID),
                "name": name,
                "policies": [
                    [
                        "axles": 1,
                        "warningTireDepth": axles1Int[1],
                        "criticalTireDepth": axles1Int[2],
                        "standardTirePressure": axles1Int[3],
                        "warningTirePressure": axles1Int[4],
                        "criticalTirePressure": axles1Int[5]
                    ],
                    [
                        "axles": 2,
                        "warningTireDepth": axles2Int[1],
                        "criticalTireDepth": axles2Int[2],
                        "standardTirePressure": axles2Int[3],
                        "warningTirePressure": axles2Int[4],
                        "criticalTirePressure": axles2Int[5]
                    ],
                    [
                        "axles": 3,
                        "warningTireDepth": axles3Int[1],
                        "criticalTireDepth": axles3Int[2],
                        "standardTirePressure": axles3Int[3],
                        "warningTirePressure": axles3Int[4],
                        "criticalTirePressure": axles3Int[5]
                    ],
                    [
                        "axles": 4,
                        "warningTireDepth": axles4Int[1],
                        "criticalTireDepth": axles4Int[2],
                        "standardTirePressure": axles4Int[3],
                        "warningTirePressure": axles4Int[4],
                        "criticalTirePressure": axles4Int[5]
                    ]
                ]
            ]
            break
        case 5:
            parameters = [
                "axlesQTY": 5,
                "fleetID": Int(fleetID),
                "name": name,
                "policies": [
                    [
                        "axles": 1,
                        "warningTireDepth": axles1Int[1],
                        "criticalTireDepth": axles1Int[2],
                        "standardTirePressure": axles1Int[3],
                        "warningTirePressure": axles1Int[4],
                        "criticalTirePressure": axles1Int[5]
                    ],
                    [
                        "axles": 2,
                        "warningTireDepth": axles2Int[1],
                        "criticalTireDepth": axles2Int[2],
                        "standardTirePressure": axles2Int[3],
                        "warningTirePressure": axles2Int[4],
                        "criticalTirePressure": axles2Int[5]
                    ],
                    [
                        "axles": 3,
                        "warningTireDepth": axles3Int[1],
                        "criticalTireDepth": axles3Int[2],
                        "standardTirePressure": axles3Int[3],
                        "warningTirePressure": axles3Int[4],
                        "criticalTirePressure": axles3Int[5]
                    ],
                    [
                        "axles": 4,
                        "warningTireDepth": axles4Int[1],
                        "criticalTireDepth": axles4Int[2],
                        "standardTirePressure": axles4Int[3],
                        "warningTirePressure": axles4Int[4],
                        "criticalTirePressure": axles4Int[5]
                    ],
                    [
                        "axles": 5,
                        "warningTireDepth": axles5Int[1],
                        "criticalTireDepth": axles5Int[2],
                        "standardTirePressure": axles5Int[3],
                        "warningTirePressure": axles5Int[4],
                        "criticalTirePressure": axles5Int[5]
                    ]
                ]
            ]
            break
        case 6:
            parameters = [
                "axlesQTY": 6,
                "fleetID": Int(fleetID),
                "name": name,
                "policies": [
                    [
                        "axles": 1,
                        "warningTireDepth": axles1Int[1],
                        "criticalTireDepth": axles1Int[2],
                        "standardTirePressure": axles1Int[3],
                        "warningTirePressure": axles1Int[4],
                        "criticalTirePressure": axles1Int[5]
                    ],
                    [
                        "axles": 2,
                        "warningTireDepth": axles2Int[1],
                        "criticalTireDepth": axles2Int[2],
                        "standardTirePressure": axles2Int[3],
                        "warningTirePressure": axles2Int[4],
                        "criticalTirePressure": axles2Int[5]
                    ],
                    [
                        "axles": 3,
                        "warningTireDepth": axles3Int[1],
                        "criticalTireDepth": axles3Int[2],
                        "standardTirePressure": axles3Int[3],
                        "warningTirePressure": axles3Int[4],
                        "criticalTirePressure": axles3Int[5]
                    ],
                    [
                        "axles": 4,
                        "warningTireDepth": axles4Int[1],
                        "criticalTireDepth": axles4Int[2],
                        "standardTirePressure": axles4Int[3],
                        "warningTirePressure": axles4Int[4],
                        "criticalTirePressure": axles4Int[5]
                    ],
                    [
                        "axles": 5,
                        "warningTireDepth": axles5Int[1],
                        "criticalTireDepth": axles5Int[2],
                        "standardTirePressure": axles5Int[3],
                        "warningTirePressure": axles5Int[4],
                        "criticalTirePressure": axles5Int[5]
                    ],
                    [
                        "axles": 6,
                        "warningTireDepth": axles6Int[1],
                        "criticalTireDepth": axles6Int[2],
                        "standardTirePressure": axles6Int[3],
                        "warningTirePressure": axles6Int[4],
                        "criticalTirePressure": axles6Int[5]
                    ]
                ]
            ]
            break
        case 7:
            parameters = [
                "axlesQTY": 7,
                "fleetID": Int(fleetID),
                "name": name,
                "policies": [
                    [
                        "axles": 1,
                        "warningTireDepth": axles1Int[1],
                        "criticalTireDepth": axles1Int[2],
                        "standardTirePressure": axles1Int[3],
                        "warningTirePressure": axles1Int[4],
                        "criticalTirePressure": axles1Int[5]
                    ],
                    [
                        "axles": 2,
                        "warningTireDepth": axles2Int[1],
                        "criticalTireDepth": axles2Int[2],
                        "standardTirePressure": axles2Int[3],
                        "warningTirePressure": axles2Int[4],
                        "criticalTirePressure": axles2Int[5]
                    ],
                    [
                        "axles": 3,
                        "warningTireDepth": axles3Int[1],
                        "criticalTireDepth": axles3Int[2],
                        "standardTirePressure": axles3Int[3],
                        "warningTirePressure": axles3Int[4],
                        "criticalTirePressure": axles3Int[5]
                    ],
                    [
                        "axles": 4,
                        "warningTireDepth": axles4Int[1],
                        "criticalTireDepth": axles4Int[2],
                        "standardTirePressure": axles4Int[3],
                        "warningTirePressure": axles4Int[4],
                        "criticalTirePressure": axles4Int[5]
                    ],
                    [
                        "axles": 5,
                        "warningTireDepth": axles5Int[1],
                        "criticalTireDepth": axles5Int[2],
                        "standardTirePressure": axles5Int[3],
                        "warningTirePressure": axles5Int[4],
                        "criticalTirePressure": axles5Int[5]
                    ],
                    [
                        "axles": 6,
                        "warningTireDepth": axles6Int[1],
                        "criticalTireDepth": axles6Int[2],
                        "standardTirePressure": axles6Int[3],
                        "warningTirePressure": axles6Int[4],
                        "criticalTirePressure": axles6Int[5]
                    ],
                    [
                        "axles": 7,
                        "warningTireDepth": axles7Int[1],
                        "criticalTireDepth": axles7Int[2],
                        "standardTirePressure": axles7Int[3],
                        "warningTirePressure": axles7Int[4],
                        "criticalTirePressure": axles7Int[5]
                    ]
                ]
            ]
            break
        case 8:
            parameters = [
                "axlesQTY": 8,
                "fleetID": Int(fleetID),
                "name": name,
                "policies": [
                    [
                        "axles": 1,
                        "warningTireDepth": axles1Int[1],
                        "criticalTireDepth": axles1Int[2],
                        "standardTirePressure": axles1Int[3],
                        "warningTirePressure": axles1Int[4],
                        "criticalTirePressure": axles1Int[5]
                    ],
                    [
                        "axles": 2,
                        "warningTireDepth": axles2Int[1],
                        "criticalTireDepth": axles2Int[2],
                        "standardTirePressure": axles2Int[3],
                        "warningTirePressure": axles2Int[4],
                        "criticalTirePressure": axles2Int[5]
                    ],
                    [
                        "axles": 3,
                        "warningTireDepth": axles3Int[1],
                        "criticalTireDepth": axles3Int[2],
                        "standardTirePressure": axles3Int[3],
                        "warningTirePressure": axles3Int[4],
                        "criticalTirePressure": axles3Int[5]
                    ],
                    [
                        "axles": 4,
                        "warningTireDepth": axles4Int[1],
                        "criticalTireDepth": axles4Int[2],
                        "standardTirePressure": axles4Int[3],
                        "warningTirePressure": axles4Int[4],
                        "criticalTirePressure": axles4Int[5]
                    ],
                    [
                        "axles": 5,
                        "warningTireDepth": axles5Int[1],
                        "criticalTireDepth": axles5Int[2],
                        "standardTirePressure": axles5Int[3],
                        "warningTirePressure": axles5Int[4],
                        "criticalTirePressure": axles5Int[5]
                    ],
                    [
                        "axles": 6,
                        "warningTireDepth": axles6Int[1],
                        "criticalTireDepth": axles6Int[2],
                        "standardTirePressure": axles6Int[3],
                        "warningTirePressure": axles6Int[4],
                        "criticalTirePressure": axles6Int[5]
                    ],
                    [
                        "axles": 7,
                        "warningTireDepth": axles7Int[1],
                        "criticalTireDepth": axles7Int[2],
                        "standardTirePressure": axles7Int[3],
                        "warningTirePressure": axles7Int[4],
                        "criticalTirePressure": axles7Int[5]
                    ],
                    [
                        "axles": 8,
                        "warningTireDepth": axles8Int[1],
                        "criticalTireDepth": axles8Int[2],
                        "standardTirePressure": axles8Int[3],
                        "warningTirePressure": axles8Int[4],
                        "criticalTirePressure": axles8Int[5]
                    ]
                ]
            ]
            break
        default:
            break
        }
        
        let service = ServiceWrapper()
        var urlRequest = URLRequest(url:  URL(string: WebServiceURL.policies)!)
        urlRequest.httpMethod = HTTPMethod.post.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        service.serviceResponse(request: urlRequest) { (response, status) in

            switch status {
            case .success:
                self.createStandardMaintenanceModelDelegate?.didFinishCreateStandardMaintenance(status)
                break
            case .unAuthorized:
            
            service.refreshToken(){ (statusRefreshToken) in
                if statusRefreshToken == .success {
                    self.createStandardMaintenanceModelDelegate?.didFinishRefreshToken()
                }
            }
            
            break
            case .internalServerError:

                break
            case nil:

                break
            default :
                break
            }
        }
    }
}


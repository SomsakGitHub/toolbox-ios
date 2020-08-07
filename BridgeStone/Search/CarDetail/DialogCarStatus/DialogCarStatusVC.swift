//
//  DialogCarStatusVC.swift
//  BridgeStone
//
//  Created by somsak on 3/6/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DialogCarStatusVC: UIViewController {
    
    @IBOutlet weak var selectCarStatusLabel: UILabel!
    @IBOutlet weak var activeLabel: UILabel!
    @IBOutlet weak var notActiveLabel: UILabel!
    
    @IBOutlet weak var trueImage: UIImageView!
    @IBOutlet weak var saveBTN: ButtonRound!
    @IBOutlet weak var falseImage: UIImageView!
    
    var saveDelegate : (() -> Void) = {}
    var carData: Car? = nil
    var carPoliciesId = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView(){
        self.selectCarStatusLabel.text = "select_car_status".localized
        self.activeLabel.text = "active".localized
        self.notActiveLabel.text = "not_active".localized
        self.saveBTN.setTitle("save".localized, for: .normal)
        if carData!.carStatus {
            self.trueImage.image = UIImage(named: "RectangleRed")
            self.falseImage.image = UIImage(named: "RectangleWhite")
        }else{
            self.trueImage.image = UIImage(named: "RectangleWhite")
            self.falseImage.image = UIImage(named: "RectangleRed")
        }
    }
    
    @IBAction func didTapTrue(_ sender: Any) {
        self.carData?.carStatus = true
        self.trueImage.image = UIImage(named: "RectangleRed")
        self.falseImage.image = UIImage(named: "RectangleWhite")
    }
    
    @IBAction func didTapFalse(_ sender: Any) {
        self.carData?.carStatus = false
        self.trueImage.image = UIImage(named: "RectangleWhite")
        self.falseImage.image = UIImage(named: "RectangleRed")
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        putCarStatus()
    }
    
    func putCarStatus(){
        let token: String = (CoreDataManager().getUserData().first?.accessToken)!
        let service = ServiceWrapper()
        let parameters: Parameters = [
            "licensePlate": self.carData?.licensePlate,
            "driverFirstname": self.carData?.driverFirstname,
            "driverLastname": self.carData?.driverLastname,
            "mobileNumber": self.carData?.mobileNumber,
            "jobSiteID": self.carData?.jobSiteID,
            "carStructuresID": self.carData?.carStructures.id,
            "carMile": self.carData?.carMile,
            "carPoliciesID": self.carPoliciesId,
            "carStatus": self.carData?.carStatus
        ]
        
        let webServiceURLEditCar = "https://api.toolbox.projects.ifra.io/v1/cars/\(self.carData!.id)"
        var urlRequest = URLRequest(url:  URL(string: webServiceURLEditCar)!)
        urlRequest.httpMethod = HTTPMethod.put.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs
        urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
            case .success:
                self.saveDelegate()
                break
            case .unAuthorized:
            
            service.refreshToken(){ (statusRefreshToken) in
                if statusRefreshToken == .success {
                    self.putCarStatus()
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
    
    static func createDialog() -> DialogCarStatusVC {
        
        let customDialog: DialogCarStatusVC = UIStoryboard(name: "SearchScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "dialogCarStatusVC") as! DialogCarStatusVC
        customDialog.setDialog()
        
        return customDialog
    }
    
    func setDialog() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    
}

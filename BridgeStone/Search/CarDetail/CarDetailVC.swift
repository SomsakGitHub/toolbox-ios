//
//  CarDetailVC.swift
//  BridgeStone
//
//  Created by somsak on 3/6/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CarDetailVC: UIViewController {
    
    @IBOutlet weak var carDetailLabel: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var mile: UILabel!
    @IBOutlet weak var mileLabel: UILabel!
    @IBOutlet weak var jobSites: UILabel!
    @IBOutlet weak var jobSitesLabel: UILabel!
    @IBOutlet weak var latestCheck: UILabel!
    @IBOutlet weak var latestCheckLabel: UILabel!
    @IBOutlet weak var carStatus: UILabel!
    @IBOutlet weak var carStatusView: ViewRound!
    @IBOutlet weak var carStatusLabel: UILabel!
    @IBOutlet weak var nextBTN: ButtonRound!
    
    
    var carDetail: Car? = nil
    var carDetailId = 0
    var carPoliciesId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCarDetailId()
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapCarStatus(_ sender: Any) {
        self.createDialogCarStatus(data: carDetail!) { (status) in
            if status {
                self.fetchCarDetailId()
            }
        }
    }
    
    func fetchCarDetailId(){
        let token: String = (CoreDataManager().getUserData().first?.accessToken)!
        let service = ServiceWrapper()

        let webServiceURLCar = "https://api.toolbox.projects.ifra.io/v1/cars/\(carDetailId)"

        var urlRequest = URLRequest(url:  URL(string: webServiceURLCar.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed)!)!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.timeoutInterval = 10 // secs

        service.serviceResponse(request: urlRequest) { (response, status) in

            switch status {
                case .success:
                    let json: JSON = JSON(response)
                    let data = json["result"]
                    
                    let vehicleType: VehicleType? = VehicleType(
                        id: data["carStructures"]["vehicleType"]["id"].intValue,
                        nameTH: data["carStructures"]["vehicleType"]["nameTH"].stringValue,
                        nameEN: data["carStructures"]["vehicleType"]["nameEN"].stringValue
                    )
                    
                    let carStructures: CarStructures? = CarStructures(
                        id: data["carStructures"]["id"].intValue,
                        axlesQTY: data["carStructures"]["axlesQTY"].intValue,
                        wheelQTY: data["carStructures"]["wheelQTY"].intValue,
                        name: data["carStructures"]["name"].stringValue,
                        code: data["carStructures"]["code"].stringValue,
                        type: data["carStructures"]["type"].stringValue,
                        image: data["carStructures"]["image"].stringValue,
                        vehicleType: vehicleType!
                    )
                    
                    let carPolicies: CarPolicies? = CarPolicies(
                        id: data["carPolicies"]["id"].intValue,
                        name: data["carPolicies"]["name"].stringValue
                    )
                    
                    let car: Car? = Car(
                        id: data["id"].intValue,
                        carMile: data["carMile"].intValue,
                        jobSiteID: data["jobSiteID"].intValue,
                        licensePlate: data["licensePlate"].stringValue,
                        latestCheck: data["latestCheck"].stringValue,
                        driverFirstname: data["driverFirstname"].stringValue,
                        driverLastname: data["driverLastname"].stringValue,
                        mobileNumber: data["mobileNumber"].stringValue,
                        jobSitesName: data["jobSitesName"].stringValue,
                        fleetName: data["fleetName"].stringValue,
                        carImage: data["carImage"].stringValue,
                        carStatus: data["carStatus"].bool!,
                        carStructures: carStructures!,
                        carPolicies: carPolicies!
                    )

                    self.carDetail = car
                    self.initView()
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
    
    
    func initView(){
        
        self.carDetailLabel.text = "car_detail".localized
        self.name.text = "name".localized
        self.phone.text = "phone".localized
        self.mile.text = "mile".localized
        self.jobSites.text = "job_sites".localized
        self.latestCheck.text = "latest_check".localized
        self.carStatus.text = "car_status".localized
        self.nextBTN.setTitle("next".localized, for: .normal)
        
        setImageFromUrl(ImageURL: carDetail!.carImage)
        
        self.nameLabel.text = carDetail?.driverFirstname
        self.phoneLabel.text = carDetail?.mobileNumber
        self.mileLabel.text = "\(carDetail!.carMile)"
        self.jobSitesLabel.text = carDetail?.jobSitesName
        self.latestCheckLabel.text = carDetail?.mobileNumber
        
        if carDetail!.carStatus {
            self.carStatusView.backgroundColor = UIColor.green
            self.carStatusLabel.text = "active".localized
        }else{
            self.carStatusView.backgroundColor = UIColor.red
            self.carStatusLabel.text = "not_active".localized
        }
    }
    
    func setImageFromUrl(ImageURL :String) {
       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.carImage.image = UIImage(data: data)
             }
          }
       }).resume()
    }
    
    func createDialogCarStatus(data: Car, completion:@escaping (Bool) -> Void){
        let customDialog  = DialogCarStatusVC.createDialog()
        
        customDialog.carData = data
        customDialog.carPoliciesId = self.carPoliciesId
        
        customDialog.saveDelegate = {
            customDialog.dismiss(animated: true) {
                completion(true)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
}

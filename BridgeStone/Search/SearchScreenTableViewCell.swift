//
//  SearchTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tireImage: UIImageView!
    @IBOutlet weak var carStatusView: ViewRound!
    @IBOutlet weak var carStatusLabel: UILabel!
    @IBOutlet weak var tireStatusView: ViewRound!
    
    @IBOutlet weak var tireStatusLabel: UILabel!
    @IBOutlet weak var tireSerialNumberLabel: UILabel!
    
    @IBOutlet weak var jobsiteLabel: UILabel!
    @IBOutlet weak var licensePlatelabel: UILabel!
    @IBOutlet weak var actionTimelabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initViewTire(tire: Tire){
    
        setImageFromUrl(ImageURL: tire.image)
        self.carStatusView.isHidden = true
            
        self.tireStatusView.isHidden = false
        self.jobsiteLabel.isHidden = true
        
        if tire.tireStatus.nameEN == "wait retread" {
            self.tireStatusView.backgroundColor = UIColor(hexString: "#ffab00")
        }else if tire.tireStatus.nameEN == "in stock" {
            self.tireStatusView.backgroundColor = UIColor(hexString: "#2e7d32")
        }else if tire.tireStatus.nameEN == "waste tires" {
            self.tireStatusView.backgroundColor = UIColor(hexString: "#d50000")
        }else if tire.tireStatus.nameEN == "in car" {
            self.tireStatusView.backgroundColor = UIColor(hexString: "#2962ff")
        }
        
        self.tireStatusLabel.text = tire.tireStatus.nameEN
        self.tireSerialNumberLabel.text = tire.tireSerialNumber
        self.licensePlatelabel.text = "license_plate".localized + " \(tire.licensePlate)"
        self.actionTimelabel.text = "latest_update".localized + " \(tire.actionTime)"
    }
    
    func initViewCar(car: Car){
        
        setImageFromUrl(ImageURL: car.carStructures.image)
        
        self.carStatusView.isHidden = false
        if car.carStatus {
            self.carStatusView.backgroundColor = .green
            self.carStatusLabel.text = "active".localized
        }else{
            self.carStatusView.backgroundColor = .red
            self.carStatusLabel.text = "not_active".localized
        }
        
        self.tireStatusView.isHidden = false
        self.jobsiteLabel.isHidden = true
        self.tireStatusView.backgroundColor = wheelQTYColor(wheelQTY: car.carStructures.wheelQTY)
        self.tireStatusLabel.text = "\(car.carStructures.wheelQTY) " + "wheel".localized
        self.tireSerialNumberLabel.text = "license_plate".localized + " \(car.licensePlate)"
        self.licensePlatelabel.text = car.fleetName
        self.actionTimelabel.text = "latest_update".localized + " \(car.latestCheck)"
    }
    
    func initViewJobsites(jobsites: Jobsites){
        
//        setImageFromUrl(ImageURL: jobsites)
        self.carStatusView.isHidden = true
        self.tireStatusView.isHidden = true
        self.jobsiteLabel.isHidden = false
        self.jobsiteLabel.text = jobsites.jobsiteName
        self.tireSerialNumberLabel.text = ""
        self.licensePlatelabel.text = "total_vehicles".localized + " \(jobsites.totalVehicles) " + "vehicles".localized
        self.actionTimelabel.text = "latest_update".localized + " \(jobsites.updated)"
    }
    
    func setImageFromUrl(ImageURL :String) {
       URLSession.shared.dataTask( with: NSURL(string:ImageURL)! as URL, completionHandler: {
          (data, response, error) -> Void in
          DispatchQueue.main.async {
             if let data = data {
                self.tireImage.image = UIImage(data: data)
             }
          }
       }).resume()
    }
    
    func wheelQTYColor(wheelQTY: Int) -> UIColor{
        switch wheelQTY {
        case 2:
            return UIColor(hexString: "#c62828")
        case 4:
            return UIColor(hexString: "#ad1457")
        case 6:
            return UIColor(hexString: "#6a1b9a")
        case 8:
            return UIColor(hexString: "#4527a0")
        case 10:
            return UIColor(hexString: "#283593")
        case 12:
            return UIColor(hexString: "#1565c0")
        case 14:
            return UIColor(hexString: "#0277bd")
        case 16:
            return UIColor(hexString: "#00838f")
        case 18:
            return UIColor(hexString: "#00695c")
        case 20:
            return UIColor(hexString: "#2e7d32")
        case 24:
            return UIColor(hexString: "#558b2f")
        case 28:
            return UIColor(hexString: "#f9a825")
        case 32:
            return UIColor(hexString: "#ef6c00")
        case 48:
            return UIColor(hexString: "#d84315")
        default:
            return UIColor()
        }
    }
}

extension UIColor{
    func getHalfPieColors() -> [UIColor]{
        
        return [UIColor(hexString: "#FF6955")]
            + [UIColor(hexString: "#E6E6E6")]
    }
    convenience init(hexString: String) {
        // Trim leading '#' if needed
        var cleanedHexString = hexString
        if hexString.hasPrefix("#") {
            cleanedHexString = String(hexString.dropFirst()) // Swift 2
        }
        
        // String -> UInt32
        var rgbValue: UInt32 = 0
        Scanner(string: cleanedHexString).scanHexInt32(&rgbValue)
        
        // UInt32 -> R,G,B
        let red = CGFloat((rgbValue >> 16) & 0xff) / 255.0
        let green = CGFloat((rgbValue >> 08) & 0xff) / 255.0
        let blue = CGFloat((rgbValue >> 00) & 0xff) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

//
//  RegisterCarTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 17/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class RegisterCarTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var licensePlateTextField: placeHolderTextField!
    @IBOutlet weak var driverNameLabel: UILabel!
    @IBOutlet weak var driverNameTextField: placeHolderTextField!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var phoneNumberTextField: placeHolderTextField!
    @IBOutlet weak var jobSiteLabel: UILabel!
    @IBOutlet weak var jobSiteTextField: placeHolderTextField!
    @IBOutlet weak var carFrameLabel: UILabel!
    @IBOutlet weak var carFrameTextField: placeHolderTextField!
    @IBOutlet weak var standardMaintenanceLabel: UILabel!
    @IBOutlet weak var standardMaintenanceTextField: placeHolderTextField!
    @IBOutlet weak var standardMaintenanceBTN: UIButton!
    @IBOutlet weak var registerBTN: ButtonRound!
    @IBOutlet weak var registerNext: ButtonRound!
    
    
    
    var didTapNewTireDelegate:( ()-> Void ) = {}
    var didTapCastTireDelegate:( ()-> Void ) = {}
    var didTapSaveDelegate:( ()-> Void ) = {}
    var didTapCastTireNextDelegate:( ()-> Void ) = {}
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        self.didTapSaveDelegate()
    }
    
    @IBAction func didTapCastTireNext(_ sender: Any) {
        self.didTapCastTireNextDelegate()
    }
    
}

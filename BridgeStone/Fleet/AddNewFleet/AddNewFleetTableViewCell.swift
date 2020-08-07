//
//  AddNewFleetTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 27/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class AddNewFleetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dataTextField: UITextField!
    @IBOutlet weak var errorTextFieldImage: UIImageView!
    @IBOutlet weak var saveBTN: ButtonRound!
    
    var didTapSaveBTN:( ()-> Void ) = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configView(index: Int){
        
        switch index {
        case 0 :
            self.nameLabel.text = "fleet_name".localized
            self.dataTextField.placeholder = "fleet_name_place".localized
            self.dataTextField.tag = 0
            break
        case 1:
            self.nameLabel.text = "address".localized
            self.dataTextField.placeholder = "address_place".localized
            self.dataTextField.tag = 1
            break
        case 2 :
            self.nameLabel.text = "district".localized
            self.dataTextField.placeholder = "address_place".localized
            self.dataTextField.tag = 2
            break
        case 3:
            self.nameLabel.text = "province".localized
            self.dataTextField.placeholder = "province_place".localized
            self.dataTextField.tag = 3
            break
        case 4 :
            self.nameLabel.text = "email".localized
            self.dataTextField.placeholder = "email_place".localized
            self.dataTextField.tag = 4
            break
        case 5 :
            self.saveBTN.setTitle("save".localized, for: .normal)
            break
        default :
            break
        }
    }
    
    func validateTextField(){
        if self.dataTextField.text!.isEmpty {
            self.errorTextFieldImage.isHidden = false
        }else{
            self.errorTextFieldImage.isHidden = true
        }
        
//        if self.dataTextField.tag == 0 {
//                    self.dataTextField.becomeFirstResponder()
//                }
    }
    
    @IBAction func saveClick(_ sender: Any) {
        self.didTapSaveBTN()
    }
}

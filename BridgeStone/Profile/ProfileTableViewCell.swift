//
//  ProfileTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 1/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageImage: UIImageView!
    @IBOutlet weak var saveBTN: ButtonRound!
    
    
    var didTapSaveBTN:( ()-> Void ) = {}
    var didTapLanguageBTN:( ()-> Void ) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func languageClick(_ sender: Any) {
        self.didTapLanguageBTN()
    }
    
    @IBAction func saveClick(_ sender: Any) {
        self.didTapSaveBTN()
    }
    
    func initView(data: Profile){
        self.nameLabel.text = "\(data.firstName) \(data.lastName)"
        self.phoneLabel.text = data.mobileNumber
    }
}

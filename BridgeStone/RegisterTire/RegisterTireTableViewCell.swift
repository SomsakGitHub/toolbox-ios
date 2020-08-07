//
//  RegisterTireTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 12/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class RegisterTireTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newTireBTNImage: UIImageView!
    @IBOutlet weak var newTiresLabel: UILabel!
    
    @IBOutlet weak var tireCastBTNImage: UIImageView!
    @IBOutlet weak var castTiresLabel: UILabel!
    
    @IBOutlet weak var numberTiresLabel: UILabel!
    @IBOutlet weak var numberTireTextField: placeHolderTextField!
    @IBOutlet weak var pastTemplatesLabel: UILabel!
    @IBOutlet weak var designTireTextField: placeHolderTextField!
    @IBOutlet weak var jobSiteLabel: UILabel!
    @IBOutlet weak var jobSiteTextField: placeHolderTextField!
    @IBOutlet weak var productionDateLabel: UILabel!
    @IBOutlet weak var productionDateTextField: placeHolderTextField!
    @IBOutlet weak var productionYearTextField: placeHolderTextField!
    
    @IBOutlet weak var castTemplateLabel: UILabel!
    @IBOutlet weak var designTireAfterTextfield: placeHolderTextField!
    
    @IBOutlet weak var castNumberTireLabel: UILabel!
    @IBOutlet weak var numberTireAfterTextField: placeHolderTextField!
    
    @IBOutlet weak var detailTiresLabel: UILabel!
    
    @IBOutlet weak var registerBTN: ButtonRound!
    @IBOutlet weak var registerNextBTN: ButtonRound!
    
    var didTapNewTireDelegate:( ()-> Void ) = {}
    var didTapCastTireDelegate:( ()-> Void ) = {}
    var didTapSaveDelegate:( ()-> Void ) = {}
    var didTapSaveTrieNextDelegate:( ()-> Void ) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapNewTire(_ sender: Any) {
        self.didTapNewTireDelegate()
    }
    
    @IBAction func didTapCastTire(_ sender: Any) {
        self.didTapCastTireDelegate()
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        self.didTapSaveDelegate()
    }
    
    @IBAction func didTapSaveTrieNext(_ sender: Any) {
        self.didTapSaveTrieNextDelegate()
    }
    
    
    
}

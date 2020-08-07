//
//  RegisterTireTemplateView.swift
//  BridgeStone
//
//  Created by somsak on 21/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class RegisterTireTemplateView: UIView {
    
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var sizeTireTextField: placeHolderTextField!
    @IBOutlet weak var brandsLabel: UILabel!
    @IBOutlet weak var brandTireTextField: placeHolderTextField!
    @IBOutlet weak var patternsLabel: UILabel!
    @IBOutlet weak var patternTireTextField: placeHolderTextField!
    @IBOutlet weak var createTiresTemplateBTN: ButtonRound!
    
    func initView(){
        self.sizeLabel.text = "size".localized
        self.sizeTireTextField.placeholder = "tires_size".localized
        self.brandsLabel.text = "brands".localized
        self.brandTireTextField.placeholder = "tires_brands".localized
        self.patternsLabel.text = "patterns".localized
        self.patternTireTextField.placeholder = "tires_patterns".localized
        self.createTiresTemplateBTN.setTitle("create_tires_template".localized, for: .normal)
    }
}



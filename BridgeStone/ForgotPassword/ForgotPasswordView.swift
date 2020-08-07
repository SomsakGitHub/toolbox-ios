//
//  ForgotPasswordView.swift
//  BridgeStone
//
//  Created by somsak on 23/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class ForgotPasswordView: UIView {
    
    @IBOutlet weak var ForgotPasswordLabel: UILabel!
    @IBOutlet weak var ForgotPasswordTextField: UITextField!
    @IBOutlet weak var errorEmailTextFieldImage: UIImageView!
    @IBOutlet weak var ForgotPasswordBTN: ButtonRound!
    @IBOutlet weak var errorLoginView: ViewRound!
    @IBOutlet weak var errorLoginLabel: UILabel!
    
    
    func initView(){
        self.ForgotPasswordLabel.text = "forgot_password".localized
        self.ForgotPasswordTextField.placeholder = "your_email".localized
        self.ForgotPasswordBTN.setTitle("confirm_email".localized, for: .normal)
    }

}

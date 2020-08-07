//
//  ViewController.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 3/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var errorEmailTextFieldImage: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorPasswordTextFieldImage: UIImageView!
    @IBOutlet var forgotPasswordBTN: UIButton!
    @IBOutlet var loginBTN: ButtonRound!
    @IBOutlet weak var errorLoginView: ViewRound!
    
    private var viewModel: LoginViewModel!
    var didFinishLoginTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = LoginViewModel(view: self)
        self.dismissKeyboardOnDidTabView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
        self.initView()
    }
    
    @IBAction func didTapLogin_Click(_ sender: Any) {
        
//        let usernameTrimText = self.emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        let passwordTrimText = self.passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        self.viewModel.fetchLogin(
            email: self.emailTextField.text!,
            password: self.passwordTextField.text!
        )
    }
    
    func initView(){
        
        let attrsForgotPassword = [
            NSAttributedString.Key.font : UIFont(name:"Roboto-Regular" , size: 15) as Any,
            NSAttributedString.Key.foregroundColor : UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 0.67),
            NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]
        let attrsStrForgotPassword = NSMutableAttributedString(string: "")
        let buttonTitleStrForgotPassword = NSMutableAttributedString(string: "forgot_password".localized, attributes:attrsForgotPassword)
        attrsStrForgotPassword.append(buttonTitleStrForgotPassword)
        
        self.loginLabel.text = "login".localized
        self.emailTextField.placeholder = "username".localized
        self.passwordTextField.placeholder = "password".localized
        self.forgotPasswordBTN.setAttributedTitle(attrsStrForgotPassword, for: .normal)
        self.loginBTN.setTitle("login".localized, for: .normal)
        
    }
    
    func validateTextField(status: Bool){
        if emailTextField.text!.isEmpty{
            self.errorEmailTextFieldImage.isHidden = false
        }else{
            self.errorEmailTextFieldImage.isHidden = true
        }
        
        if passwordTextField.text!.isEmpty{
            self.errorPasswordTextFieldImage.isHidden = false
        }else{
            self.errorPasswordTextFieldImage.isHidden = true
        }
        
        if status {
            self.errorLoginView.isHidden = false
            var time = 0
            
            self.didFinishLoginTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                if time >= 3 {
                    self.errorLoginView.isHidden = true
                    timer.invalidate()
                }else{
                    time += 1
                }
            }
        }else{
            self.errorLoginView.isHidden = true
        }
    }
    
    func dismissKeyboardOnDidTabView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: LoginViewModelDelegate {
    func didFinishFetchingLogin(_ status: statusWebService) {
        switch status {
        case .success :
            performSegue(withIdentifier: "goToFleetScreen", sender: self)
            break
        case .noContent, .badRequest, .unAuthorized:
            validateTextField(status: true)
            break
        case .internalServerError:
            break
        default:
            
            break
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField == self.emailTextField {
            self.errorEmailTextFieldImage.isHidden = true
        }else {
            self.errorPasswordTextFieldImage.isHidden = true
        }
    }
}


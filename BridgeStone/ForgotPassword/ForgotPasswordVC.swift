//
//  ForgotPasswordVC.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 19/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet var forgotPasswordView: ForgotPasswordView!
    
    private var viewModel: ForgotPasswordModel!
    
    var didFinishEmailTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.isHidden = true
        self.viewModel = ForgotPasswordModel(view: self)
        self.dismissKeyboardOnDidTabView()
        self.forgotPasswordView.initView()
    }
    
    @IBAction func confirmEmailClick(_ sender: Any) {
        self.forgotPasswordView.ForgotPasswordBTN.isEnabled = false
        
        self.viewModel.fetchForgotPassword(
            email: self.forgotPasswordView.ForgotPasswordTextField.text!
        )
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func validateTextField(status: Bool){
        if self.forgotPasswordView.ForgotPasswordTextField.text!.isEmpty{
            self.forgotPasswordView.errorEmailTextFieldImage.isHidden = false
        }else{
            self.forgotPasswordView.errorEmailTextFieldImage.isHidden = true
        }
        
        if status {
            self.forgotPasswordView.errorLoginView.isHidden = false
            var time = 0
            
            self.didFinishEmailTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                if time >= 3 {
                    self.forgotPasswordView.errorLoginView.isHidden = true
                    timer.invalidate()
                }else{
                    time += 1
                }
            }
        }else{
            self.forgotPasswordView.errorLoginView.isHidden = true
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

extension ForgotPasswordVC: ForgotPasswordModelDelegate {
    func didFinishRefreshToken() {
        self.viewModel.fetchForgotPassword(
            email: self.forgotPasswordView.ForgotPasswordTextField.text!
        )
    }
    
    func didFinishFetchingForgotPassword(_ status: statusWebService) {
        switch status {
        case .success :
            
            self.forgotPasswordView.errorLoginLabel.text = "email_has_been_confirmed".localized
            self.forgotPasswordView.errorLoginView.isHidden = false
            var time = 0
            
            self.didFinishEmailTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
                if time >= 3 {
                    self.forgotPasswordView.errorLoginView.isHidden = true
                    timer.invalidate()
                    self.navigationController?.popViewController(animated: true)
                }else{
                    time += 1
                }
            }
            break
        case .noContent, .badRequest, .unAuthorized:
            validateTextField(status: true)
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

extension ForgotPasswordVC: UITextFieldDelegate {
    
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
        self.forgotPasswordView.errorEmailTextFieldImage.isHidden = true
    }
}


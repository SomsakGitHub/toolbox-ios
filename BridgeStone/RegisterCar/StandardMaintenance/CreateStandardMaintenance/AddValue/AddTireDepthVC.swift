//
//  AddTireDepthVC.swift
//  BridgeStone
//
//  Created by somsak on 22/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class AddTireDepthVC: UIViewController {
    
    @IBOutlet weak var scoreView: UIScrollView!
    @IBOutlet weak var tireDepthLabel: UILabel!
    @IBOutlet weak var warningTextField: placeHolderTextField!
    @IBOutlet weak var criticalTextField: placeHolderTextField!
    @IBOutlet weak var saveBTN: ButtonRound!
    
    var didTapSave : ((Bool, String, String) -> Void) = {_,_,_ in }
    
    var isKeyboard = false
    var text = ""
    var warning = ""
    var critical = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismissKeyboardOnDidTabView()
        registerForKeyboardWillShowNotification(scoreView)
        registerForKeyboardWillHideNotification(scoreView)

        self.tireDepthLabel.text = "axles".localized + " \(text)" + " (" + "tire_depth".localized + ")"
        self.warningTextField.placeholder = "warning_depth".localized
        self.criticalTextField.placeholder = "critical_depth".localized
        self.warningTextField.text = self.warning
        self.criticalTextField.text = self.critical
        self.saveBTN.setTitle("save".localized, for: .normal)
    }
    
    func registerForKeyboardWillShowNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {

        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil, using: { notification -> Void in

            let userInfo = notification.userInfo!

            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size

            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top,

                                             left: scrollView.contentInset.left,

                                             bottom: keyboardSize.height,

                                             right: scrollView.contentInset.right)

            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }

    func registerForKeyboardWillHideNotification(_ scrollView: UIScrollView, usingBlock block: ((CGSize?) -> Void)? = nil) {

        _ = NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil, using: { notification -> Void in

            let userInfo = notification.userInfo!

            let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue.size

            let contentInsets = UIEdgeInsets(top: scrollView.contentInset.top,

                                             left: scrollView.contentInset.left,

                                             bottom: 0,

                                             right: scrollView.contentInset.right)

            scrollView.setContentInsetAndScrollIndicatorInsets(contentInsets)
            block?(keyboardSize)
        })
    }
    
    @IBAction func saveClick(_ sender: Any) {
        validateTextField()
    }
    
    func validateTextField(){
        if self.warningTextField.text!.isEmpty || self.criticalTextField.text!.isEmpty {
            
        }else{
            self.didTapSave(
                true,
                self.warningTextField.text!,
                self.criticalTextField.text!
            )
        }
    }
    
    static func createDialog() -> AddTireDepthVC {
        
        let customDialog: AddTireDepthVC = UIStoryboard(name: "RegisterCar", bundle: nil)
            .instantiateViewController(withIdentifier: "addTireDepthVC") as! AddTireDepthVC
        customDialog.setDialog()
        
        return customDialog
    }
    
    func setDialog() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    func dismissKeyboardOnDidTabView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        if self.isKeyboard {
            view.endEditing(true)
        }else{
            self.didTapSave(false, "", "")
        }
    }
}

extension AddTireDepthVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.isKeyboard = true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isKeyboard = false
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {

    }
}

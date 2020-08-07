//
//  AddTirePressureVC.swift
//  BridgeStone
//
//  Created by somsak on 22/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class AddTirePressureVC: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tirePressureLabel: UILabel!
    @IBOutlet weak var standardTextField: placeHolderTextField!
    @IBOutlet weak var warningTextField: placeHolderTextField!
    @IBOutlet weak var criticalTextField: placeHolderTextField!
    @IBOutlet weak var saveBTN: ButtonRound!
    
    var didTapSave : ((Bool, String, String, String) -> Void) = {_,_,_,_  in }
    
    var isKeyboard = false
    var text = ""
    var standard = ""
    var warning = ""
    var critical = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerForKeyboardWillShowNotification(scrollView)
        registerForKeyboardWillHideNotification(scrollView)
        self.dismissKeyboardOnDidTabView()
        
        self.tirePressureLabel.text = "axles".localized + " \(text)" + " (" + "tire_pressure".localized + ")"
        self.standardTextField.placeholder = "standard_tire_pressure".localized
        self.warningTextField.placeholder = "warning_depth".localized
        self.criticalTextField.placeholder = "critical_depth".localized
        self.standardTextField.text = self.standard
        self.warningTextField.text = self.warning
        self.criticalTextField.text = self.critical
        self.saveBTN.setTitle("save".localized, for: .normal)
    }
    
    @IBAction func saveClick(_ sender: Any) {
        validateTextField()
    }
    
    func validateTextField(){
        if self.standardTextField.text!.isEmpty || self.warningTextField.text!.isEmpty || self.criticalTextField.text!.isEmpty {
            
        }else{
            self.didTapSave(
                true,
                self.standardTextField.text!,
                self.warningTextField.text!,
                self.criticalTextField.text!
            )
        }
    }
    
    static func createDialog() -> AddTirePressureVC {
        
        let customDialog: AddTirePressureVC = UIStoryboard(name: "RegisterCar", bundle: nil)
            .instantiateViewController(withIdentifier: "addTirePressureVC") as! AddTirePressureVC
        customDialog.setDialog()
        
        return customDialog
    }
    
    func setDialog() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
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
    
    func dismissKeyboardOnDidTabView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        if self.isKeyboard {
            view.endEditing(true)
        }else{
            self.didTapSave(false, "", "", "")
        }
    }
}

extension AddTirePressureVC: UITextFieldDelegate {
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

//
//  AddNewFleetVC.swift
//  BridgeStone
//
//  Created by somsak on 26/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class AddNewFleetVC: UIViewController {
    
    @IBOutlet weak var addNewFleetLabel: UILabel!
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var errorSaveView: ViewRound!
    @IBOutlet weak var errorSaveLabel: UILabel!
    
    private var viewModel: AddNewFleetModel!
    var addNewFleetVCDelegate: AddNewFleetVCDelegate?
    
    var didFinishSaveTimer: Timer?
    var indexPathRowSection = IndexPath()
    var allCellsText = [String]()
    
    var isSaveClick = false
    var isTextFieldDidChange = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = AddNewFleetModel(view: self)
        self.dismissKeyboardOnDidTabView()
        
        registerForKeyboardWillShowNotification(dataTable)
        registerForKeyboardWillHideNotification(dataTable)
        
        for _ in 1...5 {
            self.allCellsText.append("")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.addNewFleetLabel.text = "add_new_fleet".localized
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func save(){
        self.isSaveClick = true
        self.dataTable.reloadData()
        
        for i in 0...4 {
            switch self.allCellsText[i].isEmpty {
            case self.allCellsText[0].isEmpty :
                validateSaveView(text: "specify_name".localized)
                break
            case self.allCellsText[1].isEmpty:
                validateSaveView(text: "specify_address".localized)
                break
            case self.allCellsText[2].isEmpty :
                validateSaveView(text: "specify_district".localized)
                break
            case self.allCellsText[3].isEmpty:
                validateSaveView(text: "specify_province".localized)
                break
            case self.allCellsText[4].isEmpty :
                validateSaveView(text: "specify_email".localized)
                break
            default :
                break
            }
        }
        
        let isTextfieldEmpty = self.allCellsText.contains { (text) -> Bool in
            return text.isEmpty
        }
        
        if !isTextfieldEmpty {
            self.viewModel.saveFleet(data: allCellsText)
        }
    }
    
    func validateSaveView(text: String){
        self.errorSaveLabel.text = text
        
        self.errorSaveView.isHidden = false
        var time = 0
        
        self.didFinishSaveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if time >= 3 {
                self.errorSaveView.isHidden = true
                timer.invalidate()
            }else{
                time += 1
            }
        }
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
        view.endEditing(true)
    }
}

//MARK: Extension datasource and delegate.
extension AddNewFleetVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = AddNewFleetTableViewCell()
        
        if indexPath.row == 5 {
            let saveTableViewCell = tableView.dequeueReusableCell(withIdentifier: "saveTableViewCell", for: indexPath) as! AddNewFleetTableViewCell
            
            saveTableViewCell.configView(index: 5)
            
            saveTableViewCell.didTapSaveBTN = {
                self.save()
            }
            
            cell = saveTableViewCell
        }else{
            let addNewFleetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "addNewFleetTableViewCell", for: indexPath) as! AddNewFleetTableViewCell
            
            addNewFleetTableViewCell.configView(index: indexPath.row)
            
            cell = addNewFleetTableViewCell
            
            if isSaveClick {
                addNewFleetTableViewCell.validateTextField()
            }
        }
        
        return cell
    }
}

extension AddNewFleetVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.allCellsText[textField.tag] = textField.text!
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if textField.text!.count == 1 {
            if let AddNewFleetTableViewCell = dataTable.cellForRow(at: IndexPath(row: textField.tag, section: 0)) as? AddNewFleetTableViewCell {

                AddNewFleetTableViewCell.errorTextFieldImage.isHidden = true
            }
        }
    }
}

extension AddNewFleetVC: AddNewFleetDelegate {
    
    func didFinishRefreshToken() {
        self.viewModel.saveFleet(data: allCellsText)
    }
    
    func didFinishSaveFleet(_ status: statusWebService) {
        self.addNewFleetVCDelegate?.addNewFleet(status: true)
        self.navigationController?.popViewController(animated: true)
    }
}

extension UIScrollView {

    func setContentInsetAndScrollIndicatorInsets(_ edgeInsets: UIEdgeInsets) {

        self.contentInset = edgeInsets

        self.scrollIndicatorInsets = edgeInsets

    }
}


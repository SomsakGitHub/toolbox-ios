//
//  StandardMaintenanceVC.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class StandardMaintenanceVC: UIViewController {
    
    @IBOutlet weak var standardMaintenanceLabel: UILabel!
    @IBOutlet weak var searchTextField: placeHolderTextField!
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: StandardMaintenanceModel!
    var policies: [Policies] = []
    var policiesSearch: [Policies] = []
    var standardMaintenanceVCDelegate: StandardMaintenanceVCDelegate?
    var isSearch = false
    var params: [String] = ["", "", ""]
    let axlesQTYCarStructure: String = UserDefaults.standard.string(forKey: "axlesQTYCarStructure")!
    let fleetID: String = UserDefaults.standard.string(forKey: "fleetID")!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = StandardMaintenanceModel(view: self)
        self.params[0] = axlesQTYCarStructure
        self.params[1] = fleetID
        self.viewModel.fetchPolicies(param: params)
        self.standardMaintenanceLabel.text = "select_standard_maintenance".localized
        self.searchTextField.placeholder = "search".localized
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: Extension datasource and delegate.
extension StandardMaintenanceVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if self.isSearch {
            return self.policiesSearch.count
        }else{
            return self.policies.count
        }

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let standardMaintenanceTableViewCell = tableView.dequeueReusableCell(withIdentifier: "standardMaintenanceTableViewCell", for: indexPath) as! StandardMaintenanceTableViewCell

        if !self.policies.isEmpty  {

            if self.isSearch {
                standardMaintenanceTableViewCell.initView(
                    policies : self.policiesSearch[indexPath.row]
                )
            }else{
                standardMaintenanceTableViewCell.initView(
                    policies : self.policies[indexPath.row]
                )
            }
        }

        return standardMaintenanceTableViewCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if self.isSearch {
            self.standardMaintenanceVCDelegate?.selectStandardMaintenance(data: self.policiesSearch[indexPath.row])
        }else{
            self.standardMaintenanceVCDelegate?.selectStandardMaintenance(data: self.policies[indexPath.row])
        }
//
        self.navigationController?.popViewController(animated: true)
    }
}

extension StandardMaintenanceVC: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {

        if textField.text!.count > 0 {
            self.params[2] = textField.text!
            self.viewModel.fetchPolicies(param: self.params)
        }
    }
}

extension StandardMaintenanceVC: StandardMaintenanceModelDelegate {
    func didFinishRefreshToken() {
        self.viewModel.fetchPolicies(param: self.params)
    }
    
    func didFinishFetchingStandardMaintenance(_ status: statusWebService, policies: [Policies]) {
        switch status {
        case .success :
            self.policies = policies
            self.tableView.reloadData()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}


//
//  DialogAddJobSiteVC.swift
//  BridgeStone
//
//  Created by somsak on 20/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class DialogAddJobSiteVC: UIViewController {
    
    @IBOutlet weak var jobSiteLabel: UILabel!
    @IBOutlet weak var jobSiteName: placeHolderTextField!
    @IBOutlet weak var cancelBTN: ButtonRound!
    @IBOutlet weak var saveBTN: ButtonRound!
    
    private var viewModel: DialogAddJobSiteModel!
    
    var didTapCancel : (() -> Void) = {}
    var didTapSave : (() -> Void) = {}

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        self.viewModel = DialogAddJobSiteModel(view: self)
        self.jobSiteLabel.text = "job_site_name".localized
        self.jobSiteName.placeholder = "job_site_your_name".localized
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        didTapCancel()
    }
    
    @IBAction func saveClick(_ sender: Any) {
        self.viewModel.addJobSite(jobSiteName: self.jobSiteName.text!)
    }
    
    func initView(){
        cancelBTN.setTitle("Cancel".localized, for: .normal)
        saveBTN.setTitle("Confirm".localized, for: .normal)
    }
    
    static func createDialog() -> DialogAddJobSiteVC {
        
        let customDialog: DialogAddJobSiteVC = UIStoryboard(name: "RegisterTire", bundle: nil)
            .instantiateViewController(withIdentifier: "dialogAddJobSite") as! DialogAddJobSiteVC
        customDialog.setDialog()
        
        return customDialog
    }
    
    func setDialog() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
}

extension DialogAddJobSiteVC: UITextFieldDelegate {
    
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

    }
}

extension DialogAddJobSiteVC: DialogAddJobSiteModelDelegate {
    func didFinishRefreshToken() {
        self.viewModel.addJobSite(jobSiteName: self.jobSiteName.text!)
    }
    
    func didFinishAddJobSite(_ status: statusWebService) {
        switch status {
        case .success :
            
            self.didTapSave()
            
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

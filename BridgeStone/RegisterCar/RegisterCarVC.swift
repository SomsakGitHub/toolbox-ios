//
//  RegisterCarVC.swift
//  BridgeStone
//
//  Created by somsak on 17/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class RegisterCarVC: UIViewController, SelectJobSiteVCDelegate, CarStructureVCDelegate, StandardMaintenanceVCDelegate{
    
    @IBOutlet weak var registerCarLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: RegisterCarModel!
    @IBOutlet weak var errorSaveView: ViewRound!
    @IBOutlet weak var errorSaveLabel: UILabel!
    
    var didFinishSaveTimer: Timer?
    var registerCarData = [String]()
    var isSave = false
    var jobsitesName = ""
    var carStructureName = ""
    var standardMaintenance = ""
    var getLicensePlateOnTextField:(() -> (String))!
    var getDriverNameOnTextField:(() -> (String))!
    var getPhoneNumberOnTextField:(() -> (String))!
    var isRegister = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = RegisterCarModel(view: self)
        self.dismissKeyboardOnDidTabView()
        
        registerForKeyboardWillShowNotification(self.tableView)
        registerForKeyboardWillHideNotification(self.tableView)
        
        for _ in 1...6 {
            self.registerCarData.append("")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.registerCarLabel.text = "register_car".localized
        
        let isCreateStandardMaintenanceSuccess = UserDefaults.standard.bool(forKey: "isCreateStandardMaintenanceSuccess")
        
        if isCreateStandardMaintenanceSuccess {
            self.viewModel.fetchPolicies()
        }
        
        let isSaveJobSite = UserDefaults.standard.bool(forKey: "isSaveJobSite")
        
        print("isSaveJobSite", isSaveJobSite)
        
        if isSaveJobSite {
            self.viewModel.fetchJobSite()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    @IBAction func backClick(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isCreateStandardMaintenanceSuccess")
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let jobSiteVC = segue.destination as? JobSiteVC {
            //            btsViewController.station = self.stations
            jobSiteVC.selectJobSiteVCDelegate = self
        }else if let carStructureVC = segue.destination as? CarStructureVC {
            //            btsViewController.station = self.stations
            carStructureVC.carStructureVCDelegate = self
        }else if let standardMaintenanceVC = segue.destination as? StandardMaintenanceVC {
            //            btsViewController.station = self.stations
            standardMaintenanceVC.standardMaintenanceVCDelegate = self
        }
    }
    
    func selectJobSite(data: Jobsites) {
        self.registerCarData[3] = String(data.id)
        self.jobsitesName = data.jobsiteName
        self.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .automatic)
    }
    
    func selectcarStructure(data: CarStructure) {
        self.registerCarData[4] = String(data.id)
        UserDefaults.standard.set(data.name, forKey: "carStructureName")
        self.carStructureName = data.name
        self.registerCarData[5] = ""
        self.standardMaintenance = ""
        self.tableView.reloadRows(at: [IndexPath.init(row: 4, section: 0)], with: .automatic)
        self.tableView.reloadRows(at: [IndexPath.init(row: 5, section: 0)], with: .automatic)
    }
    
    func selectStandardMaintenance(data: Policies) {
        self.registerCarData[5] = String(data.id)
        self.standardMaintenance = data.name
        self.tableView.reloadRows(at: [IndexPath.init(row: 5, section: 0)], with: .automatic)
    }
    
    func validateTextField(isRegister: Bool){
        
        if self.registerCarData[0].isEmpty {
            validateSaveView(text: "specify_license_plate".localized)
        }else if self.registerCarData[1].isEmpty {
            validateSaveView(text: "specify_driver_name".localized)
        }else if self.registerCarData[2].isEmpty {
            validateSaveView(text: "specify_phone_number".localized)
        }else if self.registerCarData[3].isEmpty {
            validateSaveView(text: "specify_job_site_car".localized)
        }else if self.registerCarData[4].isEmpty{
            validateSaveView(text: "specify_car_frame".localized)
        }else if self.registerCarData[5].isEmpty{
            validateSaveView(text: "specify_standard_maintenance".localized)
        }
        
        let isTextfieldEmpty = self.registerCarData.contains { (text) -> Bool in
            return text.isEmpty
        }
        
        if !isTextfieldEmpty {
            self.isRegister = isRegister
            self.viewModel.registerCar(data: self.registerCarData, isRegister: self.isRegister)
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
extension RegisterCarVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = RegisterCarTableViewCell()
            
        switch indexPath.row {
        case 0:
            let licensePlate = tableView.dequeueReusableCell(withIdentifier: "licensePlate", for: indexPath) as! RegisterCarTableViewCell
            
            licensePlate.licensePlateLabel.text = "license_plate".localized
            licensePlate.licensePlateTextField.placeholder = "fill_up_license_plate".localized
            
            if self.isSave {
                licensePlate.licensePlateTextField.text = self.registerCarData[0]
            }
            
            self.getLicensePlateOnTextField = {
                return licensePlate.licensePlateTextField.text!
            }
            
            cell = licensePlate
            break
        case 1:
            let driverName = tableView.dequeueReusableCell(withIdentifier: "driverName", for: indexPath) as! RegisterCarTableViewCell
            
            driverName.driverNameLabel.text = "driver_name".localized
            driverName.driverNameTextField.placeholder = "fill_up_driver_name".localized
            
            if self.isSave {
                driverName.driverNameTextField.text = self.registerCarData[1]
            }
            
            self.getDriverNameOnTextField = {
                return driverName.driverNameTextField.text!
            }

            cell = driverName
            break
        case 2:
            let phoneNumber = tableView.dequeueReusableCell(withIdentifier: "phoneNumber", for: indexPath) as! RegisterCarTableViewCell
            
            phoneNumber.phoneNumberLabel.text = "phone_number".localized
            phoneNumber.phoneNumberTextField.placeholder = "fill_up_phone_number".localized
            
            if self.isSave {
                phoneNumber.phoneNumberTextField.text = self.registerCarData[2]
            }
            
            self.getPhoneNumberOnTextField = {
                return phoneNumber.phoneNumberTextField.text!
            }

            cell = phoneNumber
            break
        case 3:
            let jobSite = tableView.dequeueReusableCell(withIdentifier: "jobSite", for: indexPath) as! RegisterCarTableViewCell
            
            jobSite.jobSiteLabel.text = "job_site_car".localized
            jobSite.jobSiteTextField.placeholder = "fill_up_job_site".localized
            
            jobSite.jobSiteTextField.text = self.jobsitesName

            cell = jobSite
            break
        case 4:
            let carFrame = tableView.dequeueReusableCell(withIdentifier: "carFrame", for: indexPath) as! RegisterCarTableViewCell
            
            carFrame.carFrameLabel.text = "car_frame".localized
            carFrame.carFrameTextField.placeholder = "fill_up_car_frame".localized
            
            carFrame.carFrameTextField.text = self.carStructureName

            cell = carFrame
            break
        case 5:
            let standardMaintenance = tableView.dequeueReusableCell(withIdentifier: "standardMaintenance", for: indexPath) as! RegisterCarTableViewCell
            
            standardMaintenance.standardMaintenanceLabel.text = "standard_maintenance".localized
            standardMaintenance.standardMaintenanceTextField.placeholder = "fill_up_standard_maintenance".localized
            
            if self.carStructureName.isEmpty {
                standardMaintenance.standardMaintenanceBTN.isEnabled = false
            }else{
                standardMaintenance.standardMaintenanceBTN.isEnabled = true
            }
            
            standardMaintenance.standardMaintenanceTextField.text = self.standardMaintenance

            cell = standardMaintenance
            
            break
        case 6:
            let save = tableView.dequeueReusableCell(withIdentifier: "save", for: indexPath) as! RegisterCarTableViewCell
            
            save.registerBTN.setTitle("register".localized, for: .normal)
            save.registerNext.setTitle("register_car_next".localized, for: .normal)
            
            save.didTapSaveDelegate = {
                
                self.isSave = true
                
                print(self.registerCarData[0], self.registerCarData[1], self.registerCarData[2], self.registerCarData[3], self.registerCarData[4], self.registerCarData[5])
                
                self.validateTextField(isRegister: true)
            }
            
            save.didTapCastTireNextDelegate = {
                
                self.isSave = true
                
                print(self.registerCarData[0], self.registerCarData[1], self.registerCarData[2], self.registerCarData[3], self.registerCarData[4], self.registerCarData[5])
                
                self.validateTextField(isRegister: false)
            }

            cell = save
            break
        default:
            break
        }
        
        return cell
    }
}

extension RegisterCarVC: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let licensePlate = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? RegisterCarTableViewCell {

            if textField == licensePlate.licensePlateTextField {
                self.registerCarData[0] = licensePlate.licensePlateTextField.text!
            }
        }

        if let driverName = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? RegisterCarTableViewCell {

            if textField == driverName.driverNameTextField {
                self.registerCarData[1] = driverName.driverNameTextField.text!
            }
        }
        
        if let phoneNumber = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? RegisterCarTableViewCell {

            if textField == phoneNumber.phoneNumberTextField {
                self.registerCarData[2] = phoneNumber.phoneNumberTextField.text!
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
    }
}

extension RegisterCarVC: RegisterCarModelDelegate {
    func didFinishRefreshToken(type: registerCarModelEnum) {
        switch type {
        case .fetchJobSite :
            self.viewModel.fetchJobSite()
            break
        case .fetchPolicies:
            self.viewModel.fetchPolicies()
            break
        case .registerCar:
            self.viewModel.registerCar(data: self.registerCarData, isRegister: self.isRegister)
            break
        default :
            break
        }
    }
    
    
    func didFinishRegisterCar(_ status: statusWebService, isRegister: Bool) {
        switch status {
        case .success :
            if isRegister {
                self.performSegue(withIdentifier: "goToRegisterTireSuccess", sender: self)
            }else{
                self.registerCarData[0] = ""
                self.registerCarData[1] = ""
                self.registerCarData[2] = ""
                self.tableView.reloadData()
            }
            
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishFetchingStandardMaintenance(_ status: statusWebService, policies: Policies) {
        switch status {
        case .success :
            
            let carStructureName = UserDefaults.standard.string(forKey: "carStructureName")!
            
            self.carStructureName = carStructureName
            self.tableView.reloadRows(at: [IndexPath.init(row: 4, section: 0)], with: .automatic)
            
            self.standardMaintenance = policies.name
            self.registerCarData[5] = String(policies.id)
            self.tableView.reloadRows(at: [IndexPath.init(row: 5, section: 0)], with: .automatic)
            UserDefaults.standard.set(false, forKey: "isCreateStandardMaintenanceSuccess")
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishFetchingJobSite(_ status: statusWebService, jobsites: Jobsites) {
        switch status {
        case .success :
        
            self.jobsitesName = jobsites.jobsiteName
            self.registerCarData[3] = String(jobsites.id)
            self.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .automatic)
            UserDefaults.standard.set(false, forKey: "isSaveJobSite")
            
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}


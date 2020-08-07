//
//  CreateStandardMaintenanceVC.swift
//  BridgeStone
//
//  Created by somsak on 21/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class CreateStandardMaintenanceVC: UIViewController {
    
    
    @IBOutlet weak var standardMaintenanceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: CreateStandardMaintenanceModel!
    let axlesQTYCarStructureInt : Int = Int(UserDefaults.standard.string(forKey: "axlesQTYCarStructure")!)!
    
    var axles1Data: [String] = ["1", "", "", "", "", ""]
    var axles2Data: [String] = ["2", "", "", "", "", ""]
    var axles3Data: [String] = ["3", "", "", "", "", ""]
    var axles4Data: [String] = ["4", "", "", "", "", ""]
    var axles5Data: [String] = ["5", "", "", "", "", ""]
    var axles6Data: [String] = ["6", "", "", "", "", ""]
    var axles7Data: [String] = ["7", "", "", "", "", ""]
    var axles8Data: [String] = ["8", "", "", "", "", ""]
    
    var didTapSave = false
    
    var getStandardMaintenanceNameOnTextField:(() -> (String))!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = CreateStandardMaintenanceModel(view: self)
        self.dismissKeyboardOnDidTabView()
        self.standardMaintenanceLabel.text = "standard_maintenance".localized
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func callAddTireDepthAxles(type: String, warningValue: String, criticalValue: String, completion:@escaping (Bool, String?, String?) -> Void){
        let customDialog = AddTireDepthVC.createDialog()
        
        customDialog.text = type
        customDialog.warning = warningValue
        customDialog.critical = criticalValue

        customDialog.didTapSave = { (bool, warning, critical) in
            if bool {
                customDialog.dismiss(animated: true) {
                    completion(true, warning, critical)
                    self.tableView.reloadData()
                }
            }else{
                customDialog.dismiss(animated: true)
                self.tableView.reloadData()
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
    
    func callAddTirePressureAxles(type: String, standardValue: String, warningValue: String, criticalValue: String, completion:@escaping (Bool, String?, String?, String?) -> Void){
        let customDialog = AddTirePressureVC.createDialog()
        
        customDialog.text = type
        customDialog.standard = standardValue
        customDialog.warning = warningValue
        customDialog.critical = criticalValue

        customDialog.didTapSave = { (bool, standard, warning, critical) in
            if bool {
                customDialog.dismiss(animated: true) {
                    completion(true, standard, warning, critical)
                    self.tableView.reloadData()
                }
            }else{
                customDialog.dismiss(animated: true)
                self.tableView.reloadData()
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
    
    func validateTextField(){
        
        if self.getStandardMaintenanceNameOnTextField().isEmpty {
            if let axlesName = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CreateStandardMaintenanceTableViewCell {

                axlesName.errorNameTextFieldImage.isHidden = false
            }
            
            self.tableView.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .none)
        }
        
        let axles1 = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CreateStandardMaintenanceTableViewCell
        let axles2 = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as? CreateStandardMaintenanceTableViewCell
        let axles3 = tableView.cellForRow(at: IndexPath(row: 3, section: 0)) as? CreateStandardMaintenanceTableViewCell
        let axles4 = tableView.cellForRow(at: IndexPath(row: 4, section: 0)) as? CreateStandardMaintenanceTableViewCell
        let axles5 = tableView.cellForRow(at: IndexPath(row: 5, section: 0)) as? CreateStandardMaintenanceTableViewCell
        let axles6 = tableView.cellForRow(at: IndexPath(row: 6, section: 0)) as? CreateStandardMaintenanceTableViewCell
        let axles7 = tableView.cellForRow(at: IndexPath(row: 7, section: 0)) as? CreateStandardMaintenanceTableViewCell
        let axles8 = tableView.cellForRow(at: IndexPath(row: 8, section: 0)) as? CreateStandardMaintenanceTableViewCell
        
        if self.axles1Data[1].isEmpty {
            axles1?.depthAxles1Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
        }
        
        if self.axles1Data[3].isEmpty {
            axles1?.pressureAxles1Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .none)
        }
        
        if self.axles2Data[1].isEmpty {
            axles2?.depthAxles2Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .none)
        }
        
        if self.axles2Data[3].isEmpty {
            axles2?.pressureAxles2Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .none)
        }
        
        if self.axles3Data[1].isEmpty {
            axles3?.depthAxles3Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .none)
        }
        
        if self.axles3Data[3].isEmpty {
            axles3?.pressureAxles3Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .none)
        }
        
        if self.axles4Data[1].isEmpty {
            axles4?.depthAxles4Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 4, section: 0)], with: .none)
        }
        
        if self.axles4Data[3].isEmpty {
            axles4?.pressureAxles4Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 4, section: 0)], with: .none)
        }
        
        if self.axles5Data[1].isEmpty {
            axles5?.depthAxles5Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 5, section: 0)], with: .none)
        }
        
        if self.axles5Data[3].isEmpty {
            axles5?.pressureAxles5Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 5, section: 0)], with: .none)
        }
        
        if self.axles6Data[1].isEmpty {
            axles6!.depthAxles6Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 6, section: 0)], with: .none)
        }
        
        if self.axles6Data[3].isEmpty {
            axles6!.pressureAxles6Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 6, section: 0)], with: .none)
        }
        
        if self.axles7Data[1].isEmpty {
            axles7!.depthAxles7Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 7, section: 0)], with: .none)
        }
        
        if self.axles7Data[3].isEmpty {
            axles7!.pressureAxles7Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 7, section: 0)], with: .none)
        }
        
        if self.axles8Data[1].isEmpty {
            axles8!.depthAxles8Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 8, section: 0)], with: .none)
        }
        
        if self.axles8Data[3].isEmpty {
            axles8!.pressureAxles8Image.image = UIImage(named: "failed")
            self.tableView.reloadRows(at: [IndexPath.init(row: 8, section: 0)], with: .none)
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

//MARK: Extension datasource and delegate.
extension CreateStandardMaintenanceVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        var cell = CreateStandardMaintenanceTableViewCell()
                
        switch indexPath.row {
        case 0:
            let axlesName = tableView.dequeueReusableCell(withIdentifier: "axlesName", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            axlesName.axlesNameLabel.text = "axles_standard_maintenance_name".localized
            axlesName.axlesNameTextField.placeholder = "axles_name".localized
            
            self.getStandardMaintenanceNameOnTextField = {
                return axlesName.axlesNameTextField.text!
            }
            
            if self.didTapSave {
                if axlesName.axlesNameTextField.text!.isEmpty {
                    axlesName.errorNameTextFieldImage.isHidden = false
                }
            }
            
            cell = axlesName
            break
        case 1:
            let axles1 = tableView.dequeueReusableCell(withIdentifier: "axles1", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            axles1.axles1Label.text = "axles".localized + " 1"
            axles1.depthAxles1.placeholder = "standard_tire_depth".localized
            axles1.pressureAxles1.placeholder = "standard_tire_pressure".localized
            
            axles1.didTapTireDepthAxles1Delegate = {
                self.callAddTireDepthAxles(type: "1", warningValue: self.axles1Data[1], criticalValue: self.axles1Data[2]) { (isBoll, warning, critical) in
                    self.axles1Data[1] = warning!
                    self.axles1Data[2] = critical!
                }
                
                axles1.depthAxles1Image.image = UIImage(named: "left")
            }
            
            if self.didTapSave {
                if self.axles1Data[1].isEmpty {
                    axles1.depthAxles1Image.image = UIImage(named: "failed")
                }else{
                    axles1.depthAxles1Image.image = UIImage(named: "left")
                }
                
                if self.axles1Data[3].isEmpty {
                    axles1.pressureAxles1Image.image = UIImage(named: "failed")
                }else{
                    axles1.pressureAxles1Image.image = UIImage(named: "left")
                }
            }
            
            axles1.didTapTirePressureAxles1Delegate = {
                self.callAddTirePressureAxles(type: "1", standardValue: self.axles1Data[3], warningValue: self.axles1Data[4], criticalValue: self.axles1Data[5]) { (isBoll, standard, warning, critical) in
                    self.axles1Data[3] = standard!
                    self.axles1Data[4] = warning!
                    self.axles1Data[5] = critical!
                }
                
                axles1.pressureAxles1Image.image = UIImage(named: "left")
            }
            
            if !self.axles1Data[1].isEmpty || !self.axles1Data[2].isEmpty {
                axles1.depthAxles1.text = self.axles1Data[1] + "," + self.axles1Data[2]
            }
            
            if !self.axles1Data[3].isEmpty || !self.axles1Data[4].isEmpty || !self.axles1Data[5].isEmpty {
                axles1.pressureAxles1.text = self.axles1Data[3] + "," + self.axles1Data[4] + "," + self.axles1Data[5]
            }
            
            cell = axles1
            break
        case 2:
            let axles2 = tableView.dequeueReusableCell(withIdentifier: "axles2", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            axles2.axles2Label.text = "axles".localized + " 2"
            axles2.depthAxles2.placeholder = "standard_tire_depth".localized
            axles2.pressureAxles2.placeholder = "standard_tire_pressure".localized
            
            axles2.didTapTireDepthAxles2Delegate = {
                self.callAddTireDepthAxles(type: "2", warningValue: self.axles2Data[1], criticalValue: self.axles2Data[2]) { (isBoll, warning, critical) in
                    self.axles2Data[1] = warning!
                    self.axles2Data[2] = critical!
                }
                
                axles2.depthAxles2Image.image = UIImage(named: "left")
            }
            
            if self.didTapSave {
                if self.axles2Data[1].isEmpty {
                    axles2.depthAxles2Image.image = UIImage(named: "failed")
                }else{
                    axles2.depthAxles2Image.image = UIImage(named: "left")
                }
                
                if self.axles2Data[3].isEmpty {
                    axles2.pressureAxles2Image.image = UIImage(named: "failed")
                }else{
                    axles2.pressureAxles2Image.image = UIImage(named: "left")
                }
            }
            
            axles2.didTapTirePressureAxles2Delegate = {
                self.callAddTirePressureAxles(type: "2", standardValue: self.axles2Data[3], warningValue: self.axles2Data[4], criticalValue: self.axles2Data[5]) { (isBoll, standard, warning, critical) in
                    self.axles2Data[3] = standard!
                    self.axles2Data[4] = warning!
                    self.axles2Data[5] = critical!
                }
                
                axles2.pressureAxles2Image.image = UIImage(named: "left")
            }
            
            if !self.axles2Data[1].isEmpty || !self.axles2Data[2].isEmpty {
                axles2.depthAxles2.text = self.axles2Data[1] + "," + self.axles2Data[2]
            }
            
            if !self.axles2Data[3].isEmpty || !self.axles2Data[4].isEmpty || !self.axles2Data[5].isEmpty {
                axles2.pressureAxles2.text = self.axles2Data[3] + "," + self.axles2Data[4] + "," + self.axles2Data[5]
            }
            
            cell = axles2
            break
        case 3:
            let axles3 = tableView.dequeueReusableCell(withIdentifier: "axles3", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            axles3.axles3Label.text = "axles".localized + " 3"
            axles3.depthAxles3.placeholder = "standard_tire_depth".localized
            axles3.pressureAxles3.placeholder = "standard_tire_pressure".localized
            
            axles3.didTapTireDepthAxles3Delegate = {
                self.callAddTireDepthAxles(type: "3", warningValue: self.axles3Data[1], criticalValue: self.axles3Data[2]) { (isBoll, warning, critical) in
                    self.axles3Data[1] = warning!
                    self.axles3Data[2] = critical!
                }
                
                axles3.depthAxles3Image.image = UIImage(named: "left")
            }
            
            if self.didTapSave {
                if self.axles3Data[1].isEmpty {
                    axles3.depthAxles3Image.image = UIImage(named: "failed")
                }else{
                    axles3.depthAxles3Image.image = UIImage(named: "left")
                }
                
                if self.axles3Data[3].isEmpty {
                    axles3.pressureAxles3Image.image = UIImage(named: "failed")
                }else{
                    axles3.pressureAxles3Image.image = UIImage(named: "left")
                }
            }
            
            axles3.didTapTirePressureAxles3Delegate = {
                self.callAddTirePressureAxles(type: "3", standardValue: self.axles3Data[3], warningValue: self.axles3Data[4], criticalValue: self.axles3Data[5]) { (isBoll, standard, warning, critical) in
                    self.axles3Data[3] = standard!
                    self.axles3Data[4] = warning!
                    self.axles3Data[5] = critical!
                }
                axles3.pressureAxles3Image.image = UIImage(named: "left")
            }
            
            if !self.axles3Data[1].isEmpty || !self.axles3Data[2].isEmpty {
                axles3.depthAxles3.text = self.axles3Data[1] + "," + self.axles3Data[2]
            }
            
            if !self.axles3Data[3].isEmpty || !self.axles3Data[4].isEmpty || !self.axles3Data[5].isEmpty {
                axles3.pressureAxles3.text = self.axles3Data[3] + "," + self.axles3Data[4] + "," + self.axles3Data[5]
            }
            
            cell = axles3
            break
        case 4:
            let axles4 = tableView.dequeueReusableCell(withIdentifier: "axles4", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            axles4.axles4Label.text = "axles".localized + " 4"
            axles4.depthAxles4.placeholder = "standard_tire_depth".localized
            axles4.pressureAxles4.placeholder = "standard_tire_pressure".localized
            
            axles4.didTapTireDepthAxles4Delegate = {
                self.callAddTireDepthAxles(type: "4", warningValue: self.axles4Data[1], criticalValue: self.axles4Data[2]) { (isBoll, warning, critical) in
                    self.axles4Data[1] = warning!
                    self.axles4Data[2] = critical!
                }
                axles4.depthAxles4Image.image = UIImage(named: "left")
            }
            
            if self.didTapSave {
                if self.axles4Data[1].isEmpty {
                    axles4.depthAxles4Image.image = UIImage(named: "failed")
                }else{
                    axles4.depthAxles4Image.image = UIImage(named: "left")
                }
                
                if self.axles4Data[3].isEmpty {
                    axles4.pressureAxles4Image.image = UIImage(named: "failed")
                }else{
                    axles4.pressureAxles4Image.image = UIImage(named: "left")
                }
            }
            
            axles4.didTapTirePressureAxles4Delegate = {
                self.callAddTirePressureAxles(type: "4", standardValue: self.axles4Data[3], warningValue: self.axles4Data[4], criticalValue: self.axles4Data[5]) { (isBoll, standard, warning, critical) in
                    self.axles4Data[3] = standard!
                    self.axles4Data[4] = warning!
                    self.axles4Data[5] = critical!
                }
                axles4.pressureAxles4Image.image = UIImage(named: "left")
            }
            
            if !self.axles4Data[1].isEmpty || !self.axles4Data[2].isEmpty {
                axles4.depthAxles4.text = self.axles4Data[1] + "," + self.axles4Data[2]
            }
            
            if !self.axles4Data[3].isEmpty || !self.axles4Data[4].isEmpty || !self.axles4Data[5].isEmpty {
                axles4.pressureAxles4.text = self.axles4Data[3] + "," + self.axles4Data[4] + "," + self.axles4Data[5]
            }
            
            cell = axles4
            break
        case 5:
            let axles5 = tableView.dequeueReusableCell(withIdentifier: "axles5", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            axles5.axles5Label.text = "axles".localized + " 5"
            axles5.depthAxles5.placeholder = "standard_tire_depth".localized
            axles5.pressureAxles5.placeholder = "standard_tire_pressure".localized
            
            axles5.didTapTireDepthAxles5Delegate = {
                self.callAddTireDepthAxles(type: "5", warningValue: self.axles5Data[1], criticalValue: self.axles5Data[2]) { (isBoll, warning, critical) in
                    self.axles5Data[1] = warning!
                    self.axles5Data[2] = critical!
                }
                axles5.depthAxles5Image.image = UIImage(named: "left")
            }
            
            if self.didTapSave {
                if self.axles5Data[1].isEmpty {
                    axles5.depthAxles5Image.image = UIImage(named: "failed")
                }else{
                    axles5.depthAxles5Image.image = UIImage(named: "left")
                }
                
                if self.axles5Data[3].isEmpty {
                    axles5.pressureAxles5Image.image = UIImage(named: "failed")
                }else{
                    axles5.pressureAxles5Image.image = UIImage(named: "left")
                }
            }
            
            axles5.didTapTirePressureAxles5Delegate = {
                self.callAddTirePressureAxles(type: "5", standardValue: self.axles5Data[3], warningValue: self.axles5Data[4], criticalValue: self.axles5Data[5]) { (isBoll, standard, warning, critical) in
                    self.axles5Data[3] = standard!
                    self.axles5Data[4] = warning!
                    self.axles5Data[5] = critical!
                }
                axles5.pressureAxles5Image.image = UIImage(named: "left")
            }
            
            if !self.axles5Data[1].isEmpty || !self.axles5Data[2].isEmpty {
                axles5.depthAxles5.text = self.axles5Data[1] + "," + self.axles5Data[2]
            }
            
            if !self.axles5Data[3].isEmpty || !self.axles5Data[4].isEmpty || !self.axles5Data[5].isEmpty {
                axles5.pressureAxles5.text = self.axles5Data[3] + "," + self.axles5Data[4] + "," + self.axles5Data[5]
            }
            
            cell = axles5
            
            break
        case 6:
            let axles6 = tableView.dequeueReusableCell(withIdentifier: "axles6", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            axles6.axles6Label.text = "axles".localized + " 6"
            axles6.depthAxles6.placeholder = "standard_tire_depth".localized
            axles6.pressureAxles6.placeholder = "standard_tire_pressure".localized
            
            axles6.didTapTireDepthAxles6Delegate = {
                self.callAddTireDepthAxles(type: "6", warningValue: self.axles6Data[1], criticalValue: self.axles6Data[2]) { (isBoll, warning, critical) in
                    self.axles6Data[1] = warning!
                    self.axles6Data[2] = critical!
                }
                axles6.depthAxles6Image.image = UIImage(named: "left")
            }
            
            if self.didTapSave {
                if self.axles6Data[1].isEmpty {
                    axles6.depthAxles6Image.image = UIImage(named: "failed")
                }else{
                    axles6.depthAxles6Image.image = UIImage(named: "left")
                }
                
                if self.axles6Data[3].isEmpty {
                    axles6.pressureAxles6Image.image = UIImage(named: "failed")
                }else{
                    axles6.pressureAxles6Image.image = UIImage(named: "left")
                }
            }
            
            axles6.didTapTirePressureAxles6Delegate = {
                self.callAddTirePressureAxles(type: "6", standardValue: self.axles6Data[3], warningValue: self.axles6Data[4], criticalValue: self.axles6Data[5]) { (isBoll, standard, warning, critical) in
                    self.axles6Data[3] = standard!
                    self.axles6Data[4] = warning!
                    self.axles6Data[5] = critical!
                }
                axles6.pressureAxles6Image.image = UIImage(named: "left")
            }
            
            if !self.axles6Data[1].isEmpty || !self.axles6Data[2].isEmpty {
                axles6.depthAxles6.text = self.axles6Data[1] + "," + self.axles6Data[2]
            }
            
            if !self.axles6Data[3].isEmpty || !self.axles6Data[4].isEmpty || !self.axles6Data[5].isEmpty {
                axles6.pressureAxles6.text = self.axles6Data[3] + "," + self.axles6Data[4] + "," + self.axles6Data[5]
            }
            
            cell = axles6
            
            break
        case 7:
            let axles7 = tableView.dequeueReusableCell(withIdentifier: "axles7", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            axles7.axles7Label.text = "axles".localized + " 7"
            axles7.depthAxles7.placeholder = "standard_tire_depth".localized
            axles7.pressureAxles7.placeholder = "standard_tire_pressure".localized
            
            axles7.didTapTireDepthAxles7Delegate = {
                self.callAddTireDepthAxles(type: "7", warningValue: self.axles7Data[1], criticalValue: self.axles7Data[2]) { (isBoll, warning, critical) in
                    self.axles7Data[1] = warning!
                    self.axles7Data[2] = critical!
                }
                axles7.depthAxles7Image.image = UIImage(named: "left")
            }
            
            if self.didTapSave {
                if self.axles7Data[1].isEmpty {
                    axles7.depthAxles7Image.image = UIImage(named: "failed")
                }else{
                    axles7.depthAxles7Image.image = UIImage(named: "left")
                }
                
                if self.axles7Data[3].isEmpty {
                    axles7.pressureAxles7Image.image = UIImage(named: "failed")
                }else{
                    axles7.pressureAxles7Image.image = UIImage(named: "left")
                }
            }
            
            axles7.didTapTirePressureAxles7Delegate = {
                self.callAddTirePressureAxles(type: "7", standardValue: self.axles7Data[3], warningValue: self.axles7Data[4], criticalValue: self.axles7Data[5]) { (isBoll, standard, warning, critical) in
                    self.axles7Data[3] = standard!
                    self.axles7Data[4] = warning!
                    self.axles7Data[5] = critical!
                }
                axles7.pressureAxles7Image.image = UIImage(named: "left")
            }
            
            if !self.axles7Data[1].isEmpty || !self.axles7Data[2].isEmpty {
                axles7.depthAxles7.text = self.axles7Data[1] + "," + self.axles7Data[2]
            }
            
            if !self.axles7Data[3].isEmpty || !self.axles7Data[4].isEmpty || !self.axles7Data[5].isEmpty {
                axles7.pressureAxles7.text = self.axles7Data[3] + "," + self.axles7Data[4] + "," + self.axles7Data[5]
            }
            
            cell = axles7
            
            break
        case 8:
            let axles8 = tableView.dequeueReusableCell(withIdentifier: "axles8", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            axles8.axles8Label.text = "axles".localized + " 8"
            axles8.depthAxles8.placeholder = "standard_tire_depth".localized
            axles8.pressureAxles8.placeholder = "standard_tire_pressure".localized
            
            axles8.didTapTireDepthAxles8Delegate = {
                self.callAddTireDepthAxles(type: "8", warningValue: self.axles8Data[1], criticalValue: self.axles8Data[2]) { (isBoll, warning, critical) in
                    self.axles8Data[1] = warning!
                    self.axles8Data[2] = critical!
                }
                axles8.depthAxles8Image.image = UIImage(named: "left")
            }
            
            if self.didTapSave {
                if self.axles8Data[1].isEmpty {
                    axles8.depthAxles8Image.image = UIImage(named: "failed")
                }else{
                    axles8.depthAxles8Image.image = UIImage(named: "left")
                }
                
                if self.axles8Data[3].isEmpty {
                    axles8.pressureAxles8Image.image = UIImage(named: "failed")
                }else{
                    axles8.pressureAxles8Image.image = UIImage(named: "left")
                }
            }
            
            axles8.didTapTirePressureAxles8Delegate = {
                self.callAddTirePressureAxles(type: "8", standardValue: self.axles8Data[3], warningValue: self.axles8Data[4], criticalValue: self.axles8Data[5]) { (isBoll, standard, warning, critical) in
                    self.axles8Data[3] = standard!
                    self.axles8Data[4] = warning!
                    self.axles8Data[5] = critical!
                }
                axles8.pressureAxles8Image.image = UIImage(named: "left")
            }
            
            if !self.axles8Data[1].isEmpty || !self.axles8Data[2].isEmpty {
                axles8.depthAxles8.text = self.axles8Data[1] + "," + self.axles8Data[2]
            }
            
            if !self.axles8Data[3].isEmpty || !self.axles8Data[4].isEmpty || !self.axles8Data[5].isEmpty {
                axles8.pressureAxles8.text = self.axles8Data[3] + "," + self.axles8Data[4] + "," + self.axles8Data[5]
            }
            
            cell = axles8
            
            break
        case 9:
            let save = tableView.dequeueReusableCell(withIdentifier: "save", for: indexPath) as! CreateStandardMaintenanceTableViewCell
            
            save.saveBTN.setTitle("save".localized, for: .normal)
            save.didTapSaveDelegate = {
                
                self.didTapSave = true
                
                self.validateTextField()
                
                if !self.getStandardMaintenanceNameOnTextField().isEmpty {
                    
                    let isAxles1Empty = self.self.axles1Data.contains { (text) -> Bool in
                        return text.isEmpty
                    }
                    
                    let isAxles2Empty = self.self.axles2Data.contains { (text) -> Bool in
                        return text.isEmpty
                    }
                    
                    let isAxles3Empty = self.self.axles3Data.contains { (text) -> Bool in
                        return text.isEmpty
                    }
                    
                    let isAxles4Empty = self.self.axles4Data.contains { (text) -> Bool in
                        return text.isEmpty
                    }
                    
                    let isAxles5Empty = self.self.axles5Data.contains { (text) -> Bool in
                        return text.isEmpty
                    }
                    
                    let isAxles6Empty = self.self.axles6Data.contains { (text) -> Bool in
                        return text.isEmpty
                    }
                    
                    let isAxles7Empty = self.self.axles7Data.contains { (text) -> Bool in
                        return text.isEmpty
                    }
                    
                    let isAxles8Empty = self.self.axles8Data.contains { (text) -> Bool in
                        return text.isEmpty
                    }
                    
                    switch self.axlesQTYCarStructureInt {
                    case 1:
                        
                        if !isAxles1Empty{
                            self.viewModel.createStandardMaintenance(
                                name: self.getStandardMaintenanceNameOnTextField(),
                                axles1: self.axles1Data,
                                axles2: self.axles2Data,
                                axles3: self.axles3Data,
                                axles4: self.axles4Data,
                                axles5: self.axles5Data,
                                axles6: self.axles6Data,
                                axles7: self.axles7Data,
                                axles8: self.axles8Data
                            )
                        }
                        
                    case 2:
                        
                        if !isAxles1Empty && !isAxles2Empty{
                            self.viewModel.createStandardMaintenance(
                                name: self.getStandardMaintenanceNameOnTextField(),
                                axles1: self.axles1Data,
                                axles2: self.axles2Data,
                                axles3: self.axles3Data,
                                axles4: self.axles4Data,
                                axles5: self.axles5Data,
                                axles6: self.axles6Data,
                                axles7: self.axles7Data,
                                axles8: self.axles8Data
                            )
                        }
                        
                    case 3:
                        
                        if !isAxles1Empty && !isAxles2Empty && !isAxles3Empty{
                            self.viewModel.createStandardMaintenance(
                                name: self.getStandardMaintenanceNameOnTextField(),
                                axles1: self.axles1Data,
                                axles2: self.axles2Data,
                                axles3: self.axles3Data,
                                axles4: self.axles4Data,
                                axles5: self.axles5Data,
                                axles6: self.axles6Data,
                                axles7: self.axles7Data,
                                axles8: self.axles8Data
                            )
                        }
                        
                    case 4:
                        
                        if !isAxles1Empty && !isAxles2Empty && !isAxles3Empty && !isAxles4Empty{
                            self.viewModel.createStandardMaintenance(
                                name: self.getStandardMaintenanceNameOnTextField(),
                                axles1: self.axles1Data,
                                axles2: self.axles2Data,
                                axles3: self.axles3Data,
                                axles4: self.axles4Data,
                                axles5: self.axles5Data,
                                axles6: self.axles6Data,
                                axles7: self.axles7Data,
                                axles8: self.axles8Data
                            )
                        }
                        
                    case 5:
                        
                        if !isAxles1Empty && !isAxles2Empty && !isAxles3Empty && !isAxles4Empty && !isAxles5Empty{
                            self.viewModel.createStandardMaintenance(
                                name: self.getStandardMaintenanceNameOnTextField(),
                                axles1: self.axles1Data,
                                axles2: self.axles2Data,
                                axles3: self.axles3Data,
                                axles4: self.axles4Data,
                                axles5: self.axles5Data,
                                axles6: self.axles6Data,
                                axles7: self.axles7Data,
                                axles8: self.axles8Data
                            )
                        }
                        
                    case 6:
                        
                        if !isAxles1Empty && !isAxles2Empty && !isAxles3Empty && !isAxles4Empty && !isAxles5Empty && !isAxles6Empty{
                            self.viewModel.createStandardMaintenance(
                                name: self.getStandardMaintenanceNameOnTextField(),
                                axles1: self.axles1Data,
                                axles2: self.axles2Data,
                                axles3: self.axles3Data,
                                axles4: self.axles4Data,
                                axles5: self.axles5Data,
                                axles6: self.axles6Data,
                                axles7: self.axles7Data,
                                axles8: self.axles8Data
                            )
                        }
                        
                    case 7:
                        
                        if !isAxles1Empty && !isAxles2Empty && !isAxles3Empty && !isAxles4Empty && !isAxles5Empty && !isAxles6Empty && !isAxles7Empty{
                            self.viewModel.createStandardMaintenance(
                                name: self.getStandardMaintenanceNameOnTextField(),
                                axles1: self.axles1Data,
                                axles2: self.axles2Data,
                                axles3: self.axles3Data,
                                axles4: self.axles4Data,
                                axles5: self.axles5Data,
                                axles6: self.axles6Data,
                                axles7: self.axles7Data,
                                axles8: self.axles8Data
                            )
                        }
                        
                    case 8:
                        
                        if !isAxles1Empty && !isAxles2Empty && !isAxles3Empty && !isAxles4Empty && !isAxles5Empty && !isAxles6Empty && !isAxles7Empty && !isAxles8Empty{
                            self.viewModel.createStandardMaintenance(
                                name: self.getStandardMaintenanceNameOnTextField(),
                                axles1: self.axles1Data,
                                axles2: self.axles2Data,
                                axles3: self.axles3Data,
                                axles4: self.axles4Data,
                                axles5: self.axles5Data,
                                axles6: self.axles6Data,
                                axles7: self.axles7Data,
                                axles8: self.axles8Data
                            )
                        }
                        
                    default:
                        break
                    }
                }
            }
            
            cell = save
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch axlesQTYCarStructureInt {
        case 0:
            
            switch indexPath.row {
            case 0:
                return 0
            case 1:
                return 0
            case 2:
                return 0
            case 3:
                return 0
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 0
            case 7:
                return 0
            case 8:
                return 0
            case 9:
                return 0
            default:
                break
            }
            
        case 1:
            
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 200
            case 2:
                return 0
            case 3:
                return 0
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 0
            case 7:
                return 0
            case 8:
                return 0
            case 9:
                return 100
            default:
                break
            }
            
        case 2:
            
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 200
            case 2:
                return 200
            case 3:
                return 0
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 0
            case 7:
                return 0
            case 8:
                return 0
            case 9:
                return 100
            default:
                break
            }
            
        case 3:
            
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 200
            case 2:
                return 200
            case 3:
                return 200
            case 4:
                return 0
            case 5:
                return 0
            case 6:
                return 0
            case 7:
                return 0
            case 8:
                return 0
            case 9:
                return 100
            default:
                break
            }
            
        case 4:
            
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 200
            case 2:
                return 200
            case 3:
                return 200
            case 4:
                return 200
            case 5:
                return 0
            case 6:
                return 0
            case 7:
                return 0
            case 8:
                return 0
            case 9:
                return 100
            default:
                break
            }
            
        case 5:
            
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 200
            case 2:
                return 200
            case 3:
                return 200
            case 4:
                return 200
            case 5:
                return 200
            case 6:
                return 0
            case 7:
                return 0
            case 8:
                return 0
            case 9:
                return 100
            default:
                break
            }
            
        case 6:
            
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 200
            case 2:
                return 200
            case 3:
                return 200
            case 4:
                return 200
            case 5:
                return 200
            case 6:
                return 200
            case 7:
                return 0
            case 8:
                return 0
            case 9:
                return 100
            default:
                break
            }
            
        case 7:
            
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 200
            case 2:
                return 200
            case 3:
                return 200
            case 4:
                return 200
            case 5:
                return 200
            case 6:
                return 200
            case 7:
                return 200
            case 8:
                return 0
            case 9:
                return 100
            default:
                break
            }
            
        case 8:
            switch indexPath.row {
            case 0:
                return 100
            case 1:
                return 200
            case 2:
                return 200
            case 3:
                return 200
            case 4:
                return 200
            case 5:
                return 200
            case 6:
                return 200
            case 7:
                return 200
            case 8:
                return 200
            case 9:
                return 100
            default:
                break
            }
        default:
            break
        }

        return CGFloat()
    }
}

extension CreateStandardMaintenanceVC: UITextFieldDelegate {
    
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
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
//        if textField.text!.count == 1 {
//            if let axlesName = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CreateStandardMaintenanceTableViewCell {
//
//                axlesName.errorNameTextFieldImage.isHidden = true
//            }
//        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField.text!.count == 1 {
            if let axlesName = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CreateStandardMaintenanceTableViewCell {

                axlesName.errorNameTextFieldImage.isHidden = true
            }
        }
    }
}

extension CreateStandardMaintenanceVC: CreateStandardMaintenanceModelDelegate {
    func didFinishRefreshToken() {
        self.viewModel.createStandardMaintenance(
            name: self.getStandardMaintenanceNameOnTextField(),
            axles1: self.axles1Data,
            axles2: self.axles2Data,
            axles3: self.axles3Data,
            axles4: self.axles4Data,
            axles5: self.axles5Data,
            axles6: self.axles6Data,
            axles7: self.axles7Data,
            axles8: self.axles8Data
        )
    }
    
    func didFinishCreateStandardMaintenance(_ status: statusWebService) {
        switch status {
        case .success :
            UserDefaults.standard.set(true, forKey: "isCreateStandardMaintenanceSuccess")
//            let storyboard : UIStoryboard = UIStoryboard(name: "RegisterCar", bundle: nil)
//            let registerCar: RegisterCarVC = storyboard.instantiateInitialViewController() as! RegisterCarVC
//            self.navigationController?.pushViewController(registerCar, animated: true)
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

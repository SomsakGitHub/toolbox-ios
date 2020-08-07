//
//  RegisterTireVC.swift
//  BridgeStone
//
//  Created by somsak on 12/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class RegisterTireVC: UIViewController, SelectDesignTireVCDelegate, SelectJobSiteVCDelegate, DesignTireAfterVCDelegate{
    
    
    @IBOutlet weak var registerTiresLabel: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var errorSaveView: ViewRound!
    @IBOutlet weak var errorSaveLabel: UILabel!
    
    private var viewModel: RegisterTireModel!
    
    var didFinishSaveTimer: Timer?
    var newTireType = true
    var didTapSaveTrieClick = false
    var newTiredata: [String] = ["", "", "", "", "", "", "", ""]
    var tireTemplatesName = ""
    var jobsitesName = ""
    var designTireAfter = ""
    var getNumberTireOnTextField:(() -> (String))!
    var getProductionDateOnTextField:(() -> (String))!
    var getProductionYearOnTextField:(() -> (String))!
    var getNumberTireAfterOnTextField:(() -> (String))!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = RegisterTireModel(view: self)
        registerForKeyboardWillShowNotification(dataTableView)
        registerForKeyboardWillHideNotification(dataTableView)
        self.dismissKeyboardOnDidTabView()
        
        if newTireType {
            self.newTiredata[0] = "new"
            UserDefaults.standard.set(true, forKey: "isNewTire")
        }
        
        self.registerTiresLabel.text = "register_tire".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let isSaveJobSite = UserDefaults.standard.bool(forKey: "isSaveJobSite")
        
        if isSaveJobSite {
            self.viewModel.fetchJobSite()
        }
        
        let isSaveTemplates = UserDefaults.standard.bool(forKey: "isSaveTemplates")
        
        if isSaveTemplates {
            self.viewModel.fetchDesignTire()
        }
        
        let isSavePastTemplates = UserDefaults.standard.bool(forKey: "isSavePastTemplates")
        
        if isSavePastTemplates {
            self.viewModel.fetchDesignTire()
        }
        
        if self.newTireType {
            UserDefaults.standard.set(true, forKey: "isNewTire")
        }else{
            UserDefaults.standard.set(false, forKey: "isNewTire")
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selectDesignTireVC = segue.destination as? SelectDesignTireVC {
            //            btsViewController.station = self.stations
            selectDesignTireVC.selectDesignTireVCDelegate = self
        }else if let jobSiteVC = segue.destination as? JobSiteVC {
            //            btsViewController.station = self.stations
            jobSiteVC.selectJobSiteVCDelegate = self
        }else if let designTireAfterVC = segue.destination as? DesignTireAfterVC {
            //            btsViewController.station = self.stations
            designTireAfterVC.designTireAfterVCDelegate = self
        }
    }
    
    func selectDesignTire(data: TireTemplates) {
        self.newTiredata[2] = String(data.id)
        self.tireTemplatesName = data.nameTireTemplate
        self.dataTableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
    }
    
    func selectJobSite(data: Jobsites) {
        self.newTiredata[3] = String(data.id)
        self.jobsitesName = data.jobsiteName
        self.dataTableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .automatic)
    }
    
    func selectDesignTireAfter(data: TireTemplates) {
        self.newTiredata[6] = String(data.id)
        self.designTireAfter = data.nameTireTemplate
        self.dataTableView.reloadRows(at: [IndexPath.init(row: 5, section: 0)], with: .automatic)
    }
    
    func validateTextField(){
        
        if self.newTiredata[1].isEmpty {
            validateSaveView(text: "specify_number_tires".localized)
        }else if self.newTiredata[2].isEmpty {
            validateSaveView(text: "specify_template_tires".localized)
        }else if self.newTiredata[3].isEmpty {
            validateSaveView(text: "specify_job_site_car".localized)
        }else if self.newTiredata[4].isEmpty {
            validateSaveView(text: "specify_production_date".localized)
        }else if self.newTiredata[5].isEmpty || Int(self.newTiredata[5])! < Calendar(identifier: .gregorian).component(.year, from: Date()){
            validateSaveView(text: "specify_production_year".localized)
        }else if !self.newTireType {
            if self.newTiredata[6].isEmpty {
                validateSaveView(text: "specify_cast_tires_template".localized)
            }else if self.newTiredata[7].isEmpty{
                validateSaveView(text: "specify_number_template_tires".localized)
            }else{
                let isTextfieldEmpty = self.newTiredata.contains { (text) -> Bool in
                    return text.isEmpty
                }
                
                if !isTextfieldEmpty {
                    if self.didTapSaveTrieClick {
                        self.viewModel.registerTire(data: self.newTiredata)
                    }else{
                        self.viewModel.registerTireNext(data: self.newTiredata)
                    }
                }
            }
        }else if self.newTireType {
            if self.didTapSaveTrieClick {
                self.viewModel.registerTire(data: self.newTiredata)
            }else{
                self.viewModel.registerTireNext(data: self.newTiredata)
            }
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
extension RegisterTireVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = RegisterTireTableViewCell()
            
        switch indexPath.row {
        case 0:
            let selectTire = tableView.dequeueReusableCell(withIdentifier: "selectTire", for: indexPath) as! RegisterTireTableViewCell
            
            selectTire.didTapNewTireDelegate = {
                selectTire.newTireBTNImage.image = UIImage(named: "RectangleRed")
                selectTire.tireCastBTNImage.image = UIImage(named: "RectangleWhite")
                self.newTireType = true
                
                if self.newTiredata.count == 8 {
                    self.newTiredata.remove(at: 7)
                    self.newTiredata.remove(at: 6)
                }
                self.newTiredata = ["", "", "", "", "", "", "", ""]
                self.newTiredata[0] = "new"
                self.tireTemplatesName = ""
                self.jobsitesName = ""
                self.designTireAfter = ""
                UserDefaults.standard.set(true, forKey: "isNewTire")
                self.dataTableView.reloadData()
            }
            
            selectTire.didTapCastTireDelegate = {
                selectTire.newTireBTNImage.image = UIImage(named: "RectangleWhite")
                selectTire.tireCastBTNImage.image = UIImage(named: "RectangleRed")
                self.newTireType = false
                
                if self.newTiredata.count == 6 {
                    self.newTiredata.insert("", at: 6)
                    self.newTiredata.insert("", at: 7)
                }
                self.newTiredata = ["", "", "", "", "", "", "", ""]
                self.newTiredata[0] = "retread"
                self.tireTemplatesName = ""
                self.jobsitesName = ""
                self.designTireAfter = ""
                UserDefaults.standard.set(false, forKey: "isNewTire")
                self.dataTableView.reloadData()
            }
            
            selectTire.newTiresLabel.text = "new_tires".localized
            selectTire.castTiresLabel.text = "cast_tires".localized
            
            cell = selectTire
            break
        case 1:
            let numberTire = tableView.dequeueReusableCell(withIdentifier: "numberTire", for: indexPath) as! RegisterTireTableViewCell
            
            numberTire.numberTiresLabel.text = "number_tires".localized
            numberTire.numberTireTextField.placeholder = "number_tire".localized
            numberTire.numberTireTextField.text = self.newTiredata[1]
            
            self.getNumberTireOnTextField = {
                return numberTire.numberTireTextField.text!
            }

            cell = numberTire
            break
        case 2:
            let designTire = tableView.dequeueReusableCell(withIdentifier: "designTire", for: indexPath) as! RegisterTireTableViewCell
            
            if self.newTireType {
                designTire.pastTemplatesLabel.text = "select_template_tires".localized
                designTire.designTireTextField.placeholder = "design_tire".localized
            }else{
                designTire.pastTemplatesLabel.text = "cast_tires_template".localized
                designTire.designTireTextField.placeholder = "select_cast_tires_template".localized
            }
            
            
            designTire.designTireTextField.text = self.tireTemplatesName

            cell = designTire
            break
        case 3:
            let jobSite = tableView.dequeueReusableCell(withIdentifier: "jobSite", for: indexPath) as! RegisterTireTableViewCell
            
            jobSite.jobSiteLabel.text = "job_site_car".localized
            jobSite.jobSiteTextField.placeholder = "job_site_your_name".localized
            jobSite.jobSiteTextField.text = self.jobsitesName

            cell = jobSite
            break
        case 4:
            let productionDate = tableView.dequeueReusableCell(withIdentifier: "productionDate", for: indexPath) as! RegisterTireTableViewCell
            
            productionDate.productionDateLabel.text = "production_date_tires".localized
            productionDate.productionDateTextField.placeholder = "production_date".localized
            productionDate.productionYearTextField.placeholder = "production_year".localized
            
            productionDate.productionDateTextField.text! = ""
            productionDate.productionYearTextField.text! = ""
            
            self.getProductionDateOnTextField = {
                return productionDate.productionDateTextField.text!
            }
            
            self.getProductionYearOnTextField = {
                return productionDate.productionYearTextField.text!
            }

            cell = productionDate
            break
        case 5:
            let designTireAfterSuccess = tableView.dequeueReusableCell(withIdentifier: "designTireAfterSuccess", for: indexPath) as! RegisterTireTableViewCell
            
            designTireAfterSuccess.castTemplateLabel.text = "cast_template_tires".localized
            designTireAfterSuccess.designTireAfterTextfield.placeholder = "select_cast_template_tires".localized
            designTireAfterSuccess.designTireAfterTextfield.text = self.designTireAfter

            cell = designTireAfterSuccess
            
            break
        case 6:
            let numberTireAfterSuccess = tableView.dequeueReusableCell(withIdentifier: "numberTireAfterSuccess", for: indexPath) as! RegisterTireTableViewCell
            
            numberTireAfterSuccess.castNumberTireLabel.text = "number_template_tires".localized
            numberTireAfterSuccess.numberTireAfterTextField.placeholder = "number_cast_tires".localized
            numberTireAfterSuccess.numberTireAfterTextField.text = self.newTiredata[7]
            
            self.getNumberTireAfterOnTextField = {
                return numberTireAfterSuccess.numberTireAfterTextField.text!
            }

            cell = numberTireAfterSuccess
            break
        case 7:
            let detailTire = tableView.dequeueReusableCell(withIdentifier: "detailTire", for: indexPath) as! RegisterTireTableViewCell
            detailTire.detailTiresLabel.text = "detail_tires".localized

            cell = detailTire
            break
        case 8:
            let save = tableView.dequeueReusableCell(withIdentifier: "save", for: indexPath) as! RegisterTireTableViewCell
            
            save.didTapSaveDelegate = {
                
                self.didTapSaveTrieClick = true
                
                self.newTiredata[1] = self.getNumberTireOnTextField()
                self.newTiredata[4] = self.getProductionDateOnTextField()
                self.newTiredata[5] = self.getProductionYearOnTextField()
                
                if !self.newTireType {
                    self.newTiredata[7] = self.getNumberTireAfterOnTextField()
                    
                    print("didTapSaveTrieNextDelegate", self.newTiredata[0], self.newTiredata[1], self.newTiredata[2], self.newTiredata[3], self.newTiredata[4], self.newTiredata[5], self.newTiredata[6], self.newTiredata[7])
                }
                
                self.validateTextField()
            }
            
            save.didTapSaveTrieNextDelegate = {
                
                self.didTapSaveTrieClick = false
                
                self.newTiredata[1] = self.getNumberTireOnTextField()
                self.newTiredata[4] = self.getProductionDateOnTextField()
                self.newTiredata[5] = self.getProductionYearOnTextField()
                
                if !self.newTireType {
                    self.newTiredata[7] = self.getNumberTireAfterOnTextField()
                }
                
                 print("didTapSaveTrieNextDelegate", self.newTiredata[0], self.newTiredata[1], self.newTiredata[2], self.newTiredata[3], self.newTiredata[4], self.newTiredata[5], self.newTiredata[6], self.newTiredata[7])
                
                self.validateTextField()
            }
            
            save.registerBTN.setTitle("register".localized, for: .normal)
            save.registerNextBTN.setTitle("register_tires_next".localized, for: .normal)

            cell = save
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 100
        case 2:
            return 100
        case 3:
            return 100
        case 4:
            return 100
        case 5:
            if self.newTireType {
                return 0
            }else{
                return 100
            }
        case 6:
            if self.newTireType {
                return 0
            }else{
                return 100
            }
        case 7:
            return 40
        case 8:
            return 100
        default:
            break
        }

        return CGFloat()
    }
}

extension RegisterTireVC: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        
        if let numberTire = dataTableView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as? RegisterTireTableViewCell {
            
            self.newTiredata[1] = numberTire.numberTireTextField.text!
            
        }
        
        if let numberTireAfterSuccess = dataTableView.cellForRow(at: IndexPath.init(row: 6, section: 0)) as? RegisterTireTableViewCell {
            
            self.newTiredata[7] = numberTireAfterSuccess.numberTireAfterTextField.text!
            
        }
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {

        
    }
    
}

extension RegisterTireVC: RegisterTireModelDelegate {
    
    func didFinishRegisterTire(_ status: statusWebService) {
        switch status {
        case .success :
            self.performSegue(withIdentifier: "goToRegisterTireSuccess", sender: self)
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishRegisterTireNext(_ status: statusWebService) {
        switch status {
        case .success :
            self.newTiredata[1] = ""
            self.dataTableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
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
            self.newTiredata[3] = String(jobsites.id)
            self.dataTableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .automatic)
            UserDefaults.standard.set(false, forKey: "isSaveJobSite")
            
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishFetchingTireTemplates(_ status: statusWebService, tireTemplates: TireTemplates) {
        switch status {
        case .success :
            
            let isSaveTemplates = UserDefaults.standard.bool(forKey: "isSaveTemplates")
            
            if isSaveTemplates {
                if self.newTireType {
                    self.newTiredata[2] = String(tireTemplates.id)
                    self.tireTemplatesName = tireTemplates.nameTireTemplate
                    self.dataTableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
                }else{
                    self.newTiredata[6] = String(tireTemplates.id)
                    self.designTireAfter = tireTemplates.nameTireTemplate
                    self.dataTableView.reloadRows(at: [IndexPath.init(row: 5, section: 0)], with: .automatic)
                    
                }
                UserDefaults.standard.set(false, forKey: "isSaveTemplates")
            }else{
                self.newTiredata[2] = String(tireTemplates.id)
                self.tireTemplatesName = tireTemplates.nameTireTemplate
                self.dataTableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
                UserDefaults.standard.set(false, forKey: "isSavePastTemplates")
            }
            
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishRefreshToken(type: registerTireModelEnum) {
        switch type {
        case .fetchDesignTire:
            self.viewModel.fetchDesignTire()
            break
        case .fetchJobSite:
            self.viewModel.fetchJobSite()
            break
        case .registerTire:
            self.viewModel.registerTire(data: self.newTiredata)
            break
        case .registerTireNext:
            self.viewModel.registerTireNext(data: self.newTiredata)
            break
        default :
            break
        }
    }
}

//
//  CarStructureVC.swift
//  BridgeStone
//
//  Created by somsak on 17/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class CarStructureVC: UIViewController {

    
    @IBOutlet weak var carStructureLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var structureTypeLabel: UILabel!
    @IBOutlet weak var axlesQTYLabel: UILabel!
    @IBOutlet weak var wheelQTYLabel: UILabel!
    @IBOutlet weak var searchTextField: placeHolderTextField!
    
    var carStructure: [CarStructure] = []
    var carStructureSearch: [CarStructure] = []
    var params: [String] = ["tractor", "", "", ""]
    var structureIntType = 2
    var isSearchOnline = false
    var isSearch = false
    
    private var viewModel: CarStructureModel!
    var carStructureVCDelegate: CarStructureVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = CarStructureModel(view: self)
        self.viewModel.fetchCarStructure(param: params)
        self.carStructureLabel.text = "select_car_structure".localized
        self.structureTypeLabel.text = "tractor".localized
        self.axlesQTYLabel.text = "select_axles".localized
        self.wheelQTYLabel.text = "select_wheel".localized
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchTextField.placeholder = "search".localized
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func structureTypeClick(_ sender: Any) {
        self.createDialogCarStructureType() { (structureType) in
            
            if structureType == "tractor" || structureType == "Tractor" || structureType == "หัว"{
                self.structureIntType = 1
                self.structureTypeLabel.text = "tractor".localized
                self.params[0] = "tractor"
            }else {
                self.structureIntType = 2
                self.structureTypeLabel.text = "trailer".localized
                self.params[0] = "trailer"
            }
            
            self.viewModel.fetchCarStructure(param: self.params)
        }
    }
    
    @IBAction func axlesQTYClick(_ sender: Any) {
        self.createDialogCarAxlesQTY() { (axlesQTY) in
            self.axlesQTYLabel.text = axlesQTY + " "+"axles".localized
            self.params[1] = axlesQTY
            self.viewModel.fetchCarStructure(param: self.params)
        }
        
        self.isSearchOnline = true
    }
    
    @IBAction func wheelQTYClick(_ sender: Any) {
        self.createDialogCarWheelQTY() { (wheelQTY) in
            self.wheelQTYLabel.text = wheelQTY + " "+"wheel".localized
            self.params[2] = wheelQTY
            self.viewModel.fetchCarStructure(param: self.params)
        }
        
        self.isSearchOnline = true
    }
        
    func createDialogCarStructureType(completion:@escaping (String) -> Void){
        let customDialog = DialogCarDetailVC.createDialog()
        
        customDialog.isDialogCarStructure = true
        customDialog.structureType = self.structureIntType
        
        customDialog.selectClick = { (value) in
            customDialog.dismiss(animated: true){
                completion(value)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
    
    func createDialogCarAxlesQTY(completion:@escaping (String) -> Void){
        let customDialog = DialogCarDetailVC.createDialog()
        
        customDialog.isDialogCarStructure = true
        customDialog.structureType = self.structureIntType
        customDialog.isAxlesQTY = true
        
        customDialog.selectClick = { (value) in
            customDialog.dismiss(animated: true){
                completion(value)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
    
    func createDialogCarWheelQTY(completion:@escaping (String) -> Void){
        let customDialog = DialogCarDetailVC.createDialog()
        
        customDialog.isDialogCarStructure = true
        customDialog.structureType = self.structureIntType
        customDialog.isWheelQTY = true
        
        customDialog.selectClick = { (value) in
            customDialog.dismiss(animated: true){
                completion(value)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
}

//MARK: Extension datasource and delegate.
extension CarStructureVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !self.carStructure.isEmpty  {
            if self.isSearchOnline {
                return self.carStructure.count
            }else{
                if self.isSearch {
                    return self.carStructureSearch.count
                }else{
                    return self.carStructure.count
                }
            }
        }
        
        return Int()
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let carStructureTableViewCell = tableView.dequeueReusableCell(withIdentifier: "carStructureTableViewCell", for: indexPath) as! CarStructureTableViewCell
        
        if !self.carStructure.isEmpty  {
            if self.isSearchOnline {
                carStructureTableViewCell.initView(
                    carStructure : self.carStructure[indexPath.row]
                )
            }else{
                if self.isSearch {
                    carStructureTableViewCell.initView(
                        carStructure : self.carStructureSearch[indexPath.row]
                    )
                }else{
                    carStructureTableViewCell.initView(
                        carStructure : self.carStructure[indexPath.row]
                    )
                }
            }
        }
        
        return carStructureTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.isSearchOnline {
            self.carStructureVCDelegate?.selectcarStructure(data: self.carStructure[indexPath.row])
            UserDefaults.standard.set(self.carStructure[indexPath.row].axlesQTY, forKey: "axlesQTYCarStructure")
        }else{
            if self.isSearch {
                self.carStructureVCDelegate?.selectcarStructure(data: self.carStructureSearch[indexPath.row])
                UserDefaults.standard.set(self.carStructureSearch[indexPath.row].axlesQTY, forKey: "axlesQTYCarStructure")
            }else{
                self.carStructureVCDelegate?.selectcarStructure(data: self.carStructure[indexPath.row])
                UserDefaults.standard.set(self.carStructure[indexPath.row].axlesQTY, forKey: "axlesQTYCarStructure")
            }
        }

        self.navigationController?.popViewController(animated: true)
    }
}

extension CarStructureVC: UITextFieldDelegate {
    
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
        
        if self.isSearchOnline {
            if textField.text!.count > 0 {
                self.params[3] = textField.text!
                self.viewModel.fetchCarStructure(param: self.params)
            }
        }else{
            self.carStructureSearch = (self.carStructure.filter { (car: CarStructure) -> Bool in
                return car.name.lowercased().contains(textField.text!.lowercased())
            })
            
            if textField.text!.count > 0 {
                self.isSearch = true
            }else{
                self.isSearch = false
            }
            
            self.tableView.reloadData()
        }
    }
}

extension CarStructureVC: CarStructureModelDelegate {
    func didFinishRefreshToken() {
        self.viewModel.fetchCarStructure(param: self.params)
    }
    
    func didFinishFetchingCarStructure(_ status: statusWebService, carStructure: [CarStructure]) {
        switch status {
        case .success :
            self.carStructure = carStructure
            self.tableView.reloadData()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

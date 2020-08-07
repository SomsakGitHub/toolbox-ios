//
//  SearchCarAdvanceVC.swift
//  BridgeStone
//
//  Created by somsak on 25/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class SearchCarAdvanceVC: UIViewController {
    
    @IBOutlet weak var searchAdvanceLabel: UILabel!
    @IBOutlet weak var
    frontCarTextField: placeHolderTextField!
    @IBOutlet weak var wheelQTYTextField: placeHolderTextField!
    @IBOutlet weak var axlesQTYTextField: placeHolderTextField!
    @IBOutlet weak var dateTextField: placeHolderTextField!
    @IBOutlet weak var statusTextField: placeHolderTextField!
    @IBOutlet weak var saveBTN: ButtonRound!
    
    var searchCarAdvanceVCDelegate: SearchCarAdvanceVCDelegate?
    
    var param: [String] = ["", "", "", "", "", ""]
    var structureIntType = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func structureTypeClick(_ sender: Any) {
        self.createDialogCarStructureType() { (structureType) in
            
            if structureType == "Tractor" || structureType == "หัว"{
                self.structureIntType = 1
                self.frontCarTextField.text = structureType
                self.param[3] = "tractor"
            }else{
                self.structureIntType = 2
                self.frontCarTextField.text = structureType
                self.param[3] = "trailer"
            }

            
        }
    }
    
    @IBAction func wheelQTYClick(_ sender: Any) {
        self.createDialogCarWheelQTY() { (wheelQTY) in
            self.wheelQTYTextField.text = wheelQTY + " "+"wheel".localized
            self.param[2] = wheelQTY
        }
    }
    
    @IBAction func axlesQTYClick(_ sender: Any) {
        self.createDialogCarAxlesQTY() { (axlesQTY) in
            self.axlesQTYTextField.text = axlesQTY + " "+"axles".localized
            self.param[1] = axlesQTY
        }
    }
    
    @IBAction func didTapOrderby(_ sender: Any) {
        self.createDialogOrderby(type: .orderby) { (text) in
            
            if text == "เรียงตามวันที่ล่าสุด" || text == "Sort by latest date"{
                self.param[4] = "ASC"
                self.dateTextField.text = text
            }else{
                self.param[4] = "DESC"
                self.dateTextField.text = text
            }
        }
    }
    
    @IBAction func didTapTireStatus(_ sender: Any) {
        self.createDialogOrderby(type: .status) { (text) in
            
            if text == "ใช้งาน" || text == "Active" {
                self.param[5] = "true"
                self.statusTextField.text = text
            }else if text == "ไม่ใช้งาน" || text == "Not active"{
                self.param[5] = "false"
                self.statusTextField.text = text
            }
        }
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        self.searchCarAdvanceVCDelegate?.searchCarAdvanceData(params: param)
        self.navigationController?.popViewController(animated: true)
    }
    
    func initView(){
        self.searchAdvanceLabel.text = "search_advance".localized
        self.frontCarTextField.placeholder = "tractor_trailer".localized
        self.wheelQTYTextField.placeholder = "wheel_QTY".localized
        self.axlesQTYTextField.placeholder = "axles_QTY".localized
        self.dateTextField.placeholder = "sorted_by_latest_update".localized
        self.statusTextField.placeholder = "tires_status".localized
        self.saveBTN.setTitle("save".localized, for: .normal)
    }
    
    func createDialogCarStructureType(completion:@escaping (String) -> Void){
        let customDialog = DialogCarDetailVC.createDialog()
        
        customDialog.isDialogCarStructure = true
        customDialog.structureType = 2
        
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
        customDialog.structureType = 2
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
        customDialog.structureType = 2
        customDialog.isWheelQTYCar = true
        
        customDialog.selectClick = { (value) in
            customDialog.dismiss(animated: true){
                completion(value)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
    
    func createDialogOrderby(type: searchTireAdvanceStatus, completion:@escaping (String) -> Void){
        let customDialog  = DialogOrderbyVC.createDialog()
        
        customDialog.type = type
        customDialog.searchType = .car
        
        customDialog.selectClick = { (value) in
            customDialog.dismiss(animated: true){
                completion(value)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
}

protocol SearchCarAdvanceVCDelegate {
    func searchCarAdvanceData(params: [String])
}

//
//  SearchTireAdvanceVC.swift
//  BridgeStone
//
//  Created by somsak on 25/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class SearchTireAdvanceVC: UIViewController {
    
    @IBOutlet weak var searchAdvanceLabel: UILabel!
    @IBOutlet weak var depthTiresLabel: UILabel!
    @IBOutlet weak var minimummaximumDepthTextField: placeHolderTextField!
    @IBOutlet weak var maximumDepthTextField: placeHolderTextField!
    @IBOutlet weak var dateTextField: placeHolderTextField!
    @IBOutlet weak var statusTextField: placeHolderTextField!
    @IBOutlet weak var saveBTN: ButtonRound!
    
    var searchTireAdvanceVCDelegate: SearchTireAdvanceVCDelegate?
    
    var papram: [String] = ["", "", "", "", ""]

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapOrderby(_ sender: Any) {
        self.createDialogOrderby(type: .orderby) { (text) in

            if text == "เรียงตามวันที่ล่าสุด" || text == "Sort by latest date"{
                self.papram[3] = "ASC"
                self.dateTextField.text = text
            }else{
                self.papram[3] = "DESC"
                self.dateTextField.text = text
            }
        }
    }
    
    @IBAction func didTapTireStatus(_ sender: Any) {
        self.createDialogOrderby(type: .status) { (text) in
            
            if text == "รอหล่อ" || text == "Wait retread"{
                self.papram[4] = "wait retread"
                self.statusTextField.text = text
            }else if text == "เก็บในคลัง" || text == "In stock"{
                self.papram[4] = "in stock"
                self.statusTextField.text = text
            }else if text == "ยางเสีย" || text == "Waste tires"{
                self.papram[4] = "waste tires"
                self.statusTextField.text = text
            }else{
                self.papram[4] = "in car"
                self.statusTextField.text = text
            }
        }
    }

    @IBAction func didTapSave(_ sender: Any) {
        self.papram[1] = self.minimummaximumDepthTextField.text!
        self.papram[2] = self.maximumDepthTextField.text!
        self.searchTireAdvanceVCDelegate?.searchTireAdvanceData(params: papram)
        self.navigationController?.popViewController(animated: true)
    }
    
    func initView(){
        self.searchAdvanceLabel.text = "search_advance".localized
        self.depthTiresLabel.text = "depth_tires".localized
        self.minimummaximumDepthTextField.placeholder = "minimum".localized
        self.maximumDepthTextField.placeholder = "maximum".localized
        self.dateTextField.placeholder = "sorted_by_latest_update".localized
        self.statusTextField.placeholder = "tires_status".localized
        self.saveBTN.setTitle("save".localized, for: .normal)
    }
    
    func createDialogOrderby(type: searchTireAdvanceStatus, completion:@escaping (String) -> Void){
        let customDialog  = DialogOrderbyVC.createDialog()
        
        customDialog.type = type
        customDialog.searchType = .tires
        
        customDialog.selectClick = { (value) in
            customDialog.dismiss(animated: true){
                completion(value)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
}

protocol SearchTireAdvanceVCDelegate {
    func searchTireAdvanceData(params: [String])
}

enum searchTireAdvanceStatus {
    case orderby
    case status
}

enum searchStatus {
    case car
    case tires
}

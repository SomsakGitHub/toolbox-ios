//
//  SelectDesignTireVC.swift
//  BridgeStone
//
//  Created by somsak on 14/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class SelectDesignTireVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tiresTemplateLabel: UILabel!
    @IBOutlet weak var searchTextField: placeHolderTextField!
    
    private var viewModel: SelectDesignTireModel!
    var tireTemplates: [TireTemplates] = []
    var tireTemplatesSearch: [TireTemplates] = []
    var selectDesignTireVCDelegate: SelectDesignTireVCDelegate?
    var isSearch = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = SelectDesignTireModel(view: self)
        self.viewModel.fetchDesignTire(q: "")
        self.tiresTemplateLabel.text = "select_template_tires".localized
        self.searchTextField.placeholder = "search".localized
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: Extension datasource and delegate.
extension SelectDesignTireVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isSearch {
            return self.tireTemplatesSearch.count
        }else{
            return self.tireTemplates.count
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let selectDesignTireTableViewCell = tableView.dequeueReusableCell(withIdentifier: "selectDesignTireTableViewCell", for: indexPath) as! SelectDesignTireTableViewCell
        
        if !self.tireTemplates.isEmpty  {
            
            if self.isSearch {
                selectDesignTireTableViewCell.initView(
                    tire : self.tireTemplatesSearch[indexPath.row]
                )
            }else{
                selectDesignTireTableViewCell.initView(
                    tire : self.tireTemplates[indexPath.row]
                )
            }
        }
        
        return selectDesignTireTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.isSearch {
            self.selectDesignTireVCDelegate?.selectDesignTire(data: self.tireTemplatesSearch[indexPath.row])
        }else{
            self.selectDesignTireVCDelegate?.selectDesignTire(data: self.tireTemplates[indexPath.row])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension SelectDesignTireVC: UITextFieldDelegate {
    
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
        
//        self.tireTemplatesSearch = (self.tireTemplates.filter { (tire: TireTemplates) -> Bool in
//            return tire.nameTireTemplate.lowercased().contains(textField.text!.lowercased())
//        })
//
//        if textField.text!.count > 0 {
//            self.isSearch = true
//        }else{
//            self.isSearch = false
//        }
//
//        self.tableView.reloadData()
        
        if textField.text!.isEmpty {
            self.viewModel.fetchDesignTire(q: "")
        }else{
            self.viewModel.fetchDesignTire(q: textField.text!)
        }
    }
}

extension SelectDesignTireVC: SelectDesignTireModelDelegate {
    
    func didFinishRefreshToken() {
        self.viewModel.fetchDesignTire(q: "")
    }
    
    func didFinishFetchingTireTemplates(_ status: statusWebService, tireTemplates: [TireTemplates]) {
        switch status {
        case .success :
            self.tireTemplates = tireTemplates
            self.tableView.reloadData()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

//
//  DesignTireAfterVC.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class DesignTireAfterVC: UIViewController {
    
    @IBOutlet weak var castTiresTemplateLabel: UILabel!
    @IBOutlet weak var searchTextField: placeHolderTextField!
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: DesignTireAfterModel!
    
    var tireTemplates: [TireTemplates] = []
    var designTireAfterVCDelegate: DesignTireAfterVCDelegate?
    var isSearch = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = DesignTireAfterModel(view: self)
        self.viewModel.fetchDesignTireAfter(q: "")
        UserDefaults.standard.set(true, forKey: "isNewTire")
        self.castTiresTemplateLabel.text = "cast_template_tires".localized
        self.searchTextField.placeholder = "search".localized
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: Extension datasource and delegate.
extension DesignTireAfterVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.isSearch {
            return self.tireTemplates.count
        }else{
            return self.tireTemplates.count
        }
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let designTireAfterTableViewCell = tableView.dequeueReusableCell(withIdentifier: "designTireAfterTableViewCell", for: indexPath) as! DesignTireAfterTableViewCell
        
        if !self.tireTemplates.isEmpty  {
            
            if self.isSearch {
//                selectDesignTireTableViewCell.initView(
//                    tire : self.tireTemplatesSearch[indexPath.row]
//                )
            }else{
                designTireAfterTableViewCell.initView(
                    tire : self.tireTemplates[indexPath.row]
                )
            }
        }
        
        return designTireAfterTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.isSearch {
//            self.selectDesignTireVCDelegate?.selectDesignTire(data: self.tireTemplatesSearch[indexPath.row])
        }else{
            self.designTireAfterVCDelegate?.selectDesignTireAfter(data: self.tireTemplates[indexPath.row])
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension DesignTireAfterVC: UITextFieldDelegate {
    
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
        
        if textField.text!.isEmpty {
            self.viewModel.fetchDesignTireAfter(q: "")
        }else{
            self.viewModel.fetchDesignTireAfter(q: textField.text!)
        }
    }
}

extension DesignTireAfterVC: DesignTireAfterModelDelegate {
    func didFinishRefreshToken() {
        self.viewModel.fetchDesignTireAfter(q: "")
    }
    
    func didFinishFetchingDesignTireAfter(_ status: statusWebService, tireTemplates: [TireTemplates]) {
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


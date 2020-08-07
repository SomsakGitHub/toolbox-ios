//
//  DialogCarDetailVC.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class DialogCarDetailVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: DialogCarDetailModel!
    
    var sizeTire: [SizeTire] = []
    
    var isDialogCarStructure = false
    var structureType = 1
    var isWheelQTY = false
    var isWheelQTYCar = false
    var isAxlesQTY = false
    var isAxlesQTYCar = false
    var isSizeTire = false
    var isBrandTire = false
    var isPatternTire = false
    var value = ""
    var data = [String]()
    var selectClick : ((String) -> Void) = {_ in }
    var selectClickType : ((SizeTire) -> Void) = {_ in }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = DialogCarDetailModel(view: self)
        initView()
    }
    
    func initView(){
        
        if isDialogCarStructure {
            switch structureType {
            case 1:
                if isAxlesQTY {
                    self.data = ["2", "3", "4", "5", "6", "7"]
                }else if isWheelQTY {
                    self.data = ["2", "4", "6", "8", "10", "12", "14", "16"]
                }else{
                    self.data = ["tractor".localized, "trailer".localized]
                }
                
                break
            case 2:
                if isAxlesQTY {
                    self.data = ["1", "2", "3", "4", "5", "6", "7", "8"]
                }else if isWheelQTY {
                    self.data = ["2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "22", "24", "26", "28", "30", "32"]
                }else if isWheelQTYCar {
                    self.data = ["2", "4", "6", "8", "10", "12", "14", "16", "18", "20", "24", "28", "32", "48"]
                }else{
                    self.data = ["tractor".localized, "trailer".localized]
                }
                break
            default:
                break
            }
        }else{
            switch true {
            case isSizeTire:
                self.viewModel.fetchSizeTire()
                break
            case isBrandTire:
                self.viewModel.fetchBrandTire()
                break
            case isPatternTire:
                self.viewModel.fetchPatternTire()
                break
            default:
                break
            }
        }
    }
    
    static func createDialog() -> DialogCarDetailVC {
        
        let customDialog: DialogCarDetailVC = UIStoryboard(name: "RegisterCar", bundle: nil)
            .instantiateViewController(withIdentifier: "dialogCarDetaill") as! DialogCarDetailVC
        customDialog.setDialog()
        
        return customDialog
    }
    
    func setDialog() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
}

//MARK: Extension datasource and delegate.
extension DialogCarDetailVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let dialogCarDetailTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dialogCarDetailTableViewCell", for: indexPath) as! DialogCarDetailTableViewCell
        
        if !self.data.isEmpty  {
        
            dialogCarDetailTableViewCell.initView(
                data : self.data[indexPath.row],
                isAxlesQTY: isAxlesQTY,
                isSizeTire: isSizeTire,
                isBrandTire: isBrandTire,
                isPatternTire: isPatternTire
            )
        }
        
        return dialogCarDetailTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        if isDialogCarStructure {
            self.selectClick(self.data[indexPath.row])
        }else{
            self.selectClickType(self.sizeTire[indexPath.row])
        }
        

//        self.carStructureVCDelegate?.selectcarStructure(data: self.carStructure[indexPath.row])
//        self.navigationController?.popViewController(animated: true)
    }
}

extension DialogCarDetailVC: DialogCarDetailModelDelegate {
    func didFinishRefreshToken(type: dialogCarDetailModelEnum) {
        switch type {
        case .fetchSizeTire:
            self.viewModel.fetchSizeTire()
            break
        case .fetchBrandTire:
            self.viewModel.fetchBrandTire()
            break
        case .fetchPatternTire:
            self.viewModel.fetchPatternTire()
            break
        default:
            break
        }
    }
    
    func didFinishFetchingSizeTire(_ status: statusWebService, sizeTire: [SizeTire]) {
        switch status {
        case .success :
            self.sizeTire = sizeTire
            
            let count = sizeTire.count
            
            for _ in 1...count {
                self.data.append("")
            }
            
            for i in 0...(count-1) {
                self.data[i] = sizeTire[i].name
            }
            
            self.tableView.reloadData()
            
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

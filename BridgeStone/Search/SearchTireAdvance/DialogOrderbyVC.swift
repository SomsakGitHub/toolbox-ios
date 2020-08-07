//
//  DialogOrderbyVC.swift
//  BridgeStone
//
//  Created by somsak on 30/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class DialogOrderbyVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectClick : ((String) -> Void) = {_ in }
    var data = [String]()
    var type: searchTireAdvanceStatus = .orderby
    var searchType: searchStatus = .car

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initView()
    }
    
    func initView(){
        
        switch self.type {
        case .orderby:
            self.data = ["sort_by_latest_date".localized, "sort_by_oldest_date".localized]
            break
        case .status:
            if searchType == .car {
                self.data = ["active".localized, "not_active".localized]
            }else{
                self.data = ["wait_retread".localized, "in_stock".localized, "waste_tires".localized, "in_car".localized]
            }
            break
        default:
            break
        }
    }
    
    static func createDialog() -> DialogOrderbyVC {
        
        let customDialog: DialogOrderbyVC = UIStoryboard(name: "SearchScreen", bundle: nil)
            .instantiateViewController(withIdentifier: "dialogOrderby") as! DialogOrderbyVC
        customDialog.setDialog()
        
        return customDialog
    }
    
    func setDialog() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
}

//MARK: Extension datasource and delegate.
extension DialogOrderbyVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let dialogOrderbyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "dialogOrderbyTableViewCell", for: indexPath) as! DialogOrderbyTableViewCell
        
        if !self.data.isEmpty  {
        
            dialogOrderbyTableViewCell.initView(
                value : self.data[indexPath.row]
            )
        }
        
        return dialogOrderbyTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectClick(self.data[indexPath.row])
    }
}

class DialogOrderbyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(value: String){
        self.nameLabel.text = value
    }
}


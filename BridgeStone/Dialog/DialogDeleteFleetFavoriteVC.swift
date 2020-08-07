//
//  DialogDeleteFleetFavoriteVC.swift
//  BridgeStone
//
//  Created by somsak on 6/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class DialogDeleteFleetFavoriteVC: UIViewController {
    
    @IBOutlet weak var cancelBTN: ButtonRound!
    @IBOutlet weak var saveBTN: ButtonRound!
    @IBOutlet weak var messagesLabel: UILabel!

    var didTapCancel : (() -> Void) = {}
    var didTapSave : (() -> Void) = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    @IBAction func cancelClick(_ sender: Any) {
        didTapCancel()
    }
    
    @IBAction func saveClick(_ sender: Any) {
        didTapSave()
    }
    
    func initView(){
        cancelBTN.setTitle("cancel".localized, for: .normal)
        saveBTN.setTitle("confirm".localized, for: .normal)
        self.messagesLabel.text = "you_want_remove_from_fleet_favorite".localized
    }
    
    static func createDialog() -> DialogDeleteFleetFavoriteVC {
        
        let customDialog: DialogDeleteFleetFavoriteVC = UIStoryboard(name: "DialogDeleteFleetFavorite", bundle: nil)
            .instantiateViewController(withIdentifier: "dialogDeleteFleetFavorite") as! DialogDeleteFleetFavoriteVC
        customDialog.setDialog()
        
        return customDialog
    }
    
    func setDialog() {
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
}

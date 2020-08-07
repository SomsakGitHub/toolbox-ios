//
//  RegisterTireSuccessVC.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class RegisterTireSuccessVC: UIViewController {
    
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var backToMenuBTN: ButtonRound!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.successLabel.text = "register_success".localized
        self.backToMenuBTN.setTitle("back_to_menu".localized, for: .normal)
    }
    
    @IBAction func backToHomeMenu(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "MenuScreen", bundle: nil)
        let menuVC: MenuVC = storyboard.instantiateViewController(withIdentifier: "menuVC") as! MenuVC
        self.navigationController?.pushViewController(menuVC, animated: true)
    }

}

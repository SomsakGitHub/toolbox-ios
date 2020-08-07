//
//  ChooseRegisterVC.swift
//  BridgeStone
//
//  Created by somsak on 29/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class ChooseRegisterVC: UIViewController {
    
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var registerCarBTN: ButtonRound!
    @IBOutlet weak var registerTireBTN: ButtonRound!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.topicLabel.text = "topic".localized
        self.contentLabel.text = "content".localized
        self.registerCarBTN.setTitle("register_car".localized, for: .normal)
        self.registerTireBTN.setTitle("register_tire".localized, for: .normal)
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func registerCarsClick(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isRegisterCar")
    }
    
    @IBAction func registerTireClick(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isRegisterCar")
    }
}

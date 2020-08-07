//
//  MenuView.swift
//  BridgeStone
//
//  Created by somsak on 29/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var searchTireLabel: UILabel!
    @IBOutlet weak var searchCarLabel: UILabel!
    
    @IBOutlet weak var profileSettingLabel: UILabel!
    @IBOutlet weak var manualLabel: UILabel!
    
    @IBOutlet weak var reportLabel: UILabel!
    @IBOutlet weak var logoutLabel: UILabel!
    
    func initView(){
        self.registerLabel.text = "register".localized
        self.searchTireLabel.text = "search_tire".localized
        self.searchCarLabel.text = "search_car".localized
        self.profileSettingLabel.text = "profile_setting".localized
        self.manualLabel.text = "manual".localized
        self.reportLabel.text = "report".localized
        self.logoutLabel.text = "logout".localized
    }
}

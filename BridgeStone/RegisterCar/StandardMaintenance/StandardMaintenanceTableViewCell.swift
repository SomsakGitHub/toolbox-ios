//
//  StandardMaintenanceTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class StandardMaintenanceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var policiesNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func initView(policies: Policies){
        self.policiesNameLabel.text = policies.name
    }
}

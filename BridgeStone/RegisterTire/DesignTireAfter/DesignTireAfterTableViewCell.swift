//
//  DesignTireAfterTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 18/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class DesignTireAfterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameTireTemplateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(tire: TireTemplates){
        self.nameTireTemplateLabel.text = tire.nameTireTemplate
    }

}

//
//  CarStructureTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 17/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class CarStructureTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var carNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(carStructure: CarStructure){
        self.carNameLabel.text = carStructure.name
    }

}

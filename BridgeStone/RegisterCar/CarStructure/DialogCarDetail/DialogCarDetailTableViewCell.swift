//
//  DialogHeadTailTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class DialogCarDetailTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(data: String, isAxlesQTY: Bool, isSizeTire: Bool, isBrandTire: Bool, isPatternTire: Bool){
        if data == "tractor" || data == "Tractor"  || data == "หัว"{
            self.nameLabel.text = "tractor".localized
        }else if data == "trailer" || data == "Trailer" || data == "หาง"{
            self.nameLabel.text = "trailer".localized
        }else{
            if isAxlesQTY {
                self.nameLabel.text = data + " "+"axles".localized
            }else{
                if isSizeTire || isBrandTire || isPatternTire {
                    self.nameLabel.text = data
                }else{
                    self.nameLabel.text = data + " "+"wheel".localized
                }
            }
        }
    }

}

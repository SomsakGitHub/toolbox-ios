//
//  AllFleetTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 21/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class AllFleetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var heartBTN: UIButton!
    @IBOutlet weak var selectBTN: UIButton!
    
    var didTapUnFavoriteBTN:( ()-> Void ) = {}
    var didTapFavoriteBTN:( ()-> Void ) = {}
    var didTapSelectBTN:( ()-> Void ) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configView(fleet: Fleet, isActive: Bool){
        self.companyLabel.text = fleet.name
        
        if isActive {
            self.heartBTN.isSelected = true
            self.heartBTN.setImage(UIImage(named: "heartRed"), for: .normal)
            
        }else{
            self.heartBTN.isSelected = false
            self.heartBTN.setImage(UIImage(named: "heart"), for: .normal)
        }
    }
    
    @IBAction func heartClick(_ sender: Any) {
        
        if self.heartBTN.isSelected {
            self.heartBTN.isSelected = false
            self.heartBTN.setImage(UIImage(named: "heart"), for: .normal)
            self.didTapUnFavoriteBTN()
        }else{
            self.heartBTN.isSelected = true
            self.heartBTN.setImage(UIImage(named: "heartRed"), for: .normal)
            self.didTapFavoriteBTN()
        }
    }
    
    @IBAction func selectClick(_ sender: Any) {
        self.didTapSelectBTN()
    }
}

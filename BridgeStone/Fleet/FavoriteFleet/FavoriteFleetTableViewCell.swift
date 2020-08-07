//
//  FavoriteFleetTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 29/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class FavoriteFleetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyImage: UIImageView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var detailBTN: UIButton!
    @IBOutlet weak var selectBTN: UIButton!
    
    var didTapSelectBTN:( ()-> Void ) = {}
    var didTapDetailBTN:( ()-> Void ) = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initView(fleet: Fleet){
        self.companyLabel.text = fleet.name
    }
    
    @IBAction func selectClick(_ sender: Any) {
        self.didTapSelectBTN()
    }
    
    @IBAction func detailClick(_ sender: Any) {
        self.didTapDetailBTN()
    }
}

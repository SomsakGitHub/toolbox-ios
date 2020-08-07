//
//  FleetView.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 20/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class FleetView: UIView {
    
    @IBOutlet var favoriteBTN: UIButton!
    @IBOutlet var allFleetBTN: UIButton!
    @IBOutlet var fleetContainerView: UIView!
    @IBOutlet var allFleetContainerView: UIView!
    @IBOutlet weak var didFinishAddFleetView: UIView!
    
    func resetContainerView(indexPathRow: Int){
        switch indexPathRow {
        case 0:
            self.favoriteBTN.backgroundColor = .black
            self.allFleetBTN.backgroundColor = UIColor(red: 53.0 / 255.0, green: 58.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
            self.fleetContainerView.isHidden = false
            self.allFleetContainerView.isHidden = true
            break
        case 1:
            self.favoriteBTN.backgroundColor = UIColor(red: 53.0 / 255.0, green: 58.0 / 255.0, blue: 80.0 / 255.0, alpha: 1.0)
            self.allFleetBTN.backgroundColor = .black
            self.fleetContainerView.isHidden = true
            self.allFleetContainerView.isHidden = false
            break
        default:
            break
        }
    }
}

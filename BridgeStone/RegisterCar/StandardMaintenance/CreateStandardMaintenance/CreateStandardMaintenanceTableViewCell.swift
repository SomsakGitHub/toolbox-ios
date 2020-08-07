//
//  CreateStandardMaintenanceTableViewCell.swift
//  BridgeStone
//
//  Created by somsak on 21/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class CreateStandardMaintenanceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var axlesNameLabel: UILabel!
    @IBOutlet weak var axlesNameTextField: placeHolderTextField!
    @IBOutlet weak var errorNameTextFieldImage: UIImageView!
    
    @IBOutlet weak var axles1Label: UILabel!
    @IBOutlet weak var depthAxles1: placeHolderTextField!
    @IBOutlet weak var depthAxles1Image: UIImageView!
    @IBOutlet weak var pressureAxles1: placeHolderTextField!
    @IBOutlet weak var pressureAxles1Image: UIImageView!
    @IBOutlet weak var axles2Label: UILabel!
    @IBOutlet weak var depthAxles2: placeHolderTextField!
    @IBOutlet weak var depthAxles2Image: UIImageView!
    @IBOutlet weak var pressureAxles2: placeHolderTextField!
    @IBOutlet weak var pressureAxles2Image: UIImageView!
    @IBOutlet weak var axles3Label: UILabel!
    @IBOutlet weak var depthAxles3: placeHolderTextField!
    @IBOutlet weak var depthAxles3Image: UIImageView!
    @IBOutlet weak var pressureAxles3: placeHolderTextField!
    @IBOutlet weak var pressureAxles3Image: UIImageView!
    @IBOutlet weak var axles4Label: UILabel!
    @IBOutlet weak var depthAxles4: placeHolderTextField!
    @IBOutlet weak var depthAxles4Image: UIImageView!
    @IBOutlet weak var pressureAxles4: placeHolderTextField!
    @IBOutlet weak var pressureAxles4Image: UIImageView!
    @IBOutlet weak var axles5Label: UILabel!
    @IBOutlet weak var depthAxles5: placeHolderTextField!
    @IBOutlet weak var depthAxles5Image: UIImageView!
    @IBOutlet weak var pressureAxles5: placeHolderTextField!
    @IBOutlet weak var pressureAxles5Image: UIImageView!
    @IBOutlet weak var axles6Label: UILabel!
    @IBOutlet weak var depthAxles6: placeHolderTextField!
    @IBOutlet weak var depthAxles6Image: UIImageView!
    @IBOutlet weak var pressureAxles6: placeHolderTextField!
    @IBOutlet weak var pressureAxles6Image: UIImageView!
    @IBOutlet weak var axles7Label: UILabel!
    @IBOutlet weak var depthAxles7: placeHolderTextField!
    @IBOutlet weak var depthAxles7Image: UIImageView!
    @IBOutlet weak var pressureAxles7: placeHolderTextField!
    @IBOutlet weak var pressureAxles7Image: UIImageView!
    @IBOutlet weak var axles8Label: UILabel!
    @IBOutlet weak var depthAxles8: placeHolderTextField!
    @IBOutlet weak var depthAxles8Image: UIImageView!
    @IBOutlet weak var pressureAxles8: placeHolderTextField!
    @IBOutlet weak var pressureAxles8Image: UIImageView!
    @IBOutlet weak var saveBTN: ButtonRound!
    
    var didTapSaveDelegate:( ()-> Void ) = {}
    var didTapTireDepthAxles1Delegate:( ()-> Void ) = {}
    var didTapTirePressureAxles1Delegate:( ()-> Void ) = {}
    var didTapTireDepthAxles2Delegate:( ()-> Void ) = {}
    var didTapTirePressureAxles2Delegate:( ()-> Void ) = {}
    var didTapTireDepthAxles3Delegate:( ()-> Void ) = {}
    var didTapTirePressureAxles3Delegate:( ()-> Void ) = {}
    var didTapTireDepthAxles4Delegate:( ()-> Void ) = {}
    var didTapTirePressureAxles4Delegate:( ()-> Void ) = {}
    var didTapTireDepthAxles5Delegate:( ()-> Void ) = {}
    var didTapTirePressureAxles5Delegate:( ()-> Void ) = {}
    var didTapTireDepthAxles6Delegate:( ()-> Void ) = {}
    var didTapTirePressureAxles6Delegate:( ()-> Void ) = {}
    var didTapTireDepthAxles7Delegate:( ()-> Void ) = {}
    var didTapTirePressureAxles7Delegate:( ()-> Void ) = {}
    var didTapTireDepthAxles8Delegate:( ()-> Void ) = {}
    var didTapTirePressureAxles8Delegate:( ()-> Void ) = {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func didTapTireDepthAxles1(_ sender: Any) {
        self.didTapTireDepthAxles1Delegate()
    }
    
    @IBAction func didTapTirePressureAxles1(_ sender: Any) {
        self.didTapTirePressureAxles1Delegate()
    }
    
    @IBAction func didTapTireDepthAxles2(_ sender: Any) {
        self.didTapTireDepthAxles2Delegate()
    }
    
    @IBAction func didTapTirePressureAxles2(_ sender: Any) {
        self.didTapTirePressureAxles2Delegate()
    }
    
    @IBAction func didTapTireDepthAxles3(_ sender: Any) {
        self.didTapTireDepthAxles3Delegate()
    }

    @IBAction func didTapTirePressureAxles3(_ sender: Any) {
        self.didTapTirePressureAxles3Delegate()
    }

    @IBAction func didTapTireDepthAxles4(_ sender: Any) {
        self.didTapTireDepthAxles4Delegate()
    }

    @IBAction func didTapTirePressureAxles4(_ sender: Any) {
        self.didTapTirePressureAxles4Delegate()
    }
    
    @IBAction func didTapTireDepthAxles5(_ sender: Any) {
        self.didTapTireDepthAxles5Delegate()
    }

    @IBAction func didTapTirePressureAxles5(_ sender: Any) {
        self.didTapTirePressureAxles5Delegate()
    }
    
    @IBAction func didTapTireDepthAxles6(_ sender: Any) {
        self.didTapTireDepthAxles6Delegate()
    }

    @IBAction func didTapTirePressureAxles6(_ sender: Any) {
        self.didTapTirePressureAxles6Delegate()
    }
    
    @IBAction func didTapTireDepthAxles7(_ sender: Any) {
        self.didTapTireDepthAxles7Delegate()
    }

    @IBAction func didTapTirePressureAxles7(_ sender: Any) {
        self.didTapTirePressureAxles7Delegate()
    }
    
    @IBAction func didTapTireDepthAxles8(_ sender: Any) {
        self.didTapTireDepthAxles8Delegate()
    }

    @IBAction func didTapTirePressureAxles8(_ sender: Any) {
        self.didTapTirePressureAxles8Delegate()
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        self.didTapSaveDelegate()
    }
}

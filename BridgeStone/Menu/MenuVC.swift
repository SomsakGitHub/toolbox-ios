//
//  MenuVC.swift
//  BridgeStone
//
//  Created by somsak on 29/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    
    @IBOutlet var menuView: MenuView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.menuView.initView()
        UserDefaults.standard.set(false, forKey: "isSaveJobSite")
        
    }
    
    @IBAction func registerClick(_ sender: Any) {
        self.performSegue(withIdentifier: "goToChooseRegister", sender: self)
    }
    
    @IBAction func searchTiresClick(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isSearchTire")
        self.performSegue(withIdentifier: "goToSearch", sender: self)
    }
    
    @IBAction func searchCarsClick(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isSearchTire")
        self.performSegue(withIdentifier: "goToSearch", sender: self)
    }
    
    @IBAction func profileClick(_ sender: Any) {
        self.performSegue(withIdentifier: "goToProfile", sender: self)
    }
    
    @IBAction func guideClick(_ sender: Any) {
        
    }
    
    @IBAction func reportFleetClick(_ sender: Any) {
        
    }
    
    @IBAction func logoutClick(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVC: ViewController = storyboard.instantiateViewController(withIdentifier: "login") as! ViewController
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
}

//
//  FleetVC.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 19/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit
import CoreData

class FleetVC: UIViewController, AddNewFleetVCDelegate {
    
    @IBOutlet weak var fleetView: FleetView!
    
    var favoriteFleet: [FavoriteFleet] = []
    
    var selectedFleetView = 0
    var didFinishAddFleetTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.fleetView.favoriteBTN.setTitle("favorite".localized, for: .normal)
        self.fleetView.allFleetBTN.setTitle("all_fleet".localized, for: .normal)
        
        favoriteFleet = CoreDataManager().fetchFavoriteFleet()
        
        
        for i in favoriteFleet {
            print("i", i.name as Any)
        }
    }

    func initView(){
        self.fleetView.allFleetContainerView.isHidden = true
        self.fleetView.resetContainerView(indexPathRow: 0)
    }
    
    @IBAction func favoriteClick(_ sender: Any) {
        self.selectedFleetView = 0
        self.fleetView.resetContainerView(indexPathRow: 0)
        NotificationCenter.default.post(name: Notification.Name("OnFetchFavoriteFleet"), object: nil)
    }
    
    @IBAction func allFleetClick(_ sender: Any) {
        self.selectedFleetView = 1
        self.fleetView.resetContainerView(indexPathRow: 1)
        NotificationCenter.default.post(name: Notification.Name("OnFetchAllFleet"), object: nil)
    }
    
    func addNewFleet(status: Bool) {
        self.fleetView.didFinishAddFleetView.isHidden = false
        var time = 0
        
        self.didFinishAddFleetTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if time >= 3 {
                self.fleetView.didFinishAddFleetView.isHidden = true
                timer.invalidate()
            }else{
                time += 1
            }
        }
    }
        
        //MARK: Pass data with segue.
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let addNewFleetVC = segue.destination as? AddNewFleetVC {
    //            btsViewController.station = self.stations
                addNewFleetVC.addNewFleetVCDelegate = self
            }
        }
}

////MARK: Extension datasource and delegate.
//extension FleetVC: UICollectionViewDelegate, UICollectionViewDataSource{
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//           return 2
//       }
//       
//       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//           let fleetCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "fleetCollectionViewCell", for: indexPath) as! FleetCollectionViewCell
//               
//           fleetCollectionViewCell.configView(cell: indexPath.row)
//           
//           if indexPath.row == self.selectedFleetViewCell{
//               fleetCollectionViewCell.resetView(isActive: true)
//           }else{
//               fleetCollectionViewCell.resetView(isActive: false)
//           }
//    
//           return fleetCollectionViewCell
//       }
//           
//       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//           self.selectedFleetViewCell = indexPath.row
//           self.fleetCollectionView.reloadData()
//           
//           fleetView.resetContainerView(indexPathRow: indexPath.row)
//       }
//}

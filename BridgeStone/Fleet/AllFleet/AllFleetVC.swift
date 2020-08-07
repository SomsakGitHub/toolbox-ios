//
//  AllFleetVC.swift
//  BridgeStone
//
//  Created by somsak on 21/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class AllFleetVC: UIViewController {
    
    @IBOutlet weak var dataTableView: UITableView!
    
    private var viewModel: AllFleetModel!
    var favoriteFleet: [FavoriteFleets] = []
    var fleets: [Fleet] = []
    var fleetID = 0
    var fleetsID = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = AllFleetModel(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewModel.fetchFavoriteFleet()
        NotificationCenter.default.addObserver(self, selector: #selector(onFetchAllFleet), name: Notification.Name("OnFetchAllFleet"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("OnFetchAllFleet"), object: nil)
    }
    
    @objc func onFetchAllFleet() {
        self.viewModel.fetchFavoriteFleet()
    }
}

//MARK: Extension datasource and delegate.
extension AllFleetVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fleets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let allFleetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "allFleetTableViewCell", for: indexPath) as! AllFleetTableViewCell
        
        if !self.fleets.isEmpty  {
            
            let isActiveID = self.favoriteFleet.contains { (test) -> Bool in
                return String(test.fleetsID) == self.fleets[indexPath.row].id
            }
            
            allFleetTableViewCell.configView(
                fleet: self.fleets[indexPath.row],
                isActive: isActiveID
            )
        }
        
        allFleetTableViewCell.didTapUnFavoriteBTN = {
            let dataFleetsID = Int(self.fleets[indexPath.row].id)

            for i in self.favoriteFleet {
                if i.fleetsID ==  dataFleetsID{
                    self.fleetsID = i.id
                }
            }

            self.viewModel.deleteFleetFavorite(id: self.fleetsID)
        }
        
        allFleetTableViewCell.didTapFavoriteBTN = {
            
//            UserManager.shared.saveFavoriteFleet(
//                favoriteFleet: self.fleets[indexPath.row].name
//            )
            self.fleetID = Int(self.fleets[indexPath.row].id)!
            
            self.viewModel.saveFleetfavorite(id: self.fleetsID)
        }
        
        allFleetTableViewCell.didTapSelectBTN = {
            UserDefaults.standard.set(self.fleets[indexPath.row].id, forKey: "fleetID")
            self.performSegue(withIdentifier: "goToMenu", sender: self)
        }
        
        return allFleetTableViewCell
    }
}

extension AllFleetVC: AllFleetModelDelegate {
    func didFinishRefreshToken(type: allFleetModelEnum) {
        switch type {
        case .fetchFleet :
            self.viewModel.fetchFleet()
            break
        case .fetchFavoriteFleet:
            self.viewModel.fetchFavoriteFleet()
            break
        case .saveFleetfavorite:
            self.viewModel.saveFleetfavorite(id: self.fleetID)
            break
        case .deleteFleetFavorite:
            self.viewModel.deleteFleetFavorite(id: self.fleetsID)
            break
        default :
            break
        }
    }
    
    func didFinishFetchingFavoriteFleet(_ status: statusWebService, favoriteFleet: [FavoriteFleets]) {
        
        switch status {
        case .success :
            self.favoriteFleet = favoriteFleet
            self.viewModel.fetchFleet()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishFetchingAllFleet(_ status: statusWebService, fleet: [Fleet]) {
        switch status {
        case .success :
            self.fleets = fleet
            self.dataTableView.reloadData()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishSaveFleetfavorite(_ status: statusWebService) {
        
    }
    
    func didFinishFetchingDeleteFleetFavorite(_ status: statusWebService) {
        
    }
}


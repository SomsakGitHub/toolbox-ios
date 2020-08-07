//
//  FavoriteFleetVC.swift
//  BridgeStone
//
//  Created by somsak on 22/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class FavoriteFleetVC: UIViewController {
    
    @IBOutlet weak var dataTableView: UITableView!
    
    private var viewModel: FavoriteFleetModel!
    var fleets: [Fleet] = []
    var favoriteFleet: [FavoriteFleets] = []
    var dataFleets: [Fleet] = []
    var fleetsID = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.viewModel = FavoriteFleetModel(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.viewModel.fetchFleet()
        NotificationCenter.default.addObserver(self, selector: #selector(onFetchFavoriteFleet), name: Notification.Name("OnFetchFavoriteFleet"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("OnFetchFavoriteFleet"), object: nil)
    }
    
    @objc func onFetchFavoriteFleet() {
        self.viewModel.fetchFleet()
    }
    
    func createDialogDeleteFleetFavorite(completion:@escaping (Bool) -> Void){
        let customDialog  = DialogDeleteFleetFavoriteVC.createDialog()
        
        customDialog.didTapCancel = {
            customDialog.dismiss(animated: true){
                completion(false)
            }
        }
        
        customDialog.didTapSave = {
            customDialog.dismiss(animated: true) {
                completion(true)
            }
        }

        self.present(customDialog, animated: true, completion: nil)
    }
}

//MARK: Extension datasource and delegate.
extension FavoriteFleetVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataFleets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let favoriteFleetTableViewCell = tableView.dequeueReusableCell(withIdentifier: "favoriteFleetTableViewCell", for: indexPath) as! FavoriteFleetTableViewCell
        
        if !self.dataFleets.isEmpty  {
            favoriteFleetTableViewCell.initView(
                fleet : self.dataFleets[indexPath.row]
            )
        }
        
        favoriteFleetTableViewCell.didTapSelectBTN = {
            UserDefaults.standard.set(self.dataFleets[indexPath.row].id, forKey: "fleetID")
            self.performSegue(withIdentifier: "goToMenu", sender: self)
        }
        
        favoriteFleetTableViewCell.didTapDetailBTN = {
            self.createDialogDeleteFleetFavorite() { (isConfirm) in
                if isConfirm {
                    
                    let dataFleetsID = Int(self.dataFleets[indexPath.row].id)
                    
                    for i in self.favoriteFleet {
                        if i.fleetsID ==  dataFleetsID{
                            self.fleetsID = i.id
                        }
                    }
                    
                    self.viewModel.deleteFleetFavorite(id: self.fleetsID)
                }
            }
            
        }
        
        return favoriteFleetTableViewCell
    }
}

extension FavoriteFleetVC: FavoriteFleetModelDelegate {
    func didFinishRefreshToken(type: favoriteFleetModelEnum) {
        switch type {
        case .fetchFleet:
            self.viewModel.fetchFleet()
            break
        case .fetchFavoriteFleet:
            self.viewModel.fetchFavoriteFleet()
            break
        case .deleteFleetFavorite:
            self.viewModel.deleteFleetFavorite(id: self.fleetsID)
            break
        default :
            break
        }
    }
    
    func didFinishFetchingAllFleet(_ status: statusWebService, fleet: [Fleet]) {
        switch status {
        case .success :
            self.fleets = fleet
            self.viewModel.fetchFavoriteFleet()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishFetchingFavoriteFleet(_ status: statusWebService, favoriteFleet: [FavoriteFleets]) {
        
        switch status {
        case .success :
            self.favoriteFleet = favoriteFleet
            self.dataFleets = []
        
            for i in self.favoriteFleet {
                let temp = String(i.fleetsID)
                for j in self.fleets {
                    if temp == j.id {
                        self.dataFleets.append(j)
                    }
                }
            }
            
            self.dataFleets = self.dataFleets.reversed()
            
//            for i in self.favoriteFleet {
//                let temp = String(i.fleetsID)
//                var index = -1
//
//                repeat {
//                    index += 1
//                    print("index", index)
//                } while self.fleets[index].id == temp
//
//                self.dataFleets.append(self.fleets[index])
//            }
            
            self.dataTableView.reloadData()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishFetchingDeleteFleetFavorite(_ status: statusWebService) {
        switch status {
        case .success :
            self.viewModel.fetchFavoriteFleet()
            self.dataTableView.reloadData()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

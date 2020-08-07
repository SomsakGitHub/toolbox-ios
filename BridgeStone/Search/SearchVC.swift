//
//  SearchVC.swift
//  BridgeStone
//
//  Created by somsak on 19/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, SearchTireAdvanceVCDelegate, SearchCarAdvanceVCDelegate {
    
    
    @IBOutlet weak var searchListLabel: UILabel!
    @IBOutlet weak var searchTextField: placeHolderTextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var jobSiteLabel: UILabel!
    @IBOutlet weak var jobSiteColorView: UIView!
    @IBOutlet weak var searchCarLabel: UILabel!
    @IBOutlet weak var searchCarColorView: UIView!
    @IBOutlet weak var searchTireLabel: UILabel!
    @IBOutlet weak var searchTireColorView: UIView!
    @IBOutlet weak var allResult: UILabel!
    @IBOutlet weak var searchAdvanceBTN: UIButton!
    
    
    private var viewModel: SearchModel!
    let isSearchTire = UserDefaults.standard.bool(forKey: "isSearchTire")
    var typeStatus = 0
    var tire: [Tire] = []
    var car: [Car] = []
    var carDetailId = 0
    var carPoliciesId = 0
    var jobsites: [Jobsites] = []
    var param: [String] = ["", "", "", "", "", ""]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = SearchModel(view: self)
        
        if self.isSearchTire {
            self.typeStatus = 3
            self.viewModel.fetchTire(params: param)
        }else{
            self.typeStatus = 2
            self.viewModel.fetchCar(params: param)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.searchListLabel.text = "search_list".localized
        self.jobSiteLabel.text = "job_site_car".localized
        self.searchCarLabel.text = "search_car".localized
        self.searchTireLabel.text = "search_tire".localized
        self.searchTextField.placeholder = "search".localized
        if self.typeStatus == 2 {
            self.viewModel.fetchCar(params: param)
        }
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapJobSite(_ sender: Any) {
        self.typeStatus = 1
        self.param[0] = ""
        self.searchTextField.text = ""
        self.viewModel.fetchJobSite(params: param)
        self.searchAdvanceBTN.isHidden = true
    }
    
    @IBAction func didTapSearchCar(_ sender: Any) {
        self.typeStatus = 2
        self.param[0] = ""
        self.viewModel.fetchCar(params: param)
        self.searchTextField.text = ""
        self.searchAdvanceBTN.isHidden = false
    }
    
    @IBAction func didTapSearchTire(_ sender: Any) {
        self.typeStatus = 3
        self.param[0] = ""
        self.viewModel.fetchTire(params: param)
        self.searchTextField.text = ""
        self.searchAdvanceBTN.isHidden = false
    }
    
    @IBAction func didTapSearchAdvance(_ sender: Any) {
        
        switch self.typeStatus {
        case 2:
            performSegue(withIdentifier: "goToSearchCarAdvance", sender: self)
            break
        case 3:
            performSegue(withIdentifier: "goToSearchTireAdvance", sender: self)
            break
        default:
            break
        }
    }
    
    func resetSearchType(type: Int){
        switch type {
        case 1:
            self.jobSiteLabel.textColor = UIColor(red: 189.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
            self.searchCarLabel.textColor = UIColor(red: 213.0 / 255.0, green: 221.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
            self.searchTireLabel.textColor = UIColor(red: 213.0 / 255.0, green: 221.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
            
            self.jobSiteColorView.backgroundColor = UIColor(red: 189.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
            self.searchCarColorView.backgroundColor = .clear
            self.searchTireColorView.backgroundColor = .clear
            break
        case 2:
            self.jobSiteLabel.textColor = UIColor(red: 213.0 / 255.0, green: 221.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
            self.searchCarLabel.textColor = UIColor(red: 189.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
            self.searchTireLabel.textColor = UIColor(red: 213.0 / 255.0, green: 221.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
            
            self.jobSiteColorView.backgroundColor = .clear
            self.searchCarColorView.backgroundColor = UIColor(red: 189.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
            self.searchTireColorView.backgroundColor = .clear
            break
        case 3:
            self.jobSiteLabel.textColor = UIColor(red: 213.0 / 255.0, green: 221.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
            self.searchCarLabel.textColor = UIColor(red: 213.0 / 255.0, green: 221.0 / 255.0, blue: 224.0 / 255.0, alpha: 1.0)
            self.searchTireLabel.textColor = UIColor(red: 189.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
            
            self.jobSiteColorView.backgroundColor = .clear
            self.searchCarColorView.backgroundColor = .clear
            self.searchTireColorView.backgroundColor = UIColor(red: 189.0 / 255.0, green: 30.0 / 255.0, blue: 30.0 / 255.0, alpha: 1.0)
            break
        default:
            
            break
        }
    }
    
    func searchTireAdvanceData(params: [String]) {
        self.searchTextField.text = ""
        self.viewModel.fetchTire(params: params)
    }
    
    func searchCarAdvanceData(params: [String]) {
        self.searchTextField.text = ""
        self.viewModel.fetchCar(params: params)
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let searchTireAdvanceVC = segue.destination as? SearchTireAdvanceVC {
            //            btsViewController.station = self.stations
            searchTireAdvanceVC.searchTireAdvanceVCDelegate = self
        }else if let searchCarAdvanceVC = segue.destination as? SearchCarAdvanceVC {
            //            btsViewController.station = self.stations
            searchCarAdvanceVC.searchCarAdvanceVCDelegate = self
        }else if let carDetailVC = segue.destination as? CarDetailVC {
            carDetailVC.carDetailId = self.carDetailId
            carDetailVC.carPoliciesId = self.carPoliciesId
//            carDetailVC.searchCarAdvanceVCDelegate = self
        }
    }
}

//MARK: Extension datasource and delegate.
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var cellInt = 0
        
        switch self.typeStatus {
        case 1:
            cellInt = self.jobsites.count
            break
        case 2:
            cellInt = self.car.count
            break
        case 3:
            cellInt =  self.tire.count
            break
        default:
            break
        }
        
        return cellInt
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let searchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "searchTableViewCell", for: indexPath) as! SearchTableViewCell
        
        switch self.typeStatus {
        case 1:
            if !self.jobsites.isEmpty {
                searchTableViewCell.initViewJobsites(
                    jobsites : self.jobsites[indexPath.row]
                )
            }
            break
        case 2:
            if !self.car.isEmpty  {
                searchTableViewCell.initViewCar(
                    car : self.car[indexPath.row]
                )
            }
            break
        case 3:
            if !self.tire.isEmpty  {
                searchTableViewCell.initViewTire(
                    tire : self.tire[indexPath.row]
                )
            }
            break
        default:
            break
        }
        
        return searchTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.typeStatus {
        case 1:
            
            break
        case 2:
            self.carDetailId = self.car[indexPath.row].id
            self.carPoliciesId = self.car[indexPath.row].carPolicies.id
            self.performSegue(withIdentifier: "goToDetail", sender: self)
            break
        case 3:
            break
        default:
            break
        }

//        self.carStructureVCDelegate?.selectcarStructure(data: self.carStructure[indexPath.row])
//        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {

        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        self.param[0] = textField.text!
        
        switch self.typeStatus {
        case 1:
            self.viewModel.fetchJobSite(params: self.param)
            break
        case 2:
            self.viewModel.fetchCar(params: self.param)
            break
        case 3:
            self.viewModel.fetchTire(params: self.param)
            break
        default:
            break
        }
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {

        
    }
    
}

extension SearchVC: SearchModelDelegate {
    
    func didFinishRefreshToken(type: searchModelEnum) {
        switch type {
        case .fetchTire:
            self.viewModel.fetchTire(params: param)
            break
        case .fetchCar:
            self.viewModel.fetchCar(params: param)
            break
        case .fetchJobSite:
            self.viewModel.fetchJobSite(params: param)
            break
        default :
            break
        }
    }
    
    func didFinishFetchingCar(_ status: statusWebService, car: [Car]) {
        switch status {
        case .success :
            self.car = car
            resetSearchType(type: 2)
            self.tableView.reloadData()
            self.allResult.text = "all_result".localized + " \(self.car.count) " + "list".localized
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishFetchingTire(_ status: statusWebService, tire: [Tire]) {
        switch status {
        case .success :
            self.tire = tire
            resetSearchType(type: 3)
            self.tableView.reloadData()
            self.allResult.text = "all_result".localized + " \(self.tire.count) " + "list".localized
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishFetchingJobsites(_ status: statusWebService, jobsites: [Jobsites]) {
        switch status {
        case .success :
            self.jobsites = jobsites
            resetSearchType(type: 1)
            self.tableView.reloadData()
            self.allResult.text = "all_result".localized + " \(self.jobsites.count) " + "list".localized
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    
}

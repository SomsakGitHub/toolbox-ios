//
//  JobSiteVC.swift
//  BridgeStone
//
//  Created by somsak on 16/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class JobSiteVC: UIViewController {
    
    
    @IBOutlet weak var jobSiteLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var jobsites: [Jobsites] = []
    
    private var viewModel: JobSiteModel!
    var selectJobSiteVCDelegate: SelectJobSiteVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = JobSiteModel(view: self)
        self.viewModel.fetchJobSite()
        self.jobSiteLabel.text = "select_job_site".localized
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func didTapAddJobSite(_ sender: Any) {
        self.createDialogAddJobSite() { (isSave) in
            
            let isRegisterCar = UserDefaults.standard.bool(forKey: "isRegisterCar")
            
            if isSave {
                
//                if isRegisterCar {
//                    let storyboard : UIStoryboard = UIStoryboard(name: "RegisterCar", bundle: nil)
//                    let registerCarVC: RegisterCarVC = storyboard.instantiateInitialViewController() as! RegisterCarVC
//                    self.navigationController?.pushViewController(registerCarVC, animated: true)
//                }else{
//                    let storyboard : UIStoryboard = UIStoryboard(name: "RegisterTire", bundle: nil)
//                    let registerTireVC: RegisterTireVC = storyboard.instantiateInitialViewController() as! RegisterTireVC
//                    self.navigationController?.pushViewController(registerTireVC, animated: true)
//                }
                
                UserDefaults.standard.set(true, forKey: "isSaveJobSite")
                
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 2], animated: true)
            }
        }
    }
    
    func createDialogAddJobSite(completion:@escaping (Bool) -> Void){
        let customDialog = DialogAddJobSiteVC.createDialog()
        
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
extension JobSiteVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.jobsites.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let jobSiteTableViewCell = tableView.dequeueReusableCell(withIdentifier: "jobSiteTableViewCell", for: indexPath) as! JobSiteTableViewCell
        
        if !self.jobsites.isEmpty  {
        
            jobSiteTableViewCell.initView(
                jobsites : self.jobsites[indexPath.row]
            )
        }
        
        return jobSiteTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        self.selectJobSiteVCDelegate?.selectJobSite(data: self.jobsites[indexPath.row])
        
        self.navigationController?.popViewController(animated: true)
    }
}


extension JobSiteVC: JobSiteModelDelegate {
    func didFinishRefreshToken() {
        self.viewModel.fetchJobSite()
    }
    
    func didFinishFetchingJobSite(_ status: statusWebService, jobsites: [Jobsites]) {
        switch status {
        case .success :
            self.jobsites = jobsites
            self.tableView.reloadData()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

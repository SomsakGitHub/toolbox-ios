//
//  ProfileVC.swift
//  BridgeStone
//
//  Created by somsak on 1/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var dataTableView: UITableView!

    private var viewModel: ProfileModel!
    
    var getNameOnTextField:(() -> (String))!
    var getlastNameOnTextField:(() -> (String))!
    var getPhoneOnTextField:(() -> (String))!
    var getLanguageSelected:(() -> (String))!
    var profile: [Profile]? = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = ProfileModel(view: self)
        self.dismissKeyboardOnDidTabView()
        self.viewModel.fetchProfile()
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
    
    func selectLanguage(completion:@escaping (String) -> Void){
        let actionSheetAlertController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let languages = ["English", "ภาษาไทย"]
        
        for index in languages {
            let action = UIAlertAction(title: index, style: .default) { (action) in
                completion(index)
            }
            
            action.setValue(UIColor.black, forKey: "titleTextColor")
            
            actionSheetAlertController.addAction(action)
        }

        let cancelActionButton = UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil)
        cancelActionButton.setValue(UIColor.black, forKey: "titleTextColor")

        actionSheetAlertController.addAction(cancelActionButton)

        if UIDevice.current.userInterfaceIdiom == .pad{
            let cancelIPadActionButton = UIAlertAction(title: "cancel".localized, style: .default, handler: nil)
            cancelIPadActionButton.setValue(UIColor.black, forKey: "titleTextColor")
            actionSheetAlertController.addAction(cancelIPadActionButton)
            
            actionSheetAlertController.popoverPresentationController?.sourceView = self.view
            actionSheetAlertController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY, width: 0, height: 0)
            actionSheetAlertController.popoverPresentationController?.permittedArrowDirections = []
            self.present(actionSheetAlertController, animated: true, completion: nil)
        }else{
            self.present(actionSheetAlertController, animated: true, completion: nil)
        }
    }
    
    func dismissKeyboardOnDidTabView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

//MARK: Extension datasource and delegate.
extension ProfileVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = ProfileTableViewCell()
            
        switch indexPath.row {
        case 0:
            let imageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "imageTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            if !self.profile!.isEmpty {
                imageTableViewCell.initView(data: self.profile![0])
            }
            
            cell = imageTableViewCell
            break
        case 1:
            let nameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "nameTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            if !self.profile!.isEmpty {
                nameTableViewCell.nameTextField.text = self.profile![0].firstName
            }
            
            getNameOnTextField = {
                return nameTableViewCell.nameTextField.text!
            }
            
            cell = nameTableViewCell
            break
        case 2:
            let lastnameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "lastnameTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            if !self.profile!.isEmpty {
                lastnameTableViewCell.lastnameTextField.text = self.profile![0].lastName
            }
            
            getlastNameOnTextField = {
                return lastnameTableViewCell.lastnameTextField.text!
            }
            
            cell = lastnameTableViewCell
            break
        case 3:
            let phoneTableViewCell = tableView.dequeueReusableCell(withIdentifier: "phoneTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            if !self.profile!.isEmpty {
                phoneTableViewCell.phoneTextField.text = self.profile![0].mobileNumber
            }
            
            getPhoneOnTextField = {
                return phoneTableViewCell.phoneTextField.text!
            }
            
            cell = phoneTableViewCell
            break
        case 4:
            let languageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "languageTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            if !self.profile!.isEmpty {
                if self.profile![0].language == "en" || self.profile![0].language == "EN" {
                    languageTableViewCell.languageImage.image = UIImage(named: "ImageEng")
                    languageTableViewCell.languageLabel.text = "English"
                }else{
                    languageTableViewCell.languageImage.image = UIImage(named: "ImageThai")
                    languageTableViewCell.languageLabel.text = "ภาษาไทย"
                }
            }
            
            languageTableViewCell.didTapLanguageBTN = {
                self.selectLanguage() {(language) in
                    languageTableViewCell.languageLabel.text = language
                    
                    if language == "English"{
                        languageTableViewCell.languageImage.image = UIImage(named: "ImageEng")
                    }else{
                        languageTableViewCell.languageImage.image = UIImage(named: "ImageThai")
                    }
                }
            }
            
            getLanguageSelected = {
                var languageSelected = ""
                
                if languageTableViewCell.languageLabel.text == "English"{
                    languageSelected = "EN"
                }else{
                    languageSelected = "TH"
                }
                
                return languageSelected
            }
            
            cell = languageTableViewCell
            break
        case 5:
            let saveTableViewCell = tableView.dequeueReusableCell(withIdentifier: "saveTableViewCell", for: indexPath) as! ProfileTableViewCell
            
            if !self.profile!.isEmpty {
                if self.profile![0].language == "en" || self.profile![0].language == "EN" {
                    saveTableViewCell.saveBTN.setTitle("Save", for: .normal)
                }else{
                    saveTableViewCell.saveBTN.setTitle("บันทึกข้อมูล", for: .normal)
                }
            }
            
            saveTableViewCell.didTapSaveBTN = {
                self.viewModel.editProfile(
                    name: self.getNameOnTextField(),
                    lastName: self.getlastNameOnTextField(),
                    phone: self.getPhoneOnTextField(),
                    language: self.getLanguageSelected()
                )
            }
            
            cell = saveTableViewCell
            break
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 100
        case 1:
            return 75
        case 2:
            return 75
        case 3:
            return 75
        case 4:
            return 75
        case 5:
            return 100
        default:
            break
        }
        
        return CGFloat()
    }
}

extension ProfileVC: ProfileModelDelegate {
    func didFinishRefreshToken(type: profileModelEnum) {
        switch type {
        case .fetchProfile :
            self.viewModel.fetchProfile()
            break
        case .editProfile:
            self.viewModel.editProfile(
                name: self.getNameOnTextField(),
                lastName: self.getlastNameOnTextField(),
                phone: self.getPhoneOnTextField(),
                language: self.getLanguageSelected()
            )
            break
        default :
            break
        }
    }
    
    
    func didFinishFetchingProfile(_ status: statusWebService, profile: [Profile]) {
        switch status {
        case .success :
            self.profile = profile
            self.dataTableView.reloadData()
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
    
    func didFinishEditProfile(_ status: statusWebService) {
        switch status {
        case .success :
            self.navigationController?.popViewController(animated: true)
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

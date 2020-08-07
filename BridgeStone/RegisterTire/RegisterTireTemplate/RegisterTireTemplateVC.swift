//
//  RegisterTireTemplateVC.swift
//  BridgeStone
//
//  Created by somsak on 20/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import UIKit

class RegisterTireTemplateVC: UIViewController {
    
    @IBOutlet weak var createTiresTemplateLabel: UILabel!
    @IBOutlet weak var errorSaveView: ViewRound!
    @IBOutlet weak var errorSaveLabel: UILabel!
    @IBOutlet var registerTireTemplateView: RegisterTireTemplateView!
    
    private var viewModel: RegisterTireTemplateModel!
    
    var didFinishSaveTimer: Timer?
    
    var params: [Int] = [0, 0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewModel = RegisterTireTemplateModel(view: self)
        self.createTiresTemplateLabel.text = "create_tires_template".localized
        self.registerTireTemplateView.initView()
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSizeTire(_ sender: Any) {
        self.createDialogSizeTire() { (size) in
            self.params[0] = size.id
            self.registerTireTemplateView.sizeTireTextField.text = size.name
        }
    }
    
    @IBAction func didTapBrandTire(_ sender: Any) {
        self.createDialogBrandTire() { (brandTire) in
            self.params[1] = brandTire.id
            self.registerTireTemplateView.brandTireTextField.text = brandTire.name
        }
    }
    
    @IBAction func didTapPatternTire(_ sender: Any) {
        self.createDialogPatternTire() { (patternTire) in
            self.params[2] = patternTire.id
            self.registerTireTemplateView.patternTireTextField.text = patternTire.name
        }
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        if self.params[0] == 0 {
            self.validateSaveView(text: "please_select_size".localized)
        }else if self.params[1] == 0 {
            self.validateSaveView(text: "please_select_brand".localized)
        }else if self.params[2] == 0 {
            self.validateSaveView(text: "please_select_pattern".localized)
        }else{
            self.viewModel.registerTireTemplate(data: self.params)
        }
    }
    
    func validateSaveView(text: String){
        self.errorSaveLabel.text = text
        
        self.errorSaveView.isHidden = false
        var time = 0
        
        self.didFinishSaveTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            if time >= 3 {
                self.errorSaveView.isHidden = true
                timer.invalidate()
            }else{
                time += 1
            }
        }
    }
        
    func createDialogSizeTire(completion:@escaping (SizeTire) -> Void){
        let customDialog = DialogCarDetailVC.createDialog()
        
        customDialog.isSizeTire = true
        
        customDialog.selectClickType = { (value) in
            customDialog.dismiss(animated: true){
                completion(value)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
    
    func createDialogBrandTire(completion:@escaping (SizeTire) -> Void){
        let customDialog = DialogCarDetailVC.createDialog()
        
        customDialog.isBrandTire = true
        
        customDialog.selectClickType = { (value) in
            customDialog.dismiss(animated: true){
                completion(value)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
    
    func createDialogPatternTire(completion:@escaping (SizeTire) -> Void){
        let customDialog = DialogCarDetailVC.createDialog()
        
        customDialog.isPatternTire = true
        
        customDialog.selectClickType = { (value) in
            customDialog.dismiss(animated: true){
                completion(value)
            }
        }
        
        self.present(customDialog, animated: true, completion: nil)
    }
    
}

extension RegisterTireTemplateVC: RegisterTireTemplateModelDelegate {
    func didFinishRefreshToken() {
        self.viewModel.registerTireTemplate(data: self.params)
    }
    
    func didFinishRegisterTireTemplate(_ status: statusWebService) {
        switch status {
        case .success :
            
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
            
//            let storyboard : UIStoryboard = UIStoryboard(name: "RegisterTire", bundle: nil)
//            let registerTireVC: RegisterTireVC = storyboard.instantiateInitialViewController() as! RegisterTireVC
//            self.navigationController?.pushViewController(registerTireVC, animated: true)
            
            break
        case .badRequest :
            self.validateSaveView(text: "tire_template_duplicate".localized)
            break
        case .internalServerError:
            break
        default :
            break
        }
    }
}

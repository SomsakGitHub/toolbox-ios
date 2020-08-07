//
//  LanguageManager.swift
//  BridgeStone
//
//  Created by somsak.kaeworasan on 19/4/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

class LanguageManager: LanguageManagerProtocol {
    
    func getLanguageFirstTime() -> Bool{
        if let getDefaultLanguage = UserDefaults.standard.string(forKey: "SettingLanguages") , getDefaultLanguage.count > 0{
            return false
        }else {
            return true
        }
    }
    
    func getCurrentLanguage() -> String{
        if let getDefaultLanguage = UserDefaults.standard.string(forKey: "SettingLanguages") , getDefaultLanguage.count > 0{
            return getDefaultLanguage.uppercased()
        }else {
            return "EN"
        }
    }
    
    func setLanguage(){
        if let langSetting = UserDefaults.standard.string(forKey: "SettingLanguages") , langSetting.count > 0{
            if langSetting == "th"{
                self.selectThaiLanguage()
            }else if langSetting == "en"{
                self.selectEnglishLanguage()
            }
        }
    }
    
    func selectThaiLanguage(){
        UserDefaults.standard.set("th", forKey: "SettingLanguages")
    }
    
    func selectEnglishLanguage(){
        UserDefaults.standard.set("en", forKey: "SettingLanguages")
    }
}

protocol LanguageManagerProtocol{
    func getLanguageFirstTime() -> Bool
    func getCurrentLanguage() -> String
    func setLanguage()
    func selectThaiLanguage()
    func selectEnglishLanguage()
}

extension String {
    var localized: String {
        let path = Bundle.main.path(forResource: UserDefaults.standard.string(forKey: "SettingLanguages"), ofType: "lproj")  //case userdefault call get value by key
        //        let path = Bundle.main.path(forResource: DataProvider.lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: "DefaultLanguage", bundle: bundle!, value: "", comment: "")
    }
}


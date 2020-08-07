//
//  Profile.swift
//  BridgeStone
//
//  Created by somsak on 4/5/2563 BE.
//  Copyright © 2563 Ifrasoft. All rights reserved.
//

import Foundation

class Profile {
    var username, firstName, lastName, language, mobileNumber: String
    var id: Int
    
    init(id: Int, username: String, firstName: String, lastName: String, language: String, mobileNumber: String) {
        self.id = id
        self.username = username
        self.firstName = firstName
        self.lastName = lastName
        self.language = language
        self.mobileNumber = mobileNumber
    }
}

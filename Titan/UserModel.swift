//
//  UserModel.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation

class UserModel: BaseModel {
    
    //
    // MARK: - Variable
    var username = "guest"
    var isGuest: Bool {
        get {
            return true
        }
    }
}

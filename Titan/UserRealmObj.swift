//
//  UserRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 11/9/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RealmSwift


//
// MARK: - UserRealmObj
class UserRealmObj: BaseRealmObj {
  
    
    //
    // MARK: - Variable
    var username = "guest"
    var isGuest: Bool = true
    var groupConnections: [GroupConnectionRealmObj] = []
}

//
//  UserRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 11/9/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RealmSwift

class UserRealmObj: Object {
  
    //
    // MARK: - Variable
    var username = "guest"
    var isGuest: Bool = true
    
}

//
// MARK: - Base Realm model protocol
extension UserRealmObj: BaseRealmModel { }


//
// MARK: - Object Model Convertible
extension UserRealmObj: ObjectModelConvertible {
    
    typealias E = UserObj
    
    func toObjectModel() -> E {
        let obj = E()
        
        obj.isGuest = self.isGuest
        obj.username = self.username
        
        return obj
    }
}


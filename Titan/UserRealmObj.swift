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
    dynamic var username = "guest"
    dynamic var isGuest: Bool = true
    var groupConnections = List<GroupConnectionRealmObj>()
 
    
    //
    // MARK: - Convertible
    override func convertToModelObj() -> BaseModel {
        
        let obj = UserObj()
        
        obj.objectId = self.objectId
        obj.createdAt = self.createdAt
        obj.updatedAt = self.updatedAt
        
        obj.username = self.username
        obj.isGuest = self.isGuest
        
        let groupsList = self.groupConnections.map { (realmObj) -> GroupConnectionObj in
            return realmObj.convertToModelObj() as! GroupConnectionObj
        }
        let groups: [GroupConnectionObj] = Array(groupsList)
        obj.groupConnections = groups
        
        return obj
    }
    
}

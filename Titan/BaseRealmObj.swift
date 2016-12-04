//
//  BaseRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RealmSwift


//
// MARK: - BaseRealmObj
class BaseRealmObj: Object {
    
    
    //
    // MARK: - Variable
    dynamic var objectId: String!
    dynamic var createdAt: Date!
    dynamic var updatedAt: Date!
    
    
    /// Make objectId is primary key
    /// Obj must have primary key to support "Update" depend on primary key
    /// https://realm.io/docs/swift/latest/#updating-objects
    override static func primaryKey() -> String? {
        return "objectId"
    }
    
    
    //
    // MARK: - Convertible
    func convertToModelObj() -> BaseModel {
        
        let obj = BaseModel()
        
        obj.objectId = self.objectId
        obj.createdAt = self.createdAt
        obj.updatedAt = self.updatedAt
        
        return obj
    }
}

//
//  GroupConnectionObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/1/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ObjectMapper
import PromiseKit
import RealmSwift


//
// MARK: - GroupConnectionObj
final class GroupConnectionObj: BaseModel {
    
    
    //
    // MARK: - Variable
    var name: String! = ""
    var color: GroupColorObj!
    var databases: [DatabaseObj] = []
    
    
    /// Realm Obj class
    override var realmObjClass: BaseRealmObj.Type {
        get {
            return GroupConnectionRealmObj.self
        }
    }
    
    
    //
    // MARK: - Override
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.GroupConnection.Name]
        self.color <- map[Constants.Obj.GroupConnection.Color]
        self.databases <- map[Constants.Obj.GroupConnection.Databases]
    }
    
    
    /// Convert
    override func convertToRealmObj() -> BaseRealmObj {
        
        let realmObj = GroupConnectionRealmObj()
        
        realmObj.objectId = self.objectId
        realmObj.createdAt = self.createdAt
        realmObj.updatedAt = self.updatedAt
        realmObj.name = self.name
        realmObj.color = self.color.convertToRealmObj() as! GroupColorRealmObj
        
        // Databases
        let dbRealmObjs = self.databases.map({ db -> DatabaseRealmObj in
            return db.convertToRealmObj() as! DatabaseRealmObj
        })
        realmObj.databases.append(objectsIn: dbRealmObjs)
        
        return realmObj
    }
    
    //
    // MARK: - Default 
    class func defaultGroupConnection() -> GroupConnectionObj {
        let group = GroupConnectionObj()
        group.name = "My Group Connection"
        group.color = GroupColorObj.defaultColor
        return group
    }
}

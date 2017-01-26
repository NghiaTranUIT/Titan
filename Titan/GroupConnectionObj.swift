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
    dynamic var name: String! = ""
    dynamic var color: GroupColorObj!
    let databases = List<DatabaseObj>()
    
    //
    // MARK: - Override
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.GroupConnection.Name]
        self.color <- map[Constants.Obj.GroupConnection.Color]
        
        // Don't map database
        // It intents for Reverse Linking from Realm
        //self.databases <- map[Constants.Obj.GroupConnection.Databases]
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

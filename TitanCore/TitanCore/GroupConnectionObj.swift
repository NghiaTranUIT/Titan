//
//  GroupConnectionObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/1/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ObjectMapper
import RealmSwift

//
// MARK: - GroupConnectionObj
open class GroupConnectionObj: BaseModel {
    
    //
    // MARK: - Variable
    dynamic public var name: String! = ""
    dynamic public var color: GroupColorObj!
    public let databases = List<DatabaseObj>()
    
    //
    // MARK: - Mpaaing
    override public class func objectForMapping(map: Map) -> BaseMappable? {
        return GroupConnectionObj()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.GroupConnection.Name]
        self.color <- map[Constants.Obj.GroupConnection.Color]
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

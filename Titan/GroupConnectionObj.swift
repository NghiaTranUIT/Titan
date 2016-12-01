//
//  GroupConnectionObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/1/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ObjectMapper

final class GroupConnectionObj: BaseModel {
    
    //
    // MARK: - Variable
    var name: String! = ""
    var color: String?
    var connections: [DatabaseObj] = []
    
    //
    // MARK: - Override
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.GroupConnection.Name]
        self.color <- map[Constants.Obj.GroupConnection.color]
        self.connections <- map[Constants.Obj.GroupConnection.connections]
    }
}

//
//  SSHObj.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ObjectMapper

class SSHObj: BaseModel {

    //
    // MARK: - Variable
    dynamic var host: String!
    dynamic var user: String!
    dynamic var indentityFile: String!
    dynamic var port: Int = 22
    
    //
    // MARK: - Mapping
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.host <- map[Constants.Obj.SSH.Host]
        self.user <- map[Constants.Obj.SSH.User]
        self.indentityFile <- map[Constants.Obj.SSH.IndentityFile]
        self.port <- map[Constants.Obj.SSH.Port]
    }
}

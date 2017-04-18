//
//  SSHObj.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ObjectMapper

open class SSHObj: BaseModel {

    //
    // MARK: - Variable
    dynamic public var host: String!
    dynamic public var user: String!
    dynamic public var indentityFile: String = "~/.ssh/id_rsa"
    dynamic public var port: Int = 22

    //
    // MARK: - Mapping
    override public class func objectForMapping(map: Map) -> BaseMappable? {
        return SSHObj()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        
        self.host <- map[Constants.Obj.SSH.Host]
        self.user <- map[Constants.Obj.SSH.User]
        self.indentityFile <- map[Constants.Obj.SSH.IndentityFile]
        self.port <- map[Constants.Obj.SSH.Port]
    }
}

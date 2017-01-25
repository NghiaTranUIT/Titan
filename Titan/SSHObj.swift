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
    var host: String!
    var user: String!
    var indentityFile: String!
    var port: Int!
    
    /// Realm Obj class
    override var realmObjClass: BaseRealmObj.Type {
        get {
            return SSLRealmObj.self
        }
        
    }
    
    //
    // MARK: - Override    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.host <- map[Constants.Obj.SSH.Host]
        self.user <- map[Constants.Obj.SSH.User]
        self.indentityFile <- map[Constants.Obj.SSH.IndentityFile]
        self.port <- map[Constants.Obj.SSH.Port]
    }
    
    /// Convert
    override func convertToRealmObj() -> BaseRealmObj {
        
        let realmObj = SSHRealmObj()
        
        realmObj.objectId = self.objectId
        realmObj.updatedAt = self.updatedAt
        realmObj.createdAt = self.createdAt
        
        realmObj.host = self.host
        realmObj.user = self.user
        realmObj.indentityFile = self.indentityFile
        realmObj.port = self.port
        
        return realmObj
    }
}

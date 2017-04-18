//
//  DatabaseObj.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import ObjectMapper
import Realm
import RealmSwift
import SwiftyPostgreSQL

open class DatabaseObj: BaseModel {
    
    //
    // MARK: - Variable
    dynamic public var name: String = "New Connection"
    dynamic public var host: String = "localhost"
    dynamic public var username: String = "postgres"
    dynamic public var password: String = ""
    dynamic public var database: String = "postgres"
    dynamic public var port: Int = 5432
    dynamic public var saveToKeychain: Bool = true
    dynamic public var ssl: SSLObj?
    dynamic public var ssh: SSHObj?
    let groupConnection = LinkingObjects(fromType: GroupConnectionObj.self, property: "databases")
    
    /// Default database
    class func defaultDatabase() -> DatabaseObj {
        let db = DatabaseObj()
        db.host = "localhost"
        db.database = "postgres"
        db.port = 5432
        db.username = ""
        db.password = ""
        return db
    }
    
    //
    // MARK: - Mapping
    override public class func objectForMapping(map: Map) -> BaseMappable? {
        return DatabaseObj()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.Database.Name]
        self.host <- map[Constants.Obj.Database.Host]
        self.password <- map[Constants.Obj.Database.Password]
        self.database <- map[Constants.Obj.Database.Database]
        self.port <- map[Constants.Obj.Database.Port]
        self.saveToKeychain <- map[Constants.Obj.Database.SaveToKeyChain]
        self.ssl <- map[Constants.Obj.Database.ssl]
        self.ssl <- map[Constants.Obj.Database.ssh]
        
        // Don't map group connetion
        // It intents for Inverse Linking from Realm
        //self.groupConnection <- map[Constants.Obj.Database.groupConnection]
    }
}

//
// MARK: - PostgreSQL
extension DatabaseObj {
    
    func buildConnectionParam() -> ConnectionParam {
        let param = ConnectionParam(host: self.host, port: String(self.port), options: "", databaseName: self.database, user: self.username, password: self.password)
        return param
    }
}

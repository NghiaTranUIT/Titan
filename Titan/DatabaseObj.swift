//
//  DatabaseObj.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import ObjectMapper

final class DatabaseObj: BaseModel {

    //
    // MARK: - Variable
    var name: String = "New Connection"
    var host: String = "localhost"
    var username: String = "postgres"
    var password: String = ""
    var database: String = "postgres"
    var port: Int = 5432
    var saveToKeychain: Bool = true
    var ssl: SSLObj?
    var ssh: SSHObj?
    weak var groupConnection: GroupConnectionObj?

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
    
    /// Mapping
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.Database.Name]
        self.host <- map[Constants.Obj.Database.Host]
        self.password <- map[Constants.Obj.Database.Password]
        self.database <- map[Constants.Obj.Database.Database]
        self.port <- map[Constants.Obj.Database.Port]
        self.saveToKeychain <- map[Constants.Obj.Database.SaveToKeyChain]
        self.ssl <- map[Constants.Obj.Database.ssl]
        self.ssl <- map[Constants.Obj.Database.ssh]
        self.groupConnection <- map[Constants.Obj.Database.groupConnection]
    }
}

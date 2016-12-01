//
//  DatabaseObj.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ObjectMapper
import RxSwift

final class DatabaseObj: BaseModel {

    
    //
    // MARK: - Variable
    var name: String! = "New Connection"
    var host: String! = "localhost"
    var username: String! = "postgres"
    var user: UserObj! = UserObj.currentUser
    var password: String! = ""
    var database: String! = "postgres"
    var port: Int! = 5432
    var saveToKeychain: Bool! = false
    var ssl: SSLObj?
    var ssh: SSHObj?
    var groupConnection: GroupConnectionObj!
    
    //
    // MARK: - Init
    class func fromDatabaseRealmObj(_ obj: DatabaseRealmObj) -> DatabaseObj {
        let db = DatabaseObj()
        db.host = obj.host
        db.database = obj.database
        db.port = obj.port
        db.username = obj.username
        db.password = obj.password
        return db
    }
    
    //
    // MARK: - Override
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.Database.Name]
        self.host <- map[Constants.Obj.Database.Host]
        self.user <- map[Constants.Obj.Database.User]
        self.password <- map[Constants.Obj.Database.Password]
        self.database <- map[Constants.Obj.Database.Database]
        self.port <- map[Constants.Obj.Database.Port]
        self.saveToKeychain <- map[Constants.Obj.Database.SaveToKeyChain]
        self.ssl <- map[Constants.Obj.Database.ssl]
        self.ssl <- map[Constants.Obj.Database.ssh]
        self.groupConnection <- map[Constants.Obj.Database.groupConnection]
    }
    
    class func defaultDatabase() -> DatabaseObj {
        let db = DatabaseObj()
        db.host = "localhost"
        db.database = "postgres"
        db.port = 5432
        db.username = ""
        db.password = ""
        return db
    }
}

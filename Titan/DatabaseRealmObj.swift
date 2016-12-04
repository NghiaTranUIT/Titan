//
//  DatabaseRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 11/6/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RealmSwift

//
// MARK: - DatabaseRealmObj
class DatabaseRealmObj: BaseRealmObj {
    
    
    //
    // MARK: - Variable
    var name: String!
    var host: String!
    var username: String!
    var user: UserRealmObj!
    var password: String!
    var database: String!
    var port: Int = 5432
    var saveToKeychain = false
    var ssl: SSLRealmObj?
    var ssh: SSHRealmObj?
    var groupConnection = LinkingObjects(fromType: GroupConnectionRealmObj.self, property: "databases")
    
    
    //
    // MARK: - Public
    override func convertToModelObj() -> BaseModel {
        return DatabaseObj()
    }
}


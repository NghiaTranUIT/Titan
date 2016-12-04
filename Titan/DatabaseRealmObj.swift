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
    dynamic var name: String!
    dynamic var host: String!
    dynamic var username: String!
    dynamic var user: UserRealmObj!
    dynamic var password: String!
    dynamic var database: String!
    dynamic var port: Int = 5432
    dynamic var saveToKeychain = false
    dynamic var ssl: SSLRealmObj?
    dynamic var ssh: SSHRealmObj?
    var groupConnection = LinkingObjects(fromType: GroupConnectionRealmObj.self, property: "databases")
    
    
    //
    // MARK: - Public
    override func convertToModelObj() -> BaseModel {
        return DatabaseObj()
    }
}


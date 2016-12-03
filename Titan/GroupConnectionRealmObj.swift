//
//  GroupConnectionRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RealmSwift

final class GroupConnectionRealmObj: Object {
    
    
    //
    // MARK: - Variable
    var name: String! = ""
    var color: String?
    var databases = List<DatabaseRealmObj>()
    
    
    //
    // MARK: - Public
    func convertToModelObj() -> GroupConnectionObj {
        
        // Group
        let groupConnection = GroupConnectionObj()
        groupConnection.name = self.name
        groupConnection.color = self.color
        
        // Databases
        var dbs: [DatabaseObj] = []
        dbs = self.databases.map({ (realmObj) -> DatabaseObj in
            return realmObj.convertToModelObj()
        })
        
        // Return
        groupConnection.databases = dbs
        return groupConnection
    }
}

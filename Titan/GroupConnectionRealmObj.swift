//
//  GroupConnectionRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RealmSwift

//
// MARK: - GroupConnectionRealmObj
final class GroupConnectionRealmObj: BaseRealmObj {
    
    
    //
    // MARK: - Variable
    dynamic var name: String! = ""
    dynamic var color: GroupColorRealmObj!
    var databases = List<DatabaseRealmObj>()
    
    
    //
    // MARK: - Public
    override func convertToModelObj() -> BaseModel {
        
        // Group
        let groupConnection = GroupConnectionObj()
        groupConnection.name = self.name
        groupConnection.color = self.color.convertToModelObj() as! GroupColorObj
        
        // Databases
        var dbs: [DatabaseObj] = []
        dbs = self.databases.map({ (realmObj) -> DatabaseObj in
            return realmObj.convertToModelObj() as! DatabaseObj
        })
        
        // Return
        groupConnection.databases = dbs
        return groupConnection
    }
}

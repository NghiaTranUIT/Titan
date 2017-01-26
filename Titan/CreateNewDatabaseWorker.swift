//
//  CreateNewDatabaseWorker.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift
import PromiseKit

//
// MARK: - Action
struct CreateNewDatabaseAction: Action {
    var databaseObj: DatabaseObj!
    var groupConnectionObj: GroupConnectionObj!
}

//
// MARK: - Worker
class CreateNewDatabaseWorker: AsyncWorker {
    
    
    /// Type
    typealias T = DatabaseObj
    var groupConnectionObj: GroupConnectionObj!
    
    
    /// Init
    init(groupConnectionObj: GroupConnectionObj) {
        self.groupConnectionObj = groupConnectionObj
    }
    
    
    /// Execute
    func execute() -> Promise<T> {
        
        // Create default db
        let defaultDb = DatabaseObj.defaultDatabase()
        
        // Assign to group
        self.groupConnectionObj.databases.append(defaultDb)
        
        // Action
        let action = CreateNewDatabaseAction(databaseObj: defaultDb, groupConnectionObj: self.groupConnectionObj)
        mainStore.dispatch(action)
        
        // Return
        return Promise(value: defaultDb)
    }
}

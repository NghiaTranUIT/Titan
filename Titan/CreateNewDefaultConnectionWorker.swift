//
//  CreateNewDefaultConnectionWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/19/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import PromiseKit

//
// MARK: - Action
struct AddNewDefaultConnectionAction: Action {
    var databaseObj: DatabaseObj
    var groupConnectionObj: GroupConnectionObj
}


//
// MARK: - Worker
class CreateNewDefaultConnectionWorker: AsyncWorker {

    
    /// Type
    typealias T = GroupConnectionObj
    
    
    /// Group connection
    var groupConectionObj: GroupConnectionObj!
    
    
    // Execute
    func execute() -> Promise<T> {
        let defaultDb = DatabaseObj.defaultDatabase()
        let action = AddNewDefaultConnectionAction(databaseObj: defaultDb, groupConnectionObj: self.groupConectionObj)
        mainStore.dispatch(action)
        return Promise(value: T())
    }
}

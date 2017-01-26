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
    var groupConnectionObj: GroupConnectionObj
}


//
// MARK: - Worker
class CreateNewDefaultGroupConnectionWorker: AsyncWorker {

    
    /// Type
    typealias T = GroupConnectionObj
    
    
    /// Execute
    func execute() -> Promise<T> {
        
        // Create new default froup
        let group = GroupConnectionObj.defaultGroupConnection()
        
        // Dispatch action
        let action = AddNewDefaultConnectionAction(groupConnectionObj: group)
        mainStore.dispatch(action)
        
        // Add
        let user = UserObj.currentUser
        user.groupConnections.append(group)
        
        // Save
        return RealmManager.sharedManager.save(obj: user)
        .then(execute: { Void -> Promise<T> in
            return Promise(value: group)
        })
    }
}

//
//  FetchConnectionsWorker.swift
//  Titan
//
//  Created by Nghia Tran on 11/17/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import PromiseKit
import RealmSwift
import Realm

//
// MARK: - Action
struct FetchAllGroupConnectionsAction: Action {}

//
// MARK: - Worker
class FetchAllGroupConnectionsWorker: AsyncWorker {
    
    /// Type
    typealias T = List<GroupConnectionObj>
    
    /// Execute
    func execute() -> Promise<T> {
        
        // Fetch current User
        let currentUser = UserObj.currentUser
        let group = currentUser.groupConnections
        
        // Dispatch
        let action = FetchAllGroupConnectionsAction()
        mainStore.dispatch(action)
        
        // Return
        return Promise(value: group)
    }
}

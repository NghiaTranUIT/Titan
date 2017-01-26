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
struct FetchAllGroupConnectionsAction: Action {
    var connections: List<GroupConnectionObj>!
}

//
// MARK: - Worker
class FetchAllGroupConnectionsWorker: AsyncWorker {
    
    /// Type
    typealias T = List<GroupConnectionObj>
    
    /// Execute
    func execute() -> Promise<T> {
        
        return RealmManager.sharedManager.fetchAll(type: UserObj.self)
        .then(execute: { _ -> Promise<T> in
            
            let groups = UserObj.currentUser.groupConnections
            let action = FetchAllGroupConnectionsAction(connections: groups)
            mainStore.dispatch(action)
            
            return Promise(value: groups)
        })
    }
}

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

//
// MARK: - Action
struct FetchAllGroupConnectionsAction: Action {
    var connections: [GroupConnectionObj]
}


//
// MARK: - Worker
class FetchAllGroupConnectionsWorker: AsyncWorker {
    
    
    /// Type
    typealias T = [GroupConnectionObj]
    
    
    /// Execute
    func execute() -> Promise<T> {
        
        return UserObj.currentUser.fetch().then(execute: { (_) -> Promise<T> in
            
            let groups = UserObj.currentUser.groupConnections
            let action = FetchAllGroupConnectionsAction(connections: groups)
            mainStore.dispatch(action)
            
            return Promise(value: groups)
            
        })
    }
}

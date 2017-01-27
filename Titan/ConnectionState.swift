//
//  ConnectionState.swift
//  Titan
//
//  Created by Nghia Tran on 10/11/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ReSwift
import RxSwift
import RealmSwift

//
// MARK: - State
struct ConnectionState {
    
    /// Connection selected
    var groupConnections = List<GroupConnectionObj>()
    var selectedConnection = PublishSubject<DatabaseObj>()
}

//
// MARK: - Reducer
extension ConnectionState {
    
    static func reducer(action: Action, state: ConnectionState?) -> ConnectionState {
        
        // Get state
        var state = state ?? ConnectionState()
        
        // Switch
        switch action {
        case let action as SelectConnectionAction:
            state.selectedConnection.on(.next(action.selectedConnection))
            
        case let action as CreateNewDatabaseAction:
            
            let group = state.groupConnections
            let selectedGroup = action.groupConnectionObj!
            let newDatabaseObj = action.databaseObj!
            
            // Fitler
            let groups = group.filter({ (obj) -> Bool in
                return selectedGroup.objectId == obj.objectId
            })
            
            // Add
            if let group = groups.first {
                RealmManager.sharedManager.writeSync {
                    group.databases.append(newDatabaseObj)
                }
            }
            
        case let action as AddNewDefaultConnectionAction:
            let group = state.groupConnections
            
            // Save
            RealmManager.sharedManager.writeSync {
                group.append(action.groupConnectionObj)
            }
            
        case _ as FetchAllGroupConnectionsAction:
            // Get from current User
            state.groupConnections = UserObj.currentUser.groupConnections
            
        default:
            break
        }
        return state
    }
}





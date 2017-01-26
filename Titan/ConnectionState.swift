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
        let state = state ?? ConnectionState()
        
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
            
            RealmManager.sharedManager.writeSync {
                group.append(action.groupConnectionObj)
            }
            
        case let action as FetchAllGroupConnectionsAction:
            
            // Append contentOf error
            RealmManager.sharedManager.writeSync {
                for group in action.connections {
                    state.groupConnections.append(group)
                }
            }
            
        default:
            break
        }
        return state
    }
}





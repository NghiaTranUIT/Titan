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

struct ConnectionState {
    
    /// Connection selected
    var groupConnections = Variable<[GroupConnectionObj]>([])
    var selectedConnection = PublishSubject<DatabaseObj>()
}

//
// MARK: - Reducer
extension ConnectionState {
    static func reducer(action: Action, state: ConnectionState?) -> ConnectionState {
        
        // Get state
        let state = state ?? ConnectionState()
        
        // Doing
        switch action {
        case let action as SelectConnectionAction:
            state.selectedConnection.on(.next(action.selectedConnection))
            break
        case let action as CreateNewDatabaseAction:
            
            /*
            var groupConnections = state.groupConnections.value
            
            // Check
            if groupConnections.count == 0 {
                let groupConnectionObj = action.groupConnectionObj
                groupConnectionObj.databases.append(action.databaseObj)
                groupConnections.append(groupConnectionObj)
            } else {
                var selectedGroup: GroupConnectionObj? = nil
                for i in groupConnections {
                    if i.objectId == action.groupConnectionObj.objectId {
                        selectedGroup = i
                        break
                    }
                }
                
                if let selectedGroup = selectedGroup {
                    selectedGroup.databases.append(action.databaseObj)
                }
            }
            state.groupConnections.value = groupConnections
            */
            
            break
        case let action as AddNewDefaultConnectionAction:
            var groupConnections = state.groupConnections.value
            groupConnections.append(action.groupConnectionObj)
            state.groupConnections.value = groupConnections
            break
        case let action as FetchAllGroupConnectionsAction:
            state.groupConnections.value = action.connections
            break
        default:
            break
        }
        
        return state
    }
}





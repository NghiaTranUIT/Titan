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
        
        // Switch
        switch action {
        case let action as SelectConnectionAction:
            state.selectedConnection.on(.next(action.selectedConnection))
            
        case let action as CreateNewDatabaseAction:
            
            let groupConnections = state.groupConnections.value
            let selectedGroupConnection = action.groupConnectionObj
            let newDatabaseObj = action.databaseObj
            
            // Fitler
            let groups = groupConnections.filter({ (obj) -> Bool in
                return selectedGroupConnection!.objectId == obj.objectId
            })
            
            // Add
            if let group = groups.first {
                group.databases.append(newDatabaseObj!)
            }
            
            // Save
            state.groupConnections.value = groupConnections
            
        case let action as AddNewDefaultConnectionAction:
            var groupConnections = state.groupConnections.value
            groupConnections.append(action.groupConnectionObj)
            state.groupConnections.value = groupConnections
            
            
        case let action as FetchAllGroupConnectionsAction:
            state.groupConnections.value = action.connections
            
        default:
            break
        }
        return state
    }
}





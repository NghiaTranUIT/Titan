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
    var connections = Variable<[DatabaseObj]>([])
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
        case let action as AddNewDefaultConnectionAction:
            var currentConnections = state.connections.value
            currentConnections.append(action.newConnection)
            state.connections.value = currentConnections
            break
        case let action as FetchConnectionsAction:
            state.connections.value = action.connections
            break
        default:
            break
        }
        
        return state
    }
}





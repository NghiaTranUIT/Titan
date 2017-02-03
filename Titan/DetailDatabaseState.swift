//
//  MainTabState.swift
//  Titan
//
//  Created by Nghia Tran on 11/21/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift
import TitanKit

struct DetailDatabaseState {
    var selectedConnection: DatabaseObj!
    var tables: [Table] = []
}

//
// MARK: - Reducer
extension DetailDatabaseState {
    static func reducer(action: Action, state: DetailDatabaseState?) -> DetailDatabaseState {
        
        // Get state
        var state = state ?? DetailDatabaseState()
        
        // Doing
        switch action {
        case let action as ConnectDatabaseAction:
            state.selectedConnection = action.selectedDatabase
            
        case let action as UpdateTablesInfoAction:
            state.tables = action.tables
            
            Logger.info("Found \(action.tables.count) tables")
            
        default:
            break
        }
        // Return
        return state
    }
}

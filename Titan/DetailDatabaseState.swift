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
    var selectedTable: Table?
    
    // table on stack
    var stackTables: [Table] = []
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
           
        case let action as SelectedTableAction:
            
            // Replace previous selectedTable with new one
            if let previousTable = state.selectedTable {
                state.stackTables = state.stackTables.map({ table -> Table in
                    if table.tableName! == previousTable.tableName! {
                        return action.selectedTable
                    }
                    return table
                })
            }
            state.selectedTable = action.selectedTable
            
        case let action as AddSelectedTableToStackAction:
            
            // Add if need
            let filter = state.stackTables.filter({ (table) -> Bool in
                return table.tableName! == action.selectedTable.tableName!
            })
            
            if filter.count == 0 {
                state.stackTables.append(action.selectedTable)
            }
            
        default:
            break
        }
        
        // Return
        return state
    }
}

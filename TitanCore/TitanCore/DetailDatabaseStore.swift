//
//  DetailDatabaseStore.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/19/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyPostgreSQL

//
// MARK: - DetailDatabaseStore
open class DetailDatabaseStore: ReduxStore {
    
    //
    // MARK: - Variable
    public var connectedDatabase: Variable<DatabaseObj>!
    public var tables = Variable<[Table]>([])
    public var stackTables: [Table] = []
    public var selectedTable = Variable<Table?>(nil)
    
    // Story type
    public var storyType: StoreType {
        return .detailDatabaseStore
    }
    
    //
    // MARK: - Disaptch
    public func handleAction(_ action: Action) {
        
        switch action {
            
        case let action as ConnectDatabaseAction:
            self.connectedDatabase = Variable<DatabaseObj>(action.selectedDatabase)
            
        case let action as FetchTableSchemaAction:
            self.tables.value = action.tables
            
        case let action as AddSelectedTableToStackAction:
            self.stackTables.append(action.selectedTable)
        
        case let action as SelectedTableAction:
            
            // Replace previous selectedTable with new one
            let contains = self.stackTables.filter({$0 == action.selectedTable})
            
            // Only replace if there is no table in stack
            // && force replace
            if action.replaceCurrentTable && contains.count == 0 {
                if let previousTable = self.selectedTable.value,
                    previousTable != action.selectedTable {
                    
                    self.stackTables = self.stackTables.map({ table -> Table in
                        if table == previousTable {
                            return action.selectedTable
                        }
                        return table
                    })
                }
            }
            
            // Add
            self.selectedTable.value = action.selectedTable
            
        default:
            
            // Do nothing
            assert(true, "Fotgo new action = \(action)")
            break
        }
    }
}

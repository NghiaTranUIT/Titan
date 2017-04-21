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
    public var stackTables = Variable<[Table]>([])
    public var selectedTable = Variable<Table?>(nil)
    
    // View
    public var gridDatabaseViews = Variable<[GridDatabaseView]>([])
    
    // Story type
    public var storyType: StoreType {
        return .detailDatabaseStore
    }
    fileprivate let disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    init() {
        
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
            var temp = self.stackTables.value
            temp.append(action.selectedTable)
            self.stackTables.value = temp
        
        case let action as SelectedTableAction:
            
            // Replace previous selectedTable with new one
            let contains = self.stackTables.value.filter({$0 == action.selectedTable})
            
            // Only replace if there is no table in stack
            // && force replace
            if action.replaceCurrentTable && contains.count == 0 {
                if let previousTable = self.selectedTable.value,
                    previousTable != action.selectedTable {
                    
                    self.stackTables.value = self.stackTables.value.map({ table -> Table in
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

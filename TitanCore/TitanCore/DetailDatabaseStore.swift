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
    public var selectedGridDatabaseView: Observable<GridDatabaseView?>!
    
    // Story type
    public var storyType: StoreType {
        return .detailDatabaseStore
    }
    fileprivate let disposeBag = DisposeBag()
    
    //
    // MARK: - Init
    init() {
        
        self.selectedGridDatabaseView = self.selectedTable.asObservable()
        .flatMap({ (views) -> Observable<GridDatabaseView?> in
            guard let selected = self.selectedTable.value else {
                return Observable<GridDatabaseView?>.just(nil)
            }
            
            for item in self.gridDatabaseViews.value where item.table == selected {
                return Observable<GridDatabaseView?>.just(item)
            }
            return Observable<GridDatabaseView?>.just(nil)
        })
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
            
            // Add & notify
            var temp = self.stackTables.value
            temp.append(action.selectedTable)
            self.stackTables.value = temp
            
            
            // Create new grid database view
            let databaseView = GridDatabaseView.viewNib(with: action.selectedTable)
            var _temp = self.gridDatabaseViews.value
            _temp.append(databaseView)
            self.gridDatabaseViews.value = _temp
            
        case let action as SelectedTableAction:
            
            // Replace previous selectedTable with new one
            let contains = self.stackTables.value.filter({$0 == action.selectedTable})
            
            // Only replace if there is no table in stack
            // && force replace
            if action.replaceCurrentTable && contains.count == 0 {
                if let previousTable = self.selectedTable.value,
                    previousTable != action.selectedTable {
                    
                    //FIXME:
                    // Work around temporary
                    var temp = self.stackTables.value
                    for i in 0..<temp.count {
                        let table = temp[i]
                        if table == previousTable {
                            
                            // Replace table
                            temp[i] = action.selectedTable
                            
                            // Replace grid view
                            let databaseView = GridDatabaseView.viewNib(with: action.selectedTable)
                            var _temp = self.gridDatabaseViews.value
                            _temp[i] = databaseView
                            self.gridDatabaseViews.value = _temp
                            
                            break
                        }
                    }
                    
                    self.stackTables.value = temp
                    
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

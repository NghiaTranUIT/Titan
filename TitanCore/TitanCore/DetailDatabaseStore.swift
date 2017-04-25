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
    public var selectedIndexStackTables = Variable<Int>(-1)
    
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
        
        // Selected Grid
        self.selectedGridDatabaseView = self.selectedIndexStackTables.asObservable()
        .map({ selectedIndex -> GridDatabaseView? in
            guard selectedIndex != -1 && selectedIndex < self.gridDatabaseViews.value.count else {return nil}
            return self.gridDatabaseViews.value[selectedIndex]
        })
        
        
        // Test
        self.gridDatabaseViews.asObservable().do(onNext: { (gridViews) in
            Logger.debug("GridView count = \(gridViews.count)")
        }).subscribe()
        .addDisposableTo(self.disposeBag)
    }
    
    //
    // MARK: - Disaptch
    public func handleAction(_ action: Action) {
        
        switch action {
            
        case let action as ConnectDatabaseAction:
            self.connectedDatabase = Variable<DatabaseObj>(action.selectedDatabase)
            
        case let action as FetchTableSchemaAction:
            self.tables.value = action.tables
            
        case let action as AddTableToStackAction:
            
            // Add & notify
            var temp = self.stackTables.value
            temp.append(action.selectedTable)
            self.stackTables.value = temp
            
            // Create new grid database view
            let databaseView = GridDatabaseView.viewNib(with: action.selectedTable)
            var _temp = self.gridDatabaseViews.value
            _temp.append(databaseView)
            self.gridDatabaseViews.value = _temp
            
            // Selected index -> Last item
            self.selectedIndexStackTables.value = temp.count - 1
            
        case let action as ReplaceTableAction:
            
            //FIXME:
            // Work around temporary
            var temp = self.stackTables.value
            var _temp = self.gridDatabaseViews.value
            let replaceIndex = self.selectedIndexStackTables.value
            
            // Replace table
            temp[replaceIndex] = action.selectedTable
            
            // Clear
            let old = _temp[replaceIndex]
            old.removeFromSuperview()
            
            // Replace grid view
            let databaseView = GridDatabaseView.viewNib(with: action.selectedTable)
            _temp[replaceIndex] = databaseView
            
            // New value
            self.gridDatabaseViews.value = _temp
            self.stackTables.value = temp
            self.selectedIndexStackTables.value = replaceIndex
            
        case let action as SelectedIndexInStackViewAction:
            self.selectedIndexStackTables.value = action.selectedIndex
            
        default:
            
            // Do nothing
            assert(true, "Fotgo new action = \(action)")
            break
        }
    }
}

//
//  TableListViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/20/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa
import SwiftyPostgreSQL

public protocol TableListViewModelType {
    var input: TableListViewModelInput { get }
    var output: TableListViewModelOutput { get }
}

public protocol TableListViewModelInput {
    var fetchTableSchemaPublisher: PublishSubject<Void> {get}
    var selectedTablePublisher: PublishSubject<IndexPath> {get}
    var openTableInNewTabPublisher: PublishSubject<Table> {get}
}

public protocol TableListViewModelOutput {
    var tablesVariable: Variable<[Table]> {get}
    var reloadTableViewDriver: Driver<Void> {get}
}

//
// MARK: - TableListViewModel
open class TableListViewModel: BaseViewModel, TableListViewModelType, TableListViewModelInput, TableListViewModelOutput {

    //
    // MARK: - Type
    public var input: TableListViewModelInput {return self}
    public var output: TableListViewModelOutput {return self}
    
    //
    // MARK: - Input
    public var fetchTableSchemaPublisher = PublishSubject<Void>()
    public var selectedTablePublisher = PublishSubject<IndexPath>()
    public var openTableInNewTabPublisher = PublishSubject<Table>()
    
    //
    // MARK: - Output
    public var reloadTableViewDriver: Driver<Void> {return self._reloadTableViewDriver}
    public var tablesVariable: Variable<[Table]> {
        return MainStore.globalStore.detailDatabaseStore.tables
    }
    
    //
    // MARK: - Variable
    fileprivate var _reloadTableViewDriver: Driver<Void>!
    
    //
    // MARK: - Init
    public override init() {
        super.init()
        
        // Binding
        self.initBinding()
    }
    
    fileprivate func initBinding() {
        
        // Fetch table schema
        self.fetchTableSchemaPublisher
        .flatMap { (_) -> Observable<Void> in
            return FetchTableSchemaWorker().observable()
        }
        .subscribe()
        .addDisposableTo(self.disposeBag)
        
        // Selected
        self.selectedTablePublisher.map { (indexPath) -> Table in
            return self.tablesVariable.value[indexPath.item]
        }
        .do(onNext: { table in
            SelectedTableInCurrentTabWorker(seletedTable: table).execute()
        })
        .subscribe()
        .addDisposableTo(self.disposeBag)
        
        // Open in new tab
        self.openTableInNewTabPublisher
        .do(onNext: { table in
            OpenTableInNewTabWorker(seletedTable: table).execute()
        })
        .subscribe().addDisposableTo(self.disposeBag)
        
    }
}

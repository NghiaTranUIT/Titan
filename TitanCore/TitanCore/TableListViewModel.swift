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

public protocol TableListViewModelType {
    var input: TableListViewModelInput { get }
    var output: TableListViewModelOutput { get }
}

public protocol TableListViewModelInput {
    var fetchTableSchemaPublisher: PublishSubject<Void> {get}
}

public protocol TableListViewModelOutput {
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
    //
    // MARK: - Output
    public var reloadTableViewDriver: Driver<Void> {return self._reloadTableViewDriver}
    
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
    }
}

//
//  RowDatabaseViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/28/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyPostgreSQL
import RxCocoa

public protocol RowDatabaseViewModelType {
    var input: RowDatabaseViewModelInput {get}
    var output: RowDatabaseViewModelOutput {get}
}

public protocol RowDatabaseViewModelInput {
    var fetchDatabaseFromTablePublisher: PublishSubject<Void> {get}
    var selectionRowPublisher: PublishSubject<IndexSet> {get}
}

public protocol RowDatabaseViewModelOutput {
    var queryResultVariable: Variable<QueryResult> {get}
    var selectionRowChangedDriver: Driver<IndexSet>! {get}
}

open class RowDatabaseViewModel: BaseViewModel, RowDatabaseViewModelType, RowDatabaseViewModelInput, RowDatabaseViewModelOutput {
    
    //
    // MARK: - Type
    public var input: RowDatabaseViewModelInput {return self}
    public var output: RowDatabaseViewModelOutput {return self}
    
    //
    // MARK: - Input
    public var fetchDatabaseFromTablePublisher = PublishSubject<Void>()
    public var selectionRowPublisher = PublishSubject<IndexSet>()
    
    //
    // MARK: - Output
    public var queryResultVariable = Variable<QueryResult>(QueryResult(nil))
    public var selectionRowChangedDriver: Driver<IndexSet>!
    
    //
    // MARK: - Variable
    fileprivate var table: Table!
    fileprivate var pagination = Pagination()
    public private(set) var query: PostgreQuery!
    
    //
    // MARK: - Init
    public init(with table: Table) {
        super.init()
        
        self.table = table
        self.binding()
    }
    
    deinit {
        Logger.info("RowDatabaseViewModel Deinit")
    }
    
    fileprivate func binding() {
        
        // Fetch default query
        self.fetchDatabaseFromTablePublisher.flatMap {[unowned self] _ -> Observable<QueryResult> in
            
            // Default query
            self.query = PostgreQuery.buildDefaultQuery(with: self.table, pagination: self.pagination)
            let worker = QueryPostgreSQLWorker(query: self.query)
            return worker.observable()
        }
        .bind(to: self.queryResultVariable)
        .addDisposableTo(self.disposeBag)
        
        // Selection changed
        self.selectionRowChangedDriver = self.selectionRowPublisher.asDriver(onErrorJustReturn: IndexSet())
    }
    
    public func field(at col: Column, row: Int) -> Field {
        let row = self.queryResultVariable.value.rows[row]
        let field = row.field(with: col)!
        return field
    }

}

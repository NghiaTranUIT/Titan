
//
//  GridDatabaseViewModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/21/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL
import RxSwift

//
// MARK: - Type
public protocol GridDatabaseViewModelType {
    var input: GridDatabaseViewModelInput {get}
    var output: GridDatabaseViewModelOutput {get}
}

public protocol GridDatabaseViewModelInput {
    var fetchDatabaseFromTablePublisher: PublishSubject<Void> {get}
}

public protocol GridDatabaseViewModelOutput {
    var queryResult: Variable<QueryResult> {get}
}

//
// MARK: - GridDatabaseViewModel
open class GridDatabaseViewModel: BaseViewModel, GridDatabaseViewModelType, GridDatabaseViewModelOutput, GridDatabaseViewModelInput {
    
    //
    // MARK: - Type
    public var input: GridDatabaseViewModelInput {return self}
    public var output: GridDatabaseViewModelOutput {return self}
    
    //
    // MARK: - Input
    public var fetchDatabaseFromTablePublisher = PublishSubject<Void>()
    
    //
    // MARK: - Output
    public var queryResult = Variable<QueryResult>(QueryResult(nil))
    
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
        Logger.info("GridDatabaseViewModel Deinit")
    }
    
    fileprivate func binding() {
        
        // Fetch default query
        self.fetchDatabaseFromTablePublisher.flatMap {[unowned self] _ -> Observable<QueryResult> in
            
            // Default query
            self.query = PostgreQuery.buildDefaultQuery(with: self.table, pagination: self.pagination)
            let worker = QueryPostgreSQLWorker(query: self.query)
            return worker.observable()
        }
        .bind(to: self.queryResult)
        .addDisposableTo(self.disposeBag)
    }
    
    public func field(at col: Column, row: Int) -> Field {
        let row = self.queryResult.value.rows[row]
        let field = row.field(with: col)!
        return field
    }
}

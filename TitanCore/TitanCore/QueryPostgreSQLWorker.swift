//
//  QueryPostgreSQLWorker.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/24/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL
import RxSwift

class QueryPostgreSQLWorker: AsyncWorker {
    
    //
    // MARK: - Variable
    typealias T = QueryResult
    fileprivate var query: PostgreQuery!
    
    //
    // MARK: - Init
    init(query: PostgreQuery) {
        self.query = query
    }
    
    func observable() -> Observable<T> {
        return PostgreSQLManager.shared
            .fetchQuery(self.query)
    }
}

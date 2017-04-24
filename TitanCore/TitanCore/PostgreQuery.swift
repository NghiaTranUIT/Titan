//
//  PostgreQuery.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/24/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import SwiftyPostgreSQL

class PostgreQuery {
    
    //
    // MARK: - Variable
    var rawQuery: Query!
    
    //
    // MARK: - Initializer
    init() {
        
    }
    
    convenience init(rawQuery: Query){
        self.init()
        self.rawQuery = rawQuery
    }
    
    //
    // MARK: - Public
    var rawString: String {
        return "\(self.rawQuery)"
    }
    
    //
    // MARK: - Builder
    class func buildDefaultQuery(with table: Table, pagination: Pagination) -> PostgreQuery {
        let raw = Query("SELECT * FROM \(table.tableName!) OFFSET \(pagination.skip) LIMIT \(pagination.limit)")
        return PostgreQuery(rawQuery: raw)
    }
}

//
// MARK: - Private
extension PostgreQuery {
    
    
    /// Return full count for pagination
    ///
    /// - Returns: Query
    fileprivate class func fullCountQuery() -> String {
        return ",count(*) OVER() AS titan_full_count"
    }
}

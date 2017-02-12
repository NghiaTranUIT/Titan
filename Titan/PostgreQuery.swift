//
//  QueryBuilder.swift
//  Titan
//
//  Created by Nghia Tran on 2/7/17.
//  Copyright © 2017 fe. All rights reserved.
//

import Foundation
import TitanKit

class PostgreQuery {
    
    //
    // MARK: - Variable
    fileprivate var rawQuery: Query!
    
    //
    // MARK: - Initializer
    init() {
        
    }
    
    convenience init(rawQuery: Query){
        self.init()
        self.rawQuery = rawQuery
    }
    
    //
    // MARK: - Builder
    class func buildDefaultQuery(with table: Table, pagination: Pagination) -> PostgreQuery {
        let raw = Query("SELECT + \(table.tableName!) SKIP \(pagination.skip) LIMIT \(pagination.limit)")
        return PostgreQuery(rawQuery: raw)
    }
}

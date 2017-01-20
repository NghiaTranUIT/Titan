//
//  Table.swift
//  TitanKit
//
//  Created by Nghia Tran on 1/20/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import Foundation


//
// MARK: - TableSchema
public enum TableSchema: String {
    case pgCatalog          = "pg_catalog"
    case `public`           = "public"
    case informationSchema  = "information_shema"
    case none
}


//
// MARK: - TableType
public enum TableType: String {
    case baseTable          = "BASE TABLE"
    case view               = "VIEW"
    case forignTable        = "FOREIGN TABLE"
    case temporaryTable     = "LOCAL TEMPORARY"
    case none
}


//
// MARK: - Represent Table in PostgreSQL
open class Table {
    
    
    //
    // MARK: - Variable
    /// Catolog name
    public let tableCatalog: String?
    
    
    /// Table Schema
    public var tableSchema: TableSchema = TableSchema.none
    
    
    /// Table Name
    public let tableName: String?
    
    
    /// Table Type
    public var tableType: TableType = TableType.none
    
    
    /// Is insertable
    public let isInsertableInto: Bool?
    
    
    /// Is Typed
    public let isTyped: Bool?
    
    
    //
    // MARK: - Init
    init(tableCatalog: String, tableSchema: String, tableName: String, tableType: String, isInsertableInto: Bool, isTyped: Bool) {
        self.tableCatalog = tableCatalog
        self.tableSchema = TableSchema(rawValue: tableSchema) ?? TableSchema.none
        self.tableName = tableName
        self.tableType = TableType(rawValue: tableType) ?? TableType.none
        self.isInsertableInto = isInsertableInto
        self.isTyped = isTyped
    }
    
    init(resultRow: QueryResultRow) {
        self.tableCatalog = resultRow["table_catalog"] as? String
        let schema = resultRow["table_catalog"] as! String
        self.tableSchema = TableSchema(rawValue: schema) ?? TableSchema.none
        self.tableName = resultRow["table_name"] as? String
        let type = resultRow["table_type"] as! String
        self.tableType = TableType(rawValue: type) ?? TableType.none
        self.isInsertableInto = resultRow["is_insertable_into"] as? Bool
        self.isTyped = resultRow["is_typed"] as? Bool
    }
}

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
    
    /// ID
    public let id: String = UUID.shortUUID()
    
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
        self.tableCatalog = resultRow["table_catalog"]!.rawData
        let schema = resultRow["table_catalog"]!.rawData
        self.tableSchema = TableSchema(rawValue: schema) ?? TableSchema.none
        self.tableName = resultRow["table_name"]!.rawData
        let type = resultRow["table_type"]!.rawData
        self.tableType = TableType(rawValue: type) ?? TableType.none
        
        // Trick 
        // Store as formation_schema.yes_or_no -> Varchar
        // Need to stupid compare and parsing to boolean
        self.isInsertableInto = (resultRow["is_insertable_into"]!.realData as? String) == "YES"
        self.isTyped = (resultRow["is_typed"]!.realData as? String) == "YES"
    }
}

//
// MARK: - Private
extension Table {
    
    fileprivate func tableDescription() -> String {
        var debug =  "[Table]:"
        if let tableName = self.tableName {
            debug += " name=\(tableName)"
        }
        return debug
    }
}

//
// MARK: - CustomStringConvertible
extension Table: CustomStringConvertible {
    public var description: String {
        return self.tableDescription()
    }
}

//
// MARK: - CustomDebugStringConvertible
extension Table: CustomDebugStringConvertible {
    public var debugDescription: String {
        return self.tableDescription()
    }
}

//
// MARK: - Equatable
extension Table: Equatable {
    
    public static func ==(lhs: Table, rhs: Table) -> Bool {
        return lhs.id == rhs.id
    }
}

//
//  Column.swift
//  TitanKit
//
//  Created by Nghia Tran on 2/6/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import Foundation

open class Column: ColumnTypeProtocol {
    
    //
    // MARK: - Variable
    fileprivate var _colName: String!
    public var colName: String {
        return _colName
    }
    
    fileprivate var _colIndex: Int!
    public var colIndex: Int {
        return _colIndex
    }
    
    fileprivate var _colType: ColumnType!
    public var colType: ColumnType {
        return _colType
    }
    
    public lazy var textAlignment: NSTextAlignment = {
        switch self.colType {
        case .boolean:
            return .center
        case .int64:
            fallthrough
        case .int16:
            fallthrough
        case .int32:
            fallthrough
        case .singleFloat:
            fallthrough
        case .doubleFloat:
            return .right
        default: return .left
        }
    }()
    
    //
    // MARK: - Init
    init() {}
    convenience init(colName: String, colIndex: Int, colType: ColumnType) {
        self.init()
        self._colName = colName
        self._colIndex = colIndex
        self._colType = colType
    }
    
    class func fakeColumn(with colName: String) -> Column {
        let col = Column()
        col._colName = colName
        return col
    }
    
    //
    // MARK: - Public
    
}

extension Column: Hashable {
    public var hashValue: Int {
        return self.colName.hashValue
    }
}

extension Column: Equatable {
    public static func ==(lhs: Column, rhs: Column) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

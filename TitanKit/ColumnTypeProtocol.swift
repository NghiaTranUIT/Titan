//
//  ColumnTypeProtocol.swift
//  TitanKit
//
//  Created by Nghia Tran on 2/6/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import Foundation

//
// MARK: - ColumnTypeProtocol
/// The name with suffix Protoco is temporary
/// Cause We already had ColumnType enum
public protocol ColumnTypeProtocol {
    
    var colName: String {get}
    
    var colIndex: Int {get}
    
    var colType: ColumnType {get}
}

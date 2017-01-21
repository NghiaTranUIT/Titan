//
//  Decodable.swift
//  TitanKit
//
//  Created by Nghia Tran on 1/20/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import Foundation


//
// MARK: - Decoeable
/// Convert raw value with colIndex, colType,... to QueryResultRow
public protocol Decodable {
    
    
    /// Init
    init(resultPtr: OpaquePointer, colType: ColumnType, rowIndex: Int, colIndex: Int)
    
    
    /// Determine if is null
    func isNull() -> Bool
    
    
    /// Get raw data
    func getRawData() -> String
    
    
    /// Parse RawData -> RealData
    func decodeRawData(_ rawData: String, colType: ColumnType) -> Any
}

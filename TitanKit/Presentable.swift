//
//  Presentable.swift
//  TitanKit
//
//  Created by Nghia Tran on 1/20/17.
//  Copyright © 2017 Titan. All rights reserved.
//

import Foundation


//
// MARK: - Presentable protocol
/// Represent data when showing in cell
/// The reason is performance
/// We should't parse every json cell before showing in tableView
/// We just need show `presentValue: String`
/// 
/// Whatever we need real data -> Lazy computed it
protocol Presentable {
    
    var type: ColumnType {get}
    
    var rawData: String {get}
    
    var realData: Any? {get}
    
    var isNull: Bool {get}
}

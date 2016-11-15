//
//  ObjectModelType.swift
//  Titan
//
//  Created by Nghia Tran on 11/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation

/// Base Object Model
/// Intent for baseclass "BaseObjectMode"
protocol BaseObjectModel {
    init()
}


/// Convert to object model
protocol ObjectModelConvertible {
    
    
    /// Must convert to BaseObjectModel & BaseRealmModelConvertible
    associatedtype E: BaseObjectModel, BaseRealmModelConvertible
    
    
    /// Convert
    func toObjectModel() -> E
}

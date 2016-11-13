//
//  ObjectModelType.swift
//  Titan
//
//  Created by Nghia Tran on 11/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation

protocol BaseObjectModel {
    init()
}

protocol ObjectModelConvertible {
    
    associatedtype E: BaseObjectModel, BaseRealmModelConvertible
    
    func toObjectModel() -> E
}

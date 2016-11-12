//
//  BaseRealmModel.swift
//  Titan
//
//  Created by Nghia Tran on 11/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RealmSwift

protocol BaseRealmModel {}

protocol BaseRealmModelConvertible {
    
    associatedtype E: Object, BaseRealmModel
    
    func toRealmObject() -> E
}

//
//  BaseRealmObj.swift
//  Titan
//
//  Created by Nghia Tran on 11/6/16.
//  Copyright © 2016 fe. All rights reserved.
//

import RealmSwift
import RxSwift

protocol RealmRxActiveRecord {
    
    // Magic
    associatedtype E: Object
    
    /// Fetch
    static func fetchAll() -> Future<E, NSError>
    
    static func first() -> Future<E, NSError>
}

//
// MARK: - Active Record
extension RealmRxActiveRecord {
    
    static func fetchAll() -> Future<E, NSError> {
        return RealmManager.sharedManager.fetchAll(type: E.self)
    }
    
    static func first() -> Future<E, NSError> {
        return RealmManager.sharedManager.first(type: E.self)
    }
}



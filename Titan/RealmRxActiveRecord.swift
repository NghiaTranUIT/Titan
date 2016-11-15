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
    static func fetchAll() -> Observable<Results<E>>
    
    static func first() -> Observable<E>
}

//
// MARK: - Active Record
extension RealmRxActiveRecord {
    
    static func fetchAll() -> Observable<Results<E>> {
        return RealmManager.sharedManager.fetchAll(type: E.self)
    }
    
    static func first() -> Observable<E> {
        return RealmManager.sharedManager.first(type: E.self)
    }
}



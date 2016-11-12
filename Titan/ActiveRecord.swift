//
//  ActiveRecord.swift
//  Titan
//
//  Created by Nghia Tran on 11/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import RxSwift
import RealmSwift

protocol ActiveRecord {
    
    associatedtype Model: BaseObjectModel
    associatedtype Realm: Object
    associatedtype Request: Titan.Request
    
    /// Fetch
    static func fetchAll() -> Observable<[Model]>
    static func fetchAllLocal() -> Observable<[Model]>
    static func fetchAllCloud() -> Observable<[Model]>
    
    
    /// Convention
    static func first() -> Observable<Model>
    static func firstLocal() -> Observable<Model>
    static func firstCloud() -> Observable<Model>
    
    
    /// Save
    static func save() -> Observable<Model>
    static func saveLocal() -> Observable<Model>
    static func saveCloud() -> Observable<Model>
    
    
    /// Remove
    static func delete() -> Observable<Model>
    static func deleteLocal() -> Observable<Model>
    static func deleteCloud() -> Observable<Model>
}

//
// MARK: - Active Record
extension ActiveRecord where Realm: ObjectModelConventible {
    
    static func fetchAll() -> Observable<[Model]> {
        
    }
    
    static func fetchAllLocal() -> Observable<[Model]> {
        return RealmManager.sharedManager
            .fetchAll(type: Realm.self)
            .map { (result: Results<Realm>) -> [Model] in
                var models: [Model] = []
                for i in result {
                    models.append(i.toObjectModel())
                }
                return models
        }
    }
    
    static func fetchAllCloud() -> Observable<[Model]> {
        return Request()
            .toAlamofireObservable()
            .map({ (result) -> [Model] in
                switch result {
                case .Failure(_):
                    return []
                case .Success(let databases):
                    return databases
                }
            })
    }
    
    static func first() -> Observable<Model> {
        
    }
}



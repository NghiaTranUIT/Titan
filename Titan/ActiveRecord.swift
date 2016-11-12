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
    
    associatedtype Model: BaseObjectModel, BaseRealmModelConvertible
    associatedtype Realm: Object, ObjectModelConvertible
    associatedtype Request: Titan.Request
    
    /// Fetch
    static func fetchAll() -> Observable<[Model]>
    static func fetchAllLocal() -> Observable<[Model]>
    static func fetchAllCloud() -> Observable<[Model]>
    
    
    /// Save
    func save() -> Observable<Model>
    func saveLocal() -> Observable<Model>
    func saveCloud() -> Observable<Model>
    
    /*
    /// Convention
    static func first() -> Observable<Model?>
    static func firstLocal() -> Observable<Model?>
    static func firstCloud() -> Observable<Model?>
    
    
    /// Remove
    static func delete() -> Observable<Model>
    static func deleteLocal() -> Observable<Model>
    static func deleteCloud() -> Observable<Model>
 */
}

//
// MARK: - Active Record - Fetch All
extension ActiveRecord {
    
    static func fetchAll() -> Observable<[Model]> {
        
        if UserObj.currentUser.isGuest {
            return self.fetchAllLocal()
        }
        
        return Observable.concat([self.fetchAllLocal(), self.fetchAllCloud()])
    }
    
    static func fetchAllLocal() -> Observable<[Model]> {
        return RealmManager.sharedManager
            .fetchAll(type: Realm.self)
            .map { (result: Results<Realm>) -> [Model] in
                var models: [BaseObjectModel] = []
                for i in result {
                    let obj = i.toObjectModel()
                    models.append(obj)
                }
                return models as! [Model]
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
                    return databases as! [Model]
                }
            })
    }
}

//
// MARK: - Active Recored - Save
extension ActiveRecord where Self: BaseRealmModelConvertible {
    func save() -> Observable<Model> {
        if UserObj.currentUser.isGuest {
            return self.saveLocal()
        }

        return Observable.concat([self.saveLocal(), self.saveCloud()])
    }
    
    func saveLocal() -> Observable<Model> {
        let realmObj = self.toRealmObject()
        return RealmManager.sharedManager
            .save(obj: realmObj, type: Realm.self)
            .map {_ in return Observable<Model>.empty()}
    }
    
    func saveCloud() -> Observable<Model> {
        return Request().toAlamofireObservable()
                .map { (result) -> Model in
                    switch result {
                    case .Failure(_):
                        return Model()
                    case .Success(let obj):
                        return obj as! Self.Model
                    }
                }
    }
}


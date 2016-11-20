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
import BrightFutures

protocol ActiveRecord {
    
    associatedtype Realm: Object, ObjectModelConvertible
    associatedtype Request: Titan.Request
    
    /// Fetch
    static func fetchAll() -> Future<[Self], NSError>
    static func fetchAllLocal() ->  Future<[Self], NSError>
    static func fetchAllCloud() ->  Future<[Self], NSError>
    
    /// Save
    func save() -> Future<Self, NSError>
    func saveLocal() -> Future<Self, NSError>
    func saveCloud() -> Future<Self, NSError>
 
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
extension ActiveRecord where Self: BaseObjectModel & BaseRealmModelConvertible {
    
    static func fetchAll() -> Future<[Self], NSError> {
        
        // Only local
        if UserObj.currentUser.isGuest {
            return self.fetchAllLocal()
        }
        
        // Local + cloud
        let futures = [self.fetchAllLocal(), self.fetchAllCloud()]
        return futures.sequence().map { results in
            return results[0] + results[1]
        }
    }
    
    static func fetchAllLocal() ->  Future<[Self], NSError> {
        return RealmManager.sharedManager.fetchAll(type: Realm.self)
        .map({ (result) -> [Self] in
            var models: [Self] = []
            for i in result {
                //TODO: Fix as! Self
                // The problem is:
                // There is no way to check if the class A (which conform from HypeObject)
                // And class B (which conform Object & ObjectModelConvertible
                // is same class in Runtime
                // => Hot-fix => Force cast to self
                // If not -> Can't add to models
                let obj = i.toObjectModel() as! Self
                models.append(obj)
            }
            return models
        })
    }
    
    static func fetchAllCloud() ->  Future<[Self], NSError> {
        return Request().toAlamofireObservable()
        .map({ (dbs) -> [Self] in
            return dbs as! [Self]
        })
    }
}


//
// MARK: - Active Recored - Save
extension ActiveRecord where Self: BaseObjectModel & BaseRealmModelConvertible {
    
    func save() -> Future<Self, NSError> {
        // Is Guest
        if UserObj.currentUser.isGuest {
            return self.saveLocal()
        }

        // Local + cloud
        
    }
    
    func saveLocal() -> Future<Self, NSError> {
        let realmObj = self.toRealmObject()
        return RealmManager.sharedManager
            .save(obj: realmObj)
            .map({ (_) -> Self in
                return self
            })
    }
    
    func saveCloud() -> Future<Self, NSError> {
        return Request()
            .toAlamofireObservable()
            .map({ (_) -> Self in
                return self
            })
    }
}


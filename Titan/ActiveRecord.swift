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
    
    associatedtype Realm: Object, ObjectModelConvertible
    associatedtype Request: Titan.Request
    
    /// Fetch
    static func fetchAll() -> Observable<[Self]>
    static func fetchAllLocal() -> Observable<[Self]>
    static func fetchAllCloud() -> Observable<[Self]>
    
    
    /// Save
    func save() -> Observable<Self>
    func saveLocal() -> Observable<Self>
    func saveCloud() -> Observable<Self>
 
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
    
    static func fetchAll() -> Observable<[Self]> {
        
        if UserObj.currentUser.isGuest {
            return self.fetchAllLocal()
        }
        
        return Observable.concat([self.fetchAllLocal(), self.fetchAllCloud()])
    }
    
    static func fetchAllLocal() -> Observable<[Self]> {
        return RealmManager.sharedManager
            .fetchAll(type: Realm.self)
            .map { (result: Results<Realm>) -> [Self] in
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
        }
    }
    
    static func fetchAllCloud() -> Observable<[Self]> {
        return Request()
            .toAlamofireObservable()
            .map({ (result) -> [Self] in
                switch result {
                case .Failure(_):
                    return []
                case .Success(let databases):
                    return databases as! [Self]
                }
            })
    }
}


//
// MARK: - Active Recored - Save
extension ActiveRecord where Self: BaseObjectModel & BaseRealmModelConvertible {
    
    func save() -> Observable<Self> {
        // Is Guest
        if UserObj.currentUser.isGuest {
            return self.saveLocal()
        }

        return Observable.concat([self.saveLocal(), self.saveCloud()])
    }
    
    func saveLocal() -> Observable<Self> {
        let realmObj = self.toRealmObject()
        return RealmManager.sharedManager
            .save(obj: realmObj)
            .map({ (_) -> Self in
                return self
            })
    }
    
    func saveCloud() -> Observable<Self> {
        return Request()
            .toAlamofireObservable()
            .map({ (_) -> Self in
                return self
            })
    }
}


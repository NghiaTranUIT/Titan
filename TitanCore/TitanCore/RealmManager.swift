//
//  RealmManager.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Realm
import RealmSwift
import Alamofire
import RxSwift

public typealias RealmBlock = (Realm)->()

open class RealmManager {
    
    //
    // MARK: - Variable
    public static let sharedManager = RealmManager()
    
    /// Private Realm Configuration
    /// It get secret key from Keychain
    fileprivate static let secrectRealmConfigure: Realm.Configuration = Realm.Configuration(encryptionKey: RealmKey.getSecrectRealmKey() as Data)
    
    /// Realm Default
    fileprivate var _mainRealm: Realm!
    public var realm: Realm {
        
        // If on main thread, we use _mainRealm
        if Thread.isMainThread {
            return _mainRealm
        }
        
        // If background, we create new one
        // Ref: https://realm.io/docs/swift/latest/#threading
        return RealmManager.defaultRealm()
    }
    
    //
    // MARK: - Initializer
    // Independcy injection -> For testing
    init(realm: Realm? = RealmManager.defaultRealm()) {
        self._mainRealm = realm
    }
    
    //
    // MARK: - Action
    // Fetch all
    func fetchAll<T: Object>(type: T.Type) -> Observable<Results<T>> {
        
        // Temporary
        return Observable.create {[unowned self] (observer) -> Disposable in
            
            let result = self.realm.objects(type)
            observer.onNext(result)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    /// Is Exist
    func isExist<T: Object>(type: T.Type, ID: String) -> Observable<Results<T>> {
        // Temporary
        return Observable.create { (observer) -> Disposable in
            
            let results = self.realm.objects(type).filter("\(Constants.Obj.ObjectId) = '\(ID)'")
            observer.onNext(results)
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
    
    /// Fetch current user
    func fetchCurrentUser() -> UserObj? {
        
        // Where user.objectId = Guest
        let results = self.realm.objects(UserObj.self).filter("\(Constants.Obj.ObjectId) = '\(Constants.Obj.User.GuestUserObjectId)'")
        
        // Get
        guard let obj = results.first else {
            return nil
        }
        
        return obj
    }
}

//
// MARK: - Write transaction helper
extension RealmManager {
    
    /// Write sync to realm-database
    /// It will write sync in current thread
    public func writeSync(_ block: RealmBlock) {
        self.realm.beginWrite()
        block(self.realm)
        try! self.realm.commitWrite()
    }
}

//
// MARK: - Private
extension RealmManager {
    
    fileprivate class func defaultRealm() -> Realm {
        do {
            //return try Realm(configuration: RealmManager.secrectRealmConfigure)
            return try Realm()
        } catch let error as NSError {
            // If the encryption key is wrong, `error` will say that it's an invalid database
            Logger.error("Error opening realm: \(error)")
            fatalError("Error opening realm: \(error)")
        }
    }
}

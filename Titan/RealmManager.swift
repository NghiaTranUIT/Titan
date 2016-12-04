//
//  RealmManager.swift
//  Titan
//
//  Created by Nghia Tran on 11/6/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Realm
import RealmSwift
import PromiseKit
import Alamofire

final class RealmManager {
    
    //
    // MARK: - Variable
    static let sharedManager = RealmManager()
    
    
    /// Private Realm Configuration
    /// It get secret key from Keychain
    private lazy var secrectRealmConfigure: Realm.Configuration = {
        let configuration = Realm.Configuration(encryptionKey: RealmKey.getSecrectRealmKey())
        return configuration
    }()
    
    
    /// Realm Default
    private lazy var realm: Realm = {
        do {
            //return try Realm(configuration: self.secrectRealmConfigure)
            Logger.info("Realm = \(Realm.Configuration.defaultConfiguration.fileURL)")
            return try Realm()
        } catch let error as NSError {
            // If the encryption key is wrong, `error` will say that it's an invalid database
            Logger.error("Error opening realm: \(error)")
            fatalError("Error opening realm: \(error)")
        }
    }()
    
    
    // Fetch all
    func fetchAll<T: Object>(type: T.Type) -> Promise<Results<T>> {
        return Promise { fullfll, reject in
            let results = self.realm.objects(type)
            fullfll(results)
        }
    }
    
    
    /// Is Exist
    func isExist<T: Object>(type: T.Type, ID: String) -> Promise<Results<T>> {
        return Promise { fullfll, reject in
            let results = self.realm.objects(type).filter("\(Constants.Obj.ObjectId) = '\(ID)'")
            fullfll(results)
        }
    }
    
    
    /// Save
    func save(obj: Object) -> Promise<Void> {
        return Promise { fullfll, reject in
            try! self.realm.write {
                self.realm.add(obj, update: true)
            }
            fullfll(())
        }
    }
}

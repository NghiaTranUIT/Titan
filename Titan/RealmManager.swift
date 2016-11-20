//
//  RealmManager.swift
//  Titan
//
//  Created by Nghia Tran on 11/6/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Realm
import RealmSwift
import BrightFutures

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
            return try Realm()
        } catch let error as NSError {
            // If the encryption key is wrong, `error` will say that it's an invalid database
            Logger.error("Error opening realm: \(error)")
            fatalError("Error opening realm: \(error)")
        }
    }()
    
    
    //
    // MARK: - Public
    
    /// Fetch all
    func fetchAll<T: Object>(type: T.Type) -> Future<T, NSError> {
        let result = self.realm.objects(type)
        return Future { complete in
            complete(.success(result))
        }
    }
    
    
    /// First
    func first<T: Object>(type: T.Type) -> Future<T, NSError> {
        guard let firstObj = self.realm.objects(type).first else {
            return Future { complete in
                complete(.success(nil))
            }
        }
        return Future { complete in
            complete(.success(firstObj))
        }
    }
    
    
    /// Save
    func save<T: Object>(obj: T) -> Future<T, NSError> {
        
        return Future { complete in
            
            try! self.realm.write {
                self.realm.add(obj)
            }
            
            complete(.success())
        }
    }
}

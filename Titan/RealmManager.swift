//
//  RealmManager.swift
//  Titan
//
//  Created by Nghia Tran on 11/6/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Realm

final class RealmManager {
    
    //
    // MARK: - Variable
    static let sharedManager = RealmManager()
    
    
    /// Private Realm Configuration
    /// It get secret key from Keychain
    private lazy var secrectRealmConfigure: RLMRealmConfiguration = {
        var configure = RLMRealmConfiguration.default()
        configure.encryptionKey = RealmKey.getSecrectRealmKey()
        return configure
    }()
    
    
    /// Realm Default
    private lazy var realm: RLMRealm = {
        do {
            return try RLMRealm(configuration: self.secrectRealmConfigure)
        } catch let error as NSError {
            // If the encryption key is wrong, `error` will say that it's an invalid database
            Logger.error("Error opening realm: \(error)")
            fatalError("Error opening realm: \(error)")
        }
       
    }()
}

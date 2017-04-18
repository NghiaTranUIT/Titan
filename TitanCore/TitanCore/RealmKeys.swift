//
//  RealmKeys.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import UICKeyChainStore

class RealmKey {
    
    fileprivate static var keychain = UICKeyChainStore(service: Constants.Key.Realm.KeyChainID)
    
    // Auto generate key from Realm.KeyChainID
    // Save to keychain
    class func getSecrectRealmKey() -> NSData {
        
        // Identifier for our keychain entry - should be unique for your application
        if let data = self.keychain.data(forKey: Constants.Key.Realm.KeyChainID) {
            return data as NSData
        }
        
        // No pre-existing key from this application, so generate a new one
        let keyData = NSMutableData(length: 64)!
        let result = SecRandomCopyBytes(kSecRandomDefault, 64, keyData.mutableBytes.bindMemory(to: UInt8.self, capacity: 64))
        assert(result == 0, "Failed to get random bytes")
        
        // Store the key in the keychain
        self.keychain.setData(keyData as Data, forKey: Constants.Key.Realm.KeyChainID)
        return keyData
    }
}

//
//  BaseModel+Store.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import PromiseKit

//
// MARK: - Store
protocol BaseModelStore {
    
    
    /// Save
    /// Save to Disk + Cloud
    func save() -> Promise<Void>
    
    
    /// Fetch
    func fetch() -> Promise<BaseModel?>
}


extension BaseModel: BaseModelStore {
    
    
    /// Save
    func save() -> Promise<Void> {
        
        // Convert to realm obj
        let realmObj = self.convertToRealmObj()
        
        // Save to realm
        return RealmManager.sharedManager.save(obj: realmObj)
    }
    
    
    /// Fetch
    func fetch() -> Promise<BaseModel?> {
        
        // Fetch from realm
        return RealmManager.sharedManager.fetchAll(type: self.realmObjClass)
            .then { (result) -> Promise<BaseModel?> in
                guard let realmObj = result.first else {
                    return Promise<BaseModel?>(value: nil)
                }
                
                // Convert to model
                let obj = realmObj.convertToModelObj()
                return Promise<BaseModel?>(value: obj)
        }
    }
}

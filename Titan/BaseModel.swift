//
//  BaseModel.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ObjectMapper
import PromiseKit
import RealmSwift
import Realm

//
// MARK: - BaseModel
class BaseModel: Object {
    
    //
    // MARK: - Variable
    dynamic var objectId: String!
    dynamic var createdAt: Date!
    dynamic var updatedAt: Date!
    
    /// Make objectId is primary key
    /// Obj must have primary key to support "Update" depend on primary key
    /// https://realm.io/docs/swift/latest/#updating-objects
    override static func primaryKey() -> String? {
        return Constants.Obj.ObjectId
    }
    
    //
    // MARK: - Init
    required init() {
        super.init()
        self.objectId = UUID.shortUUID()
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    convenience required init?(map: Map) {
        
        guard map.JSON[Constants.Obj.ObjectId] != nil else {
            Logger.error("Can't create obj in BaseModel. Missing ObjectId")
            return nil
        }
        
        guard map.JSON[Constants.Obj.KeyClassname] != nil else {
            Logger.error("Can't create obj in BaseModel. Missing ClassName")
            return nil
        }
        
        self.init()
    }
    
    required convenience init(value: Any, schema: RLMSchema) {
        self.init(value: value, schema: schema)
    }
    
    required convenience init(realm: RLMRealm, schema: RLMObjectSchema) {
        self.init(realm: realm, schema: schema)
    }
    
    //
    // MARK: - Mapping
    /// Mapping function
    func mapping(map: Map) {
        self.objectId <- map[Constants.Obj.ObjectId]
        self.createdAt <- (map[Constants.Obj.CreatedAt], APIDateTransform())
        self.updatedAt <- (map[Constants.Obj.UpdatedAt], APIDateTransform())
    }
}

//
// MARK: - Mappable
extension BaseModel: Mappable {}


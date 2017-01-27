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
    dynamic var objectId: String! = UUID.shortUUID()
    dynamic var createdAt: Date! = Date()
    dynamic var updatedAt: Date! = Date()
    
    /// Make objectId is primary key
    /// Obj must have primary key to support "Update" depend on primary key
    /// https://realm.io/docs/swift/latest/#updating-objects
    override static func primaryKey() -> String? {
        return Constants.Obj.ObjectId
    }
    
    //
    // MARK: - Mapping
    class func objectForMapping(map: Map) -> BaseMappable? {
        return BaseModel()
    }
    
    func mapping(map: Map) {
        self.objectId <- map[Constants.Obj.ObjectId]
        self.createdAt <- (map[Constants.Obj.CreatedAt], APIDateTransform())
        self.updatedAt <- (map[Constants.Obj.UpdatedAt], APIDateTransform())
    }
}

//
// MARK: - StaticMappable
extension BaseModel: StaticMappable {}


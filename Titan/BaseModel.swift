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

//
// MARK: - BaseModel
class BaseModel: Mappable, CustomStringConvertible {
    
    
    //
    // MARK: - Variable
    var objectId: String!
    var createdAt: Date!
    var updatedAt: Date!
    var className: String!
    
    
    /// Realm Obj class 
    var realmObjClass: BaseRealmObj.Type {
        get {
            return BaseRealmObj.self
        }
    }
    
    
    //
    // MARK: - Init
    init() {
        self.objectId = UUID().uuidString
        self.createdAt = Date()
        self.updatedAt = Date()
    }
    
    required init?(map: Map) {
        
        guard map.JSON[Constants.Obj.ObjectId] != nil else {
            Logger.error("Can't create obj in BaseModel. Missing ObjectId")
            return nil
        }
        
        guard map.JSON[Constants.Obj.KeyClassname] != nil else {
            Logger.error("Can't create obj in BaseModel. Missing ClassName")
            return nil
        }
    }
    
    
    //
    // MARK: - JSON Helper
    /// Get pretty JSON print
    var description: String {
        get {
            return Mapper().toJSONString(self, prettyPrint: true)!
        }
    }
    
    
    /// Mapping function
    func mapping(map: Map) {
        self.objectId <- map[Constants.Obj.ObjectId]
        self.createdAt <- (map[Constants.Obj.CreatedAt], APIDateTransform())
        self.updatedAt <- (map[Constants.Obj.UpdatedAt], APIDateTransform())
        self.className <- map[Constants.Obj.KeyClassname]
    }
    
    
    //
    // MARK: - Realm Convertible
    /// Convert from BaseModel -> RealmObj
    /// MUST Override on subclass to provide exactly behavior
    func convertToRealmObj() -> BaseRealmObj {
        
        let realmObj = BaseRealmObj()
        
        realmObj.objectId = self.objectId
        realmObj.createdAt = self.createdAt
        realmObj.updatedAt = self.updatedAt
        
        return realmObj
    }
}



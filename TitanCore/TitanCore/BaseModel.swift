//
//  BaseModel.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import ObjectMapper
import RealmSwift
import Realm
import RxSwift

//
// MARK: - BaseModel
open class BaseModel: Object {
    
    //
    // MARK: - Variable
    dynamic public var objectId: String! = UUID.shortUUID()
    dynamic public var createdAt: Date! = Date()
    dynamic public var updatedAt: Date! = Date()
    
    public let disposeBag = DisposeBag()
    
    /// Make objectId is primary key
    /// Obj must have primary key to support "Update" depend on primary key
    /// https://realm.io/docs/swift/latest/#updating-objects
    override open static func primaryKey() -> String? {
        return Constants.Obj.ObjectId
    }
    
    //
    // MARK: - Mapping
    public class func objectForMapping(map: Map) -> BaseMappable? {
        return BaseModel()
    }
    
    public func mapping(map: Map) {
        self.objectId <- map[Constants.Obj.ObjectId]
        self.createdAt <- (map[Constants.Obj.CreatedAt], APIDateTransform())
        self.updatedAt <- (map[Constants.Obj.UpdatedAt], APIDateTransform())
    }
    
    public func writeRealm<T>(_ block: (T)->()) {
        RealmManager.sharedManager.writeSync { _ in
            block(self as! T)
        }
    }
}

//
// MARK: - StaticMappable
extension BaseModel: StaticMappable {}

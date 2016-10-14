//
//  BaseModel.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable {
    
    //
    // MARK: - Variable
    let objectId: String = "guest"
    var createdAt: NSDate!
    var updatedAt: NSDate!
    var className: String!
    
    required init?(map: Map) {
        
        guard map.JSONDictionary[Constants.Obj.ObjectId] != nil else {
            Logger.error("Can't create obj in BaseModel. Missing ObjectId")
            return nil
        }
        
        guard map.JSONDictionary[Constants.Obj.KeyClassname] != nil else {
            Logger.error("Can't create obj in BaseModel. Missing ClassName")
            return nil
        }
    }
    
    override var description: String {
        get {
            return Mapper().toJSONString(self, prettyPrint: true)!
        }
    }
    
    func mapping(map: Map) {
        self.objectId <- map[Constants.Obj.ObjectId]
        self.createdAt <- (map[Constants.Obj.CreatedAt], APIDateTransform())
        self.updatedAt <- (map[Constants.Obj.UpdatedAt], APIDateTransform())
        self.className <- map[Constants.Obj.KeyClassname]
    }
    
}

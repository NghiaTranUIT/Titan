//
//  BaseModel.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseModel: Mappable, CustomStringConvertible {
    
    //
    // MARK: - Variable
    var objectId: String = "guest"
    var createdAt: NSDate!
    var updatedAt: NSDate!
    var className: String!
    
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
    
    var description: String {
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


//
// MARK: - Date Transform
public class APIDateTransform: TransformType {
    
    public typealias Object = NSDate
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(value: AnyObject?) -> NSDate? {
        
        if let value = value as? String {
            return NSDateHelper.globalDateFormatter.dateFromString(value)
        }
        
        if let value = value as? NSDate {
            return value
        }
        
        return nil
    }
    
    public func transformToJSON(value: NSDate?) -> String? {
        if let value = value {
            return NSDateHelper.globalDateFormatter.stringFromDate(value)
        }
        
        return nil
    }
}

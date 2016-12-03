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
    var objectId: String!
    var createdAt: NSDate!
    var updatedAt: NSDate!
    var className: String!
    
    
    //
    // MARK: - Init
    init() {
        
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
    
}


//
// MARK: - Mapping model
extension BaseModel {
    class func objectForDictionary(_ dictionary: [String: Any], classname c_n: String) -> BaseModel? {
        
        if c_n == Constants.Obj.Classname.Database {
            let model = self.mapperObject(DatabaseObj.self, dictionary: dictionary)
            
            return model
        }
        
        return nil
    }
    
    private class func mapperObject<T>(_ type: T.Type, dictionary: [String: Any]) -> T? where T: Mappable {
        
        guard let model = Mapper<T>().map(JSON: dictionary) else {
            return nil
        }
        
        return model
    }
}


//
// MARK: - Date Transform
public class APIDateTransform: TransformType {

    public typealias Object = NSDate
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> NSDate? {
        if let value = value as? String {
            return ApplicationManager.sharedInstance.globalDateFormatter.date(from: value) as NSDate?
        }
        
        if let value = value as? NSDate {
            return value
        }
        
        return nil
    }
    
    public func transformToJSON(_ value: NSDate?) -> String? {
        if let value = value {
            return ApplicationManager.sharedInstance.globalDateFormatter.string(from: value as Date)
        }
        
        return nil
    }
}

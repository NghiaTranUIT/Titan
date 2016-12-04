//
//  BaseModel+Mapping.swift
//  Titan
//
//  Created by Nghia Tran on 12/3/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import ObjectMapper


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
    
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    public func transformFromJSON(_ value: Any?) -> Date? {
        if let value = value as? String {
            return ApplicationManager.sharedInstance.globalDateFormatter.date(from: value) as Date?
        }
        
        if let value = value as? Date {
            return value
        }
        
        return nil
    }
    
    public func transformToJSON(_ value: Date?) -> String? {
        if let value = value {
            return ApplicationManager.sharedInstance.globalDateFormatter.string(from: value as Date)
        }
        
        return nil
    }
}

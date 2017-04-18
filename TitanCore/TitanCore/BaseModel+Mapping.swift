//
//  BaseModel+Mapping.swift
//  TitanCore
//
//  Created by Nghia Tran on 4/4/17.
//  Copyright © 2017 nghiatran. All rights reserved.
//

import Foundation
import ObjectMapper

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


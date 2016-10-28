//
//  JSONDecoder.swift
//  Titan
//
//  Created by Nghia Tran on 10/28/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

class JSONDecoder {

    // Share instance
    static let shared = JSONDecoder()
    
    //
    // MARK: - Public
    func decodeObject(_ obj: AnyObject) -> AnyObject {
        
        if let obj = obj as? [AnyObject] { // Check if Array of obj
            return self.decodeArray(obj)
        } else if let obj = obj as? [String: AnyObject] { // Or JSON
            return self.decodeDictionary(obj)
        }
        
        return obj
    }
}

//
// MARK: - Private
extension JSONDecoder {
    fileprivate func decodeArray(_ array: [AnyObject]) -> Any {
        
        var newArray: [AnyObject] = []
        
        for value in array {
            newArray.append(self.decodeObject(value))
        }
        
        return newArray
    }
    
    fileprivate func decodeDictionary(_ dictionary: [String: AnyObject]) -> Any {
        
        let id = dictionary[Constants.Obj.ObjectId] as? String
        let c_n = dictionary[Constants.Obj.KeyClassname] as? String
        let isProcess = dictionary[Constants.Obj.isProcess] as? Bool
        
        if isProcess == false || isProcess == nil {
            if let _ = id, let c_n = c_n { // => It' class obj
                let className = c_n
                
                var data: [String: AnyObject] = dictionary
                data[Constants.Obj.IsProcessed] = true
                
                return BaseModel.objectForDictionary(data, classname: className)!
            }
        }
        
        var newDictionary: [String: AnyObject] = [:]
        for (key, value) in dictionary {
            newDictionary[key] = self.decodeObject(value)
        }
        
        return newDictionary
    }
}

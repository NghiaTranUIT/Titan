//
//  JSONDecoder.swift
//  Titan
//
//  Created by Nghia Tran on 10/28/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa

protocol JSONDecodable {
    func decodeObject(_ obj: Any) -> Any
    func decodeArray(_ array: [Any]) -> Any
    func decodeDictionary(_ dictionary: [String: Any]) -> Any
}

class JSONDecoder: JSONDecodable {

    // Share instance
    static let shared = JSONDecoder()
    
    //
    // MARK: - Public
    func decodeObject(_ obj: Any) -> Any {
        
        if let obj = obj as? [Any] { // Check if Array of obj
            return self.decodeArray(obj)
        } else if let obj = obj as? [String: Any] { // Or JSON
            return self.decodeDictionary(obj)
        }
        
        return obj
    }
}

//
// MARK: - Private
extension JSONDecoder {
    func decodeArray(_ array: [Any]) -> Any {
        
        var newArray: [Any] = []
        
        for value in array {
            newArray.append(self.decodeObject(value))
        }
        
        return newArray
    }
    
    func decodeDictionary(_ dictionary: [String: Any]) -> Any {
        
        let id = dictionary[Constants.Obj.ObjectId] as? String
        let c_n = dictionary[Constants.Obj.KeyClassname] as? String
        let isProcess = dictionary[Constants.Obj.IsProcess] as? Bool
        
        if isProcess == false || isProcess == nil {
            if let _ = id, let c_n = c_n { // => It' class obj
                let className = c_n
                
                var data: [String: Any] = dictionary
                data[Constants.Obj.IsProcess] = true
                
                return BaseModel.objectForDictionary(data, classname: className)!
            }
        }
        
        var newDictionary: [String: Any] = [:]
        for (key, value) in dictionary {
            newDictionary[key] = self.decodeObject(value)
        }
        
        return newDictionary
    }
}

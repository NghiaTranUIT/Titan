//
//  QueryObj.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import ObjectMapper

public class QueryObj: BaseModel {

    //
    // MARK: - Variable
    public dynamic var name: String!
    public dynamic var content: String!
    
    //
    // MARK: - Mapping
    override public class func objectForMapping(map: Map) -> BaseMappable? {
        return QueryObj()
    }
    
    override public func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.Query.Name]
        self.content <- map[Constants.Obj.Query.Content]
    }
}

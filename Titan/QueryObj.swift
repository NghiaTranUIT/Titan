//
//  QueryObj.swift
//  Titan
//
//  Created by Nghia Tran on 10/14/16.
//  Copyright © 2016 fe. All rights reserved.
//

import ObjectMapper

class QueryObj: BaseModel {

    //
    // MARK: - Variable
    dynamic var name: String!
    dynamic var content: String!
    
    //
    // MARK: - Mapping
    override class func objectForMapping(map: Map) -> BaseMappable? {
        return QueryObj()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.Query.Name]
        self.content <- map[Constants.Obj.Query.Content]
    }
}

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
    var name: String!
    var content: String!
    
    //
    // MARK: - Override
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        self.name <- map[Constants.Obj.Query.Name]
        self.content <- map[Constants.Obj.Query.Content]
    }
}

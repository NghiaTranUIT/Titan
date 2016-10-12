//
//  GetListConnectionRequest.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import ReSwift

class GetListConnectionRequest {

}

extension GetListConnectionRequest: Request {
    
    var endpoint: String {
        get {
            return Constants.Endpoint.GetListConnectionFromCloudURL
        }
    }
    
    func toOperation() -> [BaseOperation] {
        let op = GetListConnectionCloudOperation(request: self)
        return [op]
    }
}

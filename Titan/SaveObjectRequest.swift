//
//  SaveObjectRequest.swift
//  Titan
//
//  Created by Nghia Tran on 11/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Foundation
import Alamofire

class SaveObjectRequest<Object> {
    required init() {}
}

extension SaveObjectRequest: Request {
    
    typealias T = Object
    
    var httpMethod: HTTPMethod {
        get {
            return .get
        }
    }
    
    var endpoint: String {
        get {
            return Constants.Endpoint.GetListConnectionFromCloudURL
        }
    }
}

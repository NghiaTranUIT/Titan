//
//  GetListConnectionRequest.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa
import ObjectMapper

class FetchListConnectionsRequest {
    required init() {}
}

extension FetchListConnectionsRequest: Request {
    
    var endpoint: String {
        get {
            return Constants.Endpoint.GetListConnectionFromCloudURL
        }
    }
}

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
import Alamofire
import ReSwift

class FetchListConnectionsRequest {
    required init() {}
}


//
// MARK: - Network
extension FetchListConnectionsRequest: Request {
    
    typealias T = [DatabaseObj]
    
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

//
// MARK: - Action
extension FetchListConnectionsRequest: Action {}

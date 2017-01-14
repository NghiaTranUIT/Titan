//
//  GetListConnectionRequest.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import Alamofire
import ReSwift
import ObjectMapper


class FetchListConnectionsRequest: Requestable {
    
    typealias T = [DatabaseObj]
    
    //
    // MARK: - Variable
    var httpMethod: HTTPMethod {get {return .get}}
    var endpoint: String {get {return Constants.Endpoint.GetListConnectionFromCloudURL}}
    
    
    /// Decode
    func decode(data: Any) -> T? {
        return Mapper<DatabaseObj>().mapArray(JSONObject: data) ?? []
    }
}


//
// MARK: - Action
extension FetchListConnectionsRequest: Action {}

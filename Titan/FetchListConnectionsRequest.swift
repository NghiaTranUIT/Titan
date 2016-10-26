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
import RxAlamofire
import ObjectMapper

class FetchListConnectionsRequest {
    
    typealias Response = Result<[DatabaseObj]>
    
    required init() {}
}

extension FetchListConnectionsRequest: Request {
    
    var endpoint: String {
        get {
            return Constants.Endpoint.GetListConnectionFromCloudURL
        }
    }
    
    func toDirver() -> Driver<Response> {
        return self.toAlamofireObservable()
            .observeOn(QueueManager.shared.backgroundQueue)
            .map { ( _: (response: HTTPURLResponse, json: Any)) -> Response in
                
                if let connections = Mapper<DatabaseObj>().mapArray(JSONObject: json) {
                    return Result.Success(connections)
                }
                
                return Result.Failure(NSError.defaultError())
            }
            .asDriver { error in
                return Driver.just(.Failure(error))
        }
    }
}

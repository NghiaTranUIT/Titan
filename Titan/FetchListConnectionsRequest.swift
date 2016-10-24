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

class FetchListConnectionsRequest: BaseRequest {
    
}

extension FetchListConnectionsRequest: Request {
    
    typealias Response = [DatabaseObj]
    
    var endpoint: String {
        get {
            return Constants.Endpoint.GetListConnectionFromCloudURL
        }
    }
    
    func toDirver() -> Driver<Response> {
        return self.toAlamofireObservable()
            .observeOn(ConcurrentDispatchQueueScheduler(qos: DispatchQoS.background))
                .map { ( _: (response: HTTPURLResponse, json: Any)) -> Response in
                    if let connections = Mapper<DatabaseObj>().mapArray(JSONObject: json) {
                        return connections
                    }
                    
                    return []
            }
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: [])
    }
}

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
    required init() {}
}

extension FetchListConnectionsRequest: Request {
    
    typealias Response = Result<[DatabaseObj]>
    
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
                        return Result.Success(connections)
                    }
                    
                    return Result.Failure(NSError.defaultError())
            }
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: Result.Failure(NSError.defaultError()))
    }
}

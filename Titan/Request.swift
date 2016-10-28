//
//  BaseRequest.swift
//  Titan
//
//  Created by Nghia Tran on 10/12/16.
//  Copyright © 2016 fe. All rights reserved.
//

import Cocoa
import RxSwift
import RxCocoa
import ReSwift
import Alamofire
import ObjectMapper

//
// MARK: - Request protocol
protocol Request: Action {
    
    associatedtype Response
    
    var basePath: String {get}
    
    var endpoint: String {get}
    
    var httpMethod: HTTPMethod {get}
    
    var param: Parameters? {get set}
    
    var header: HeaderParameter? {get}
    
    func toAlamofireObservable() -> Observable<(HTTPURLResponse, Any)>
    
    func toDirver() -> Driver<Response>
    
    init()
}

//
// MARK: - Conform URLConvitible from Alamofire
extension Request: URLRequestConvertible {
    func asURLRequest() -> URLRequest {
        
    }
}

//
// MARK: - Default implementation
extension Request {
    
    typealias Parameters = [String: Any]
    typealias HeaderParameter = [String: String]
    typealias JSONDictionary = [String: Any]
    
    var basePath: String {
        get {
            return Constants.Endpoint.BaseURL
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var param: Parameters? {
        get {
            return nil
        }
        set {
            param = newValue
        }
    }
    
    var header: HeaderParameter? {
        get {
            return ["Accept": "application/json"]
        }
    }
    
    var url: String {
        return basePath + endpoint
    }
    
    func toAlamofireObservable() -> Observable<(HTTPURLResponse, Any)> {
        Observable.create { (o) -> Disposable in
            let urlRequest = self.asURLRequest()
            Alamofire.request(urlRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON(completionHandler: { (response) in
                    
                    guard response.result.error == nil, let json = response.result.value as? [JSONDictionary] else {
                        o.onError(data.result.error ?? ServiceError.InvalidJSON)
                        o.onCompleted()
                        return
                    }
                    
                    // Parse here
                    let result = Mapper.
                    
                })
        }
    }
    
    init(param: Parameters?) {
        self.init()
        self.param = param
    }
}

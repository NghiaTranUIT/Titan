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
protocol Request: Action, URLRequestConvertible {
    
    associatedtype Response
    
    var basePath: String {get}
    
    var endpoint: String {get}
    
    var httpMethod: HTTPMethod {get}
    
    var param: Parameters? {get set}
    
    var header: HeaderParameter? {get}
    
    func toAlamofireObservable() -> Observable<(HTTPURLResponse, Any)>
    
    init()
}

//
// MARK: - Conform URLConvitible from Alamofire
extension Request {
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
    
    func toAlamofireObservable() -> Observable<Result> {
        return Observable.create { (o) -> Disposable in
            
            guard let urlRequest = try? self.asURLRequest() else {
                o.onError(Result.defaultErrorResult)
                o.onCompleted()
                return Disposables.create()
            }
            
            let request = Alamofire.request(urlRequest)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseJSON(completionHandler: { (response) in
                    
                    // Check error
                    if let error = response.result.error {
                        o.onError(Result.Failure(error))
                        o.onCompleted()
                        return
                    }
                    
                    // Check Response
                    guard let data = response.result.value else {
                        o.onError(Result.defaultErrorResult)
                        o.onCompleted()
                        return
                    }
                    
                    // Parse here
                    let result = JSONDecoder.shared.decodeObject(data)
                    o.onNext(Result.Success(result))
                    o.onCompleted()
                })
            
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    init(param: Parameters?) {
        self.init()
        self.param = param
    }
}
